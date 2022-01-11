import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:another_flushbar/flushbar.dart';
import 'package:enx_flutter_plugin/enx_flutter_plugin.dart';
import 'package:enx_flutter_plugin/enx_player_widget.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vlcc/screens/enable_x/av_call.dart';

class MyConfApp extends StatefulWidget {
  final String token;
  const MyConfApp({Key? key, required this.token}) : super(key: key);
  @override
  Conference createState() => Conference();
}

class Conference extends State<MyConfApp> {
  bool isAudioMuted = false;
  bool isVideoMuted = false;

  @override
  void initState() {
    super.initState();
    _checkPermission().then((value) {
      log('here 1');
      initEnxRtc();
      _addEnxrtcEventHandlers();
    });
  }

  Future<void> _checkPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.microphone,
      Permission.storage,
      Permission.phone,
    ].request();
    log('$statuses', name: 'permission');
    var cameraPermissionstatus = statuses[Permission.camera];
    log('$cameraPermissionstatus', name: 'cameraPermissionstatus statutes');
    var micPermissionstatus = statuses[Permission.microphone];
    log('$micPermissionstatus', name: 'micPermissionstatus statutes');
    var storagePermissionStatus = statuses[Permission.storage];
    log('$storagePermissionStatus', name: 'storagePermissionStatus statutes');
    var phonePermissionStatus = statuses[Permission.phone];
    log('$phonePermissionStatus', name: 'phonePermissionStatus statutes');
    if (cameraPermissionstatus == PermissionStatus.granted) {
      log('cameraPermissionstatus Granted');
    } else if (cameraPermissionstatus == PermissionStatus.denied) {
      log('cameraPermissionstatus denied');
      await Permission.camera.request();
      // showPermissionAlertDialog(context,
      //     message: 'Please allow permission for camera access');
    } else if (cameraPermissionstatus == PermissionStatus.permanentlyDenied) {
      log('cameraPermissionstatus Permanently Denied');
      await Permission.camera.request();
      // showPermissionAlertDialog(context,
      //     message: 'Please allow permission for camera access');
    }
    if (micPermissionstatus == PermissionStatus.granted) {
      log('micPermissionstatus Granted');
    } else if (micPermissionstatus == PermissionStatus.denied) {
      log('micPermissionstatus denied');
      // showPermissionAlertDialog(context,
      //     message: 'Please allow permission for microphone access');
    } else if (micPermissionstatus == PermissionStatus.permanentlyDenied) {
      log('micPermissionstatus Permanently Denied');
      // showPermissionAlertDialog(context,
      //     message: 'Please allow permission for microphone access');
      await Permission.microphone.request();
    }
    if (storagePermissionStatus == PermissionStatus.granted) {
      log('storagePermissionStatus Granted');
    } else if (storagePermissionStatus == PermissionStatus.denied) {
      log('storagePermissionStatus denied');
    } else if (storagePermissionStatus == PermissionStatus.permanentlyDenied) {
      log('storagePermissionStatus Permanently Denied');
    }
    if (phonePermissionStatus == PermissionStatus.granted) {
      log('phonePermissionStatus Granted');
    } else if (phonePermissionStatus == PermissionStatus.denied) {
      log('phonePermissionStatus denied');
    } else if (phonePermissionStatus == PermissionStatus.permanentlyDenied) {
      log('phonePermissionStatus Permanently Denied');
    }
    setState(() {});
  }

  Future<void> initEnxRtc() async {
    Map<String, dynamic> map2 = {
      'minWidth': 320,
      'minHeight': 180,
      'maxWidth': 640,
      'maxHeight': 360,
    };
    Map<String, dynamic> map1 = {
      'audio': true,
      'video': true,
      'data': true,
      'framerate': 15,
      'maxVideoBW': 1500,
      'minVideoBW': 150,
      'audioMuted': false,
      'videoMuted': false,
      'name': 'flutter',
      'videoSize': map2
    };
    log('here 2');
    Map<String, dynamic> roomInfo = {
      'allow_reconnect': true,
      'number_of_attempts': 3,
      'timeout_interval': 20,
      'audio_only': false,
      'forceTurn': false
    };
    await EnxRtc.joinRoom(widget.token, map1, roomInfo, []);
    log('here 3');
  }

  int flushbarDurationInMilliseconds = 2000;
  void _addEnxrtcEventHandlers() {
    log('here 4');
    EnxRtc.onRoomConnected = (Map<dynamic, dynamic> map) {
      log(map.toString(), name: 'onRoomConnected', error: map);

      setState(() {
        EnxRtc.publish;
      });
      // setState(EnxRtc.publish);
    };
    log('here 5');
    EnxRtc.onPublishedStream = (Map<dynamic, dynamic> map) {
      setState(() {
        log(map.toString(), name: 'onPublishedStream');
        EnxRtc.setupVideo(0, 0, true, 300, 200);
      });
    };

    // EnxRtc.onPublishedStream = (Map<dynamic, dynamic> map) async {
    //   log(map.toString(), name: 'onPublishedStream');
    //   uuid = UniqueKey().hashCode;
    //   log(uuid.toString(), name: 'uuid ');
    //   // uuid.hashCode;
    //   setState(() {
    //     EnxRtc.setupVideo(uuid, uuid + 1, true, 300, 200);
    //   });
    // };
    log('here 6');
    EnxRtc.onStreamAdded = (Map<dynamic, dynamic> map) {
      log(map.toString(), name: 'onStreamAdded');
      log(map['streamId'].toString(), name: 'onStreamAdded');

      String streamId = '';
      try {
        EnxRtc.switchMediaDevice('Speaker');
      } catch (e) {
        log('', name: 'onStreamAdded switch error', error: e);
      }
      setState(() {
        streamId = map['streamId'] ?? '';
      });
      EnxRtc.subscribe(streamId);
    };
    log('here 7');
    EnxRtc.onRoomError = (Map<dynamic, dynamic> map) {
      setState(() {
        log('onRoomError', name: 'onRoomError', error: map.toString());
      });
    };

    EnxRtc.onRoomDisConnected = (Map<dynamic, dynamic> map) {
      log(map.toString(), name: 'onRoomDisConnected');
    };

    EnxRtc.onNotifyDeviceUpdate = (String deviceName) {
      log(deviceName, name: 'onNotifyDeviceUpdate');
      setState(() {});
    };

    log('here 8');
    EnxRtc.onActiveTalkerList = (Map<dynamic, dynamic> map) {
      log(map.toString(), name: 'onActiveTalkerList');
      log('here 9');
      final items =
          (map['activeList'] as List).map((i) => ActiveListModel.fromJson(i));
      if (items.isNotEmpty) {
        log('here 10');
        setState(() {
          for (final item in items) {
            if (!_remoteUsers.contains(item.streamId)) {
              log(
                '_remoteUsers \n$map',
                name: 'onActiveTalkerList',
              );
              _remoteUsers.add(item.streamId);
            }
          }
        });
      }
    };
    log('here 11');
    EnxRtc.onEventError = (Map<dynamic, dynamic> map) {
      log(
        'onEventError',
        name: 'onEventError',
        error: map.toString(),
      );
    };
    log('here 12');
    EnxRtc.onEventInfo = (Map<dynamic, dynamic> map) {
      setState(() {
        log(map.toString(), name: 'onEventInfo');
      });
    };
    log('here 13');
    EnxRtc.onUserConnected = (Map<dynamic, dynamic> map) {
      log(map.toString(), name: 'onUserConnected');
      // otherUserName = map['name'];
      setState(() {
        // didUserJoinCall = true;
        showFlushBar(
          context,
          1,
          '${map['name']} has joined the call',
          durationInMilliseconds: flushbarDurationInMilliseconds,
          flushbarPosition: FlushbarPosition.TOP,
        );
      });
    };
    EnxRtc.onUserDisConnected = (Map<dynamic, dynamic> map) {
      String otherUserName = map['name'] ?? '';
      setState(() {
        // didUserJoinCall = true;
        showFlushBar(
          context,
          1,
          '$otherUserName disconnected call',
          durationInMilliseconds: flushbarDurationInMilliseconds,
          flushbarPosition: FlushbarPosition.TOP,
        );
      });
    };
    log('here 14');
    EnxRtc.onRoomDisConnected = (Map<dynamic, dynamic> map) {
      setState(() {
        log(map.toString(), name: 'onRoomDisConnected');
        Navigator.pop(context);
      });
    };
    log('here 15');
    EnxRtc.onAudioEvent = (Map<dynamic, dynamic> map) {
      log(map.toString(), name: 'onAudioEvent');
      setState(() {
        if (map['msg'].toString() == "Audio Off") {
          isAudioMuted = true;
        } else {
          isAudioMuted = false;
        }
      });
    };
    log('here 16');
    EnxRtc.onVideoEvent = (Map<dynamic, dynamic> map) {
      log(map.toString(), name: 'onVideoEvent');
      setState(() {
        if (map['msg'].toString() == "Video Off") {
          isVideoMuted = true;
        } else {
          isVideoMuted = false;
        }
      });
    };
    log('here 17');
  }

  void _setMediaDevice(String value) {
    Navigator.of(context, rootNavigator: true).pop();
    EnxRtc.switchMediaDevice(value);
  }

  createDialog() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
              // title: Text('Media Devices'),
              // height: 200,
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

  void _disconnectRoom() {
    EnxRtc.disconnect();
    Navigator.pop(context);
  }

  void _toggleAudio() {
    if (isAudioMuted) {
      EnxRtc.muteSelfAudio(false);
    } else {
      EnxRtc.muteSelfAudio(true);
    }
  }

  void _toggleVideo() {
    if (isVideoMuted) {
      EnxRtc.muteSelfVideo(false);
    } else {
      EnxRtc.muteSelfVideo(true);
    }
  }

  void _toggleSpeaker() async {
    List<dynamic> list = await EnxRtc.getDevices();
    setState(() {
      deviceList = list;
    });
    log('deviceList');
    log(deviceList.toString());
    createDialog();
  }

  void _toggleCamera() {
    EnxRtc.switchCamera();
  }

  int remoteView = -1;
  List<dynamic>? deviceList;

  Widget _viewRows() {
    return Column(
      children: <Widget>[
        for (final widget in _renderWidget)
          Expanded(
            child: Container(
              child: widget,
            ),
          )
      ],
    );
  }

  Iterable<Widget> get _renderWidget sync* {
    for (final streamId in _remoteUsers) {
      double width = MediaQuery.of(context).size.width;
      yield EnxPlayerWidget(streamId,
          local: false, width: width.toInt(), height: 380);
    }
  }

  final _remoteUsers = <int>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meet'),
      ),
      body: Container(
        color: Colors.black,
        child: Column(
          children: [
            Container(
                alignment: Alignment.topRight,
                height: 90,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  color: Colors.black,
                  height: 100,
                  width: 100,
                  child:
                      EnxPlayerWidget(0, local: true, width: 100, height: 100),
                )),
            Stack(
              children: <Widget>[
                Card(
                  color: Colors.black,
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    height: MediaQuery.of(context).size.height - 200,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: Container(child: _viewRows()),
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 30,
                  left: 20,
                  right: 20,
                  child: Container(
                    color: Colors.white,
                    // height: 100,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 6,
                          child: MaterialButton(
                            child: isAudioMuted
                                ? Icon(
                                    Icons.mic_off,
                                    color: Colors.red,
                                  )
                                : Icon(
                                    Icons.mic,
                                    color: Colors.green,
                                  ),
                            onPressed: _toggleAudio,
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 6,
                          child: MaterialButton(
                            child: Icon(Icons.camera),
                            onPressed: _toggleCamera,
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 6,
                          child: MaterialButton(
                            child: isVideoMuted
                                ? Icon(
                                    Icons.videocam_off,
                                    color: Colors.red,
                                  )
                                : Icon(
                                    Icons.videocam,
                                    color: Colors.green,
                                  ),
                            onPressed: _toggleVideo,
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 6,
                          child: MaterialButton(
                            child: Icon(Icons.speaker),
                            onPressed: _toggleSpeaker,
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 6,
                          child: MaterialButton(
                            child: Icon(Icons.call_end, color: Colors.red),
                            onPressed: _disconnectRoom,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
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

  ActiveListModel(this.name, this.streamId, this.clientId,
      this.videoaspectratio, this.mediatype, this.videomuted, this.reason);

  // convert Json to an exercise object
  factory ActiveListModel.fromJson(Map<dynamic, dynamic> json) {
    int sId = int.parse(json['streamId'].toString());
    return ActiveListModel(
      json['name'] as String,
      sId,
      //  json['streamId'] as int,
      json['clientId'] as String,
      json['videoaspectratio'] as String,
      json['mediatype'] as String,
      json['videomuted'] as bool,
      json['reason'] as String,
    );
  }
}
