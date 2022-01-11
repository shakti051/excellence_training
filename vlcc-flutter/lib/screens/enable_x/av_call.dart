import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:audio_session/audio_session.dart';
import 'package:enx_flutter_plugin/enx_flutter_plugin.dart';
import 'package:enx_flutter_plugin/enx_player_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vlcc/resources/assets_path.dart';
import 'package:wakelock/wakelock.dart';

class AVCallScreen extends StatefulWidget {
  final bool isVideoCall;
  final bool isAudioCallOngoing;
  final bool isVideoCallOngoing;

  final String token;
  final String otherUserName;
  final String videoRoomID;

  const AVCallScreen({
    Key? key,
    required this.isVideoCall,
    required this.isAudioCallOngoing,
    required this.isVideoCallOngoing,
    required this.token,
    required this.otherUserName,
    required this.videoRoomID,
  }) : super(key: key);

  @override
  _AVCallScreenState createState() => _AVCallScreenState();
}

class _AVCallScreenState extends State<AVCallScreen> {
  bool isAudioMuted = false;
  bool isVideoMuted = false;
  bool isRemoteVideoMuted = false;
  bool isRemoteAudioMuted = false;
  String otherUserName = '';
  bool didUserJoinCall = false;
  late Timer timer;

  @override
  void initState() {
    otherUserName = widget.otherUserName;
    super.initState();
    // log('${widget.isAudioCallOngoing}',
    //     name: 'widget.isAudioCallOngoing timer');
    // log('${widget.isVideoCallOngoing}',
    //     name: 'widget.isVideoCallOngoing timer');
    // if (widget.isAudioCallOngoing == false &&
    //     widget.isVideoCallOngoing == false) {
    //   log('vide audio both = false', name: 'timer');
    //   initTimer();
    // }
    initAVCall();
    _addEnxrtcEventHandlers();
  }

  initTimer() {
    timer = Timer(
      const Duration(seconds: 60),
      () {
        log('$didUserJoinCall', name: 'didUserJoinCall timer');
        if (didUserJoinCall) {
          return;
        } else {
          _disconnectRoom();
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    // try {
    //   if (timer != null) {
    //     timer.cancel();
    //   }
    // } catch (e) {}
  }

  initAVCall() async {
    Wakelock.enable();
    await _checkPermission();
    await initEnxRtc();
  }

  Future<void> _checkPermission() async {
    Map<Permission, PermissionStatus> statuses;
    if (Platform.isAndroid) {
      statuses = await [
        Permission.camera,
        Permission.microphone,
        Permission.storage,
        Permission.phone
      ].request();
    } else {
      statuses = await [
        Permission.camera,
        Permission.microphone,
        Permission.storage,
      ].request();
    }

    log('$statuses', name: 'permission');

    var cameraPermissionstatus = statuses[Permission.camera];
    log('$cameraPermissionstatus', name: 'cameraPermissionstatus statutes');

    var phonePermissionstatus = statuses[Permission.phone];
    log('$phonePermissionstatus', name: 'cameraPermissionstatus statutes');

    var micPermissionstatus = statuses[Permission.microphone];
    log('$micPermissionstatus', name: 'micPermissionstatus statutes');

    var storagePermissionStatus = statuses[Permission.storage];
    log('$storagePermissionStatus', name: 'storagePermissionStatus statutes');

    if (cameraPermissionstatus == PermissionStatus.granted) {
      print('cameraPermissionstatus Granted');
    } else if (cameraPermissionstatus == PermissionStatus.denied) {
      print('cameraPermissionstatus denied');
      await Permission.camera.request();
      showPermissionAlertDialog(context,
          message: 'Please allow permission for camera access');
    } else if (cameraPermissionstatus == PermissionStatus.permanentlyDenied) {
      print('cameraPermissionstatus Permanently Denied');
      await Permission.camera.request();
      showPermissionAlertDialog(context,
          message: 'Please allow permission for camera access');
    }

    if (micPermissionstatus == PermissionStatus.granted) {
      print('micPermissionstatus Granted');
    } else if (micPermissionstatus == PermissionStatus.denied) {
      print('micPermissionstatus denied');
      showPermissionAlertDialog(context,
          message: 'Please allow permission for microphone access');
    } else if (micPermissionstatus == PermissionStatus.permanentlyDenied) {
      print('micPermissionstatus Permanently Denied');
      showPermissionAlertDialog(context,
          message: 'Please allow permission for microphone access');
      await Permission.microphone.request();
    }
    if (Platform.isAndroid) {
      if (phonePermissionstatus == PermissionStatus.granted) {
        print('micPermissionstatus Granted');
      } else if (phonePermissionstatus == PermissionStatus.denied) {
        print('micPermissionstatus denied');
        showPermissionAlertDialog(context,
            message: 'Please allow permission for phone call access');
      } else if (phonePermissionstatus == PermissionStatus.permanentlyDenied) {
        print('micPermissionstatus Permanently Denied');
        showPermissionAlertDialog(context,
            message: 'Please allow permission for phone call access');
        await Permission.phone.request();
      }
    }

    if (storagePermissionStatus == PermissionStatus.granted) {
      print('storagePermissionStatus Granted');
    } else if (storagePermissionStatus == PermissionStatus.denied) {
      print('storagePermissionStatus denied');
    } else if (storagePermissionStatus == PermissionStatus.permanentlyDenied) {
      print('storagePermissionStatus Permanently Denied');
    }

    setState(() {});
  }

/*
Step 1

Connecting and joining a Room is a complex chain of events. 
You will need to ensure success status of previous event to proceed to the next event. 
The following basic steps are required to join room successfully

1. Initiate Room & Connect
2. If connected, initiate Stream.
3. Publish Stream

*/

  Future<void> initEnxRtc() async {
    // final session = await AudioSession.instance;
    // await session.setActive(true);

    // bool isAudioOnly = widget.isVideoCall ? false : true;

    Map<String, dynamic> videoSize = {
      'minWidth': 320,
      'minHeight': 180,
      'maxWidth': MediaQuery.of(context).size.width,
      'maxHeight': MediaQuery.of(context).size.height
    };
    Map<String, dynamic> localInfo = {
      'audio': true,
      'video': true,
      'data': true,
      'framerate': 15,
      'maxVideoBW': 1500,
      'minVideoBW': 150,
      'audioMuted': false,
      'videoMuted': false,
      'name': 'flutter',
      'videoSize': videoSize
    };

    Map<String, dynamic> roomInfo = {
      'allow_reconnect': true,
      'number_of_attempts': 3,
      'timeout_interval': 20,
      'audio_only': false,
      'forceTurn': false
    };

    List options = [];

    /*
    Method: 
    static Future<void> joinRoom(String token, Map<String, dynamic> localInfo, Map<String, dynamic> roomInfo, List<dynamic> advanceOptions)
    */

    // await EnxRtc.joinRoom(widget.token, localInfo, roomInfo, options);
    await EnxRtc.joinRoom(widget.token, localInfo, {}, []);
  }

  _afterLayout(_) {
    // _addEnxrtcEventHandlers();
  }
  int uuid = 0;
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance?.addPostFrameCallback(_afterLayout);
    return WillPopScope(
      onWillPop: () {
        _disconnectRoom();
        return Future.value(true);
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: UserCallingCard(
                isAnimating: otherUserName.isEmpty ? true : false,
                name:
                    otherUserName.isEmpty ? 'connecting...' : '$otherUserName',
                image: SVGAsset.phone,
                subTitle: isRemoteVideoMuted
                    ? 'has stopped their video'
                    : otherUserName.isEmpty
                        ? ''
                        : 'is now connected',
              ),
            ),
            if (widget.isAudioCallOngoing)
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: UserCallingCard(
                  isAnimating: otherUserName.isEmpty ? true : false,
                  name: '$otherUserName',
                  image: SVGAsset.phone,
                  subTitle: isRemoteAudioMuted
                      ? 'has muted their audio'
                      : otherUserName.isEmpty
                          ? ''
                          : 'is now connected',
                ),
              ),
            if (widget.isVideoCall)
              if (!isRemoteVideoMuted)
                Column(
                  children: [
                    Expanded(
                      child: Container(color: Colors.black, child: _viewRows()),
                    ),
                  ],
                ),
            Visibility(
              maintainSize: true,
              maintainAnimation: true,
              maintainSemantics: true,
              maintainInteractivity: true,
              maintainState: true,
              visible: widget.isVideoCall,
              child: Container(
                // color: Colors.red,
                margin: EdgeInsets.only(top: 24),
                alignment: Alignment.topRight,
                height: 192,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  height: 192,
                  width: 108,
                  child:
                      EnxPlayerWidget(0, local: true, width: 108, height: 192),
                ),
              ),
            )
          ],
        ),
        bottomNavigationBar: _bottomNavigationBar(),
      ),
    );
  }

  Container _bottomNavigationBar() {
    return Container(
      color: Colors.transparent,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              RoundedButton(
                color: Color(0xFF2C384D),
                iconColor: Colors.white,
                size: 48,
                iconSrc: isAudioMuted ? SVGAsset.micOff : SVGAsset.mic,
                press: () async {
                  setState(() {
                    _toggleAudio();
                  });
                },
              ),
              Spacer(),
              widget.isVideoCall
                  ? RoundedButton(
                      color: Color(0xFF2C384D),
                      iconColor: Colors.white,
                      size: 48,
                      iconSrc:
                          isVideoMuted ? SVGAsset.videoOff : SVGAsset.video,
                      press: () {
                        if (widget.isVideoCall) {
                          setState(() {
                            _toggleVideo();
                          });
                        }
                      },
                    )
                  : SizedBox(),
              Spacer(),
              RoundedButton(
                color: Color(0xFF2C384D),
                iconColor: Colors.white,
                size: 48,
                iconSrc: SVGAsset.info,
                press: _toggleSpeaker,
              ),
              Spacer(),
              RoundedButton(
                color: Color(0xFFFF1E46),
                iconColor: Colors.white,
                size: 48,
                iconSrc: SVGAsset.endCall,
                press: () {
                  _disconnectRoom();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<dynamic>? deviceList;
  void _toggleSpeaker() async {
    List<dynamic> list = await EnxRtc.getDevices();
    setState(() {
      deviceList = list;
    });
    log('deviceList');
    // log(deviceList.toString());
    createDialog();
  }

  createDialog() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
              // title: Text('Media Devices'),
              height: 120,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: deviceList!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Text(deviceList![index].toString()),
                          onTap: () =>
                              _setMediaDevice(deviceList![index].toString()),
                        );
                      },
                    ),
                  )
                ],
              ));
        });
  }

  void _setMediaDevice(String value) {
    Navigator.of(context, rootNavigator: true).pop();
    EnxRtc.switchMediaDevice(value);
  }

  Widget _viewRows() {
    return Column(
      children: <Widget>[
        for (final widget in _renderWidget)
          Expanded(
            child: Container(
              child: widget,
            ),
          ),
      ],
    );
  }

  List<int> _remoteUsers = [];
  Iterable<Widget> get _renderWidget sync* {
    for (final streamId in _remoteUsers) {
      double width = MediaQuery.of(context).size.width;
      double height = MediaQuery.of(context).size.height;
      yield EnxPlayerWidget(streamId,
          local: false, width: width.toInt(), height: height.toInt());
    }
  }

  int flushbarDurationInMilliseconds = 2000;

  void _addEnxrtcEventHandlers() async {
    EnxRtc.onRoomConnected = (Map<dynamic, dynamic> map) async {
      log('${map.toString()}', name: 'onRoomConnected', error: map);

      setState(() {
        EnxRtc.publish();
      });
    };

    EnxRtc.onRemoteStreamAudioMute = (Map<dynamic, dynamic> map) {
      log('onRemoteStreamAudioMute',
          name: 'onRemoteStreamAudioMute', error: map.toString());
      setState(() {
        try {
          isRemoteAudioMuted = map['user']['audioMuted'];
        } catch (e) {}
      });
      showFlushBar(
        context,
        0,
        '$otherUserName muted their audio',
        durationInMilliseconds: flushbarDurationInMilliseconds,
        flushbarPosition: FlushbarPosition.TOP,
      );
    };

    EnxRtc.onRemoteStreamAudioUnMute = (Map<dynamic, dynamic> map) {
      log('onRemoteStreamAudioUnMute',
          name: 'onRemoteStreamAudioUnMute', error: map.toString());
      setState(() {
        try {
          isRemoteAudioMuted = map['user']['audioMuted'];
        } catch (e) {}
        showFlushBar(
          context,
          1,
          '$otherUserName unmuted their audio',
          durationInMilliseconds: flushbarDurationInMilliseconds,
          flushbarPosition: FlushbarPosition.TOP,
        );
      });
    };
    EnxRtc.onRemoteStreamVideoMute = (Map<dynamic, dynamic> map) {
      setState(() {
        try {
          isRemoteVideoMuted = map['user']['videoMuted'];
        } catch (e) {}

        log('onRemoteStreamVideoMute',
            name: 'onRemoteStreamVideoMute', error: map.toString());
      });
      showFlushBar(
        context,
        0,
        '$otherUserName stopped their video',
        durationInMilliseconds: flushbarDurationInMilliseconds,
        flushbarPosition: FlushbarPosition.TOP,
      );
    };

    EnxRtc.onRemoteStreamVideoUnMute = (Map<dynamic, dynamic> map) {
      setState(() {
        try {
          isRemoteVideoMuted = map['user']['videoMuted'];
        } catch (e) {}
        log('${map['user']['videoMuted']}',
            name: 'onRemoteStreamVideoUnMute', error: map.toString());
      });
    };

    EnxRtc.onRoomError = (Map<dynamic, dynamic> map) {
      setState(() {
        log('onRoomError', name: 'onRoomError', error: map.toString());
      });
    };

    EnxRtc.onRoomDisConnected = (Map<dynamic, dynamic> map) {
      log(map.toString(), name: 'onRoomDisConnected');
    };

    EnxRtc.onConnectionLost = (Map<dynamic, dynamic> map) {
      // In case connection lost due to internet lose
      setState(() {});
    };

    EnxRtc.onConnectionInterrupted = (Map<dynamic, dynamic> map) {
      // In case any interruption in connection
      setState(() {});
    };

    EnxRtc.onUserReconnectSuccess = (Map<dynamic, dynamic> map) {
      // When reconnect done successfully
      setState(() {});
    };

    EnxRtc.onPublishedStream = (Map<dynamic, dynamic> map) async {
      log(map.toString(), name: 'onPublishedStream');
      uuid = UniqueKey().hashCode;
      log(uuid.toString(), name: 'uuid ');
      // uuid.hashCode;
      setState(() {
        // EnxRtc.setupVideo(uuid, uuid + 1, true, 300, 200);
        EnxRtc.setupVideo(0, 0, true, 300, 200);
      });
    };

    EnxRtc.onStreamAdded = (Map<dynamic, dynamic> map) async {
      log(map.toString(), name: 'onStreamAdded');

      try {
        EnxRtc.switchMediaDevice('Speaker');
      } catch (e) {
        log('', name: 'onStreamAdded switch error', error: e);
      }

      String streamId = '';
      setState(() {
        streamId = map['streamId'];
        EnxRtc.subscribe(streamId);
      });

      // setState(() {});
    };

    EnxRtc.onNotifyDeviceUpdate = (String deviceName) {
      log(deviceName, name: 'onNotifyDeviceUpdate');
      setState(() {});
    };

    EnxRtc.onActiveTalkerList = (Map<dynamic, dynamic> map) {
      log(map.toString(), name: 'onActiveTalkerList');
      final items = (map['activeList'] as List)
          .map((i) => new ActiveListModel.fromJson(i));
      if (items.length > 0) {
        setState(() {
          for (final item in items) {
            if (!_remoteUsers.contains(item.streamId)) {
              log(
                '_remoteUsers \n' + map.toString(),
                name: 'onActiveTalkerList',
              );
              _remoteUsers.add(item.streamId);
            }
          }
        });
      }
    };

    EnxRtc.onEventError = (Map<dynamic, dynamic> map) {
      setState(() {
        log(
          'onEventError',
          name: 'onEventError',
          error: map.toString(),
        );
      });
    };

    EnxRtc.onEventInfo = (Map<dynamic, dynamic> map) {
      log(map.toString(), name: 'onEventInfo');
      setState(() {});
    };

    EnxRtc.onUserConnected = (Map<dynamic, dynamic> map) {
      log(map.toString(), name: 'onUserConnected');
      otherUserName = map['name'];
      setState(() {
        didUserJoinCall = true;
        showFlushBar(
          context,
          1,
          '$otherUserName has joined the call',
          durationInMilliseconds: flushbarDurationInMilliseconds,
          flushbarPosition: FlushbarPosition.TOP,
        );
      });
    };

    EnxRtc.onUserDisConnected = (Map<dynamic, dynamic> map) async {
      log(map.toString(), name: 'onUserDisConnected');
      setState(() {
        _showAlert(
            context: context, message: '${map['name']} disconnected call');
      });
    };

    EnxRtc.onAudioEvent = (Map<dynamic, dynamic> map) {
      log(map.toString(), name: 'onAudioEvent');
      setState(() {
        if (map['msg'].toString().toLowerCase() == "audio off") {
          isAudioMuted = true;
        } else {
          isAudioMuted = false;
        }
      });
    };

    EnxRtc.onVideoEvent = (Map<dynamic, dynamic> map) {
      log(map.toString(), name: 'onVideoEvent');
      setState(() {
        if (map['msg'].toString().toLowerCase() == "video off") {
          isVideoMuted = true;
        } else {
          isVideoMuted = false;
        }
      });
    };
  }

  void _disconnectRoom() async {
    await EnxRtc.disconnect();

    Navigator.pop(context);
  }

  void _toggleAudio() async {
    if (isAudioMuted) {
      EnxRtc.muteSelfAudio(false);
    } else {
      EnxRtc.muteSelfAudio(true);
    }
    isAudioMuted = !isAudioMuted;
  }

  void _toggleVideo() {
    if (isVideoMuted) {
      EnxRtc.muteSelfVideo(false);
    } else {
      EnxRtc.muteSelfVideo(true);
    }
    isVideoMuted = !isVideoMuted;
  }

  // void _toggleSpeaker() async {
  //   List<dynamic> list = await EnxRtc.getDevices();
  //   setState(() {
  //     deviceList = list;
  //   });
  //   print('deviceList');
  //   print(deviceList);
  //   createDialog();
  // }

  showPermissionAlertDialog(BuildContext context, {required String message}) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text("Go to settings"),
      onPressed: () async {
        Navigator.of(context).pop();
        await openAppSettings();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Allow Permissions"),
      content: Text(message),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  _showAlert({required BuildContext context, required String message}) {
    Widget endCallButton = TextButton(
      child: Text("End Call"),
      onPressed: () {
        Navigator.of(context).pop();
        _disconnectRoom();
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Alert"),
      content: Text(message),
      actions: [
        endCallButton,
      ],
    );

    // show the dialog
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

class ActiveList {
  bool active;
  List<ActiveListModel> activeList = [];
  String event;

  ActiveList(this.active, this.activeList, this.event);

  factory ActiveList.fromJson(Map<dynamic, dynamic> json) {
    return ActiveList(
      json['active'] as bool,
      (json['activeList'] as List).map((i) {
        return ActiveListModel.fromJson(i);
      }).toList(),
      json['event'] as String,
    );
  }
}

class ActiveListModel {
  String name;
  int streamId;
  String clientId;
  String videoaspectratio;
  String mediatype;
  bool videomuted;
  String reason;

  ActiveListModel({
    required this.name,
    required this.streamId,
    required this.clientId,
    required this.videoaspectratio,
    required this.mediatype,
    required this.videomuted,
    required this.reason,
  });

  // convert Json to an exercise object
  factory ActiveListModel.fromJson(Map<dynamic, dynamic> json) {
    int streamId = int.parse(json['streamId'].toString());
    String name = json['name'].toString();
    String clientId = json['clientId'].toString();
    String videoaspectratio = json['videoaspectratio'].toString();
    String mediatype = json['mediatype'].toString();
    bool videomuted = json['videomuted'] ?? false;
    String reason = json['reason'].toString();
    return ActiveListModel(
      name: name,
      streamId: streamId,
      clientId: clientId,
      videoaspectratio: videoaspectratio,
      mediatype: mediatype,
      videomuted: false,
      reason: reason,
    );
  }
}

class UserCallingCard extends StatelessWidget {
  const UserCallingCard({
    Key? key,
    required this.name,
    required this.image,
    required this.subTitle,
    required this.isAnimating,
  }) : super(key: key);

  final String name, image;
  final String subTitle;
  final bool isAnimating;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            // color: Colors.blue,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Visibility(
                  visible: isAnimating,
                  child: Lottie.asset(
                    'assets/pulse1.json',
                    width: 160.0,
                    height: 160.0,
                    fit: BoxFit.fill,
                    repeat: true,
                    alignment: Alignment.center,
                  ),
                ),
                DialUserPic(
                  size: 112,
                  image: image,
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Text(
            name,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: 'BeViteReg',
            ),
          ),
          Text(
            subTitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white60,
              fontFamily: 'BeViteReg',
            ),
          )
        ],
      ),
    );
  }
}

class DialUserPic extends StatelessWidget {
  const DialUserPic({
    Key? key,
    this.size = 192,
    required this.image,
  }) : super(key: key);

  final double size;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(40 / 192 * size),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: Image.asset(
        image,
        color: Colors.black,
        fit: BoxFit.cover,
      ),
    );
  }
}

void showFlushBar(
  BuildContext context,
  int type,
  String message, {
  int durationInMilliseconds = 2040,
  FlushbarPosition flushbarPosition = FlushbarPosition.BOTTOM,
}) {
  Flushbar(
    margin: EdgeInsets.all(8.0),
    borderRadius: BorderRadius.circular(12),
    reverseAnimationCurve: Curves.easeInOut,
    icon: const Icon(
      Icons.info_outline_rounded,
      size: 28,
      color: Colors.white,
    ),
    backgroundColor: (type == 0) ? Color(0xffFF543E) : Color(0xff3479E7),
    messageText: Text(
      message,
      style: TextStyle(
          color: Colors.white, fontSize: 14.0, fontFamily: 'BeViteLight'),
    ),
    duration: Duration(milliseconds: durationInMilliseconds),
    forwardAnimationCurve: Curves.easeInOutExpo,
    flushbarPosition: flushbarPosition,
  ).show(context);
}

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    Key? key,
    this.size = 64,
    required this.iconSrc,
    this.color = Colors.white,
    this.iconColor = Colors.black,
    required this.press,
  }) : super(key: key);

  final double size;
  final String iconSrc;
  final Color color, iconColor;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      width: 80,
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(color),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(100)),
            ),
          ),
        ),
        onPressed: press,
        child: SvgPicture.asset(iconSrc, color: iconColor),
      ),
    );
  }
}
