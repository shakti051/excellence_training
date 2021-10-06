import 'dart:convert';
import 'dart:ui';

import 'package:custom_switch/custom_switch.dart';
import 'package:eduarno/Utilities/constants.dart';
import 'package:eduarno/repo/bloc/profile/live_session_data.dart';
import 'package:eduarno/repo/bloc/profile/model/live_session_post_model_body.dart';
import 'package:eduarno/repo/bloc/profile/model/live_session_response_model.dart';
import 'package:eduarno/repo/bloc/user.dart';
import 'package:eduarno/widgets/shimmer_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/retry.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weekday_selector/weekday_selector.dart';
import 'package:http/http.dart' as http;

enum LiveSession { Yes, No }

class LiveSessions extends StatefulWidget {
  // final LiveSessionResponse response;
  const LiveSessions({
    Key key,
  }) : super(key: key);

  @override
  _LiveSessionsState createState() => _LiveSessionsState();
}

class _LiveSessionsState extends State<LiveSessions> {
  // LiveSession _liveSession = LiveSession.No;
  var liveSessionsInsertUrl =
      '$kBaseApiUrl/user/session_insert_profile_user_by_id';
  var liveSessionUpdate = '$kBaseApiUrl/user/session_update_profile_user_by_id';
  bool isUpdate = false;
  var values;
  final List<TextEditingController> _startTimeController =
      List.generate(7, (i) => TextEditingController());
  final List<TextEditingController> _endTimeController =
      List.generate(7, (i) => TextEditingController());
  LiveSessionPostBodyResponse postBodyResponse = LiveSessionPostBodyResponse();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DateTime pickedDate;
  TimeOfDay time;
  bool isVisible = User().liveSessionTrigger ?? false;
  bool isSwitched = User().liveSessionTrigger ?? false;
  LiveSessionProvider liveSessionDetails = LiveSessionProvider();
  LiveSessionResponse liveSessionResponse = LiveSessionResponse();
  bool apiHit = false;

  @override
  void initState() {
    super.initState();
    values = List.filled(7, false);
    pickedDate = DateTime.now();
    time = TimeOfDay.now();
    // isVisible = User().liveSessionTrigger ?? false;
    // isSwitched = User().liveSessionTrigger ?? false;
    liveSessionDetails.getLiveSessionDetails().then((response) {
      setState(() {
        liveSessionResponse = liveSessionDetails.response;
        if (liveSessionDetails.response.data.isNotEmpty) {
          // User().setTrigger(liveSessionResponse.data.first.isAvailable);
          print(User().liveSessionTrigger);

          // isVisible = liveSessionResponse.data.first.isAvailable;
          // isSwitched = liveSessionResponse.data.first.isAvailable;
          for (var i = 0; i < 7; i++) {
            _startTimeController[i].text = liveSessionResponse
                .data.first.userAvailableDay[i].userStartTime;
            _endTimeController[i].text =
                liveSessionResponse.data.first.userAvailableDay[i].userEndTime;
          }
          isUpdate = true;
        }
        if (liveSessionDetails.response.data.isEmpty) {
          for (var i = 0; i < 7; i++) {
            _startTimeController[i].text = '';
            _endTimeController[i].text = '';
          }
        }
        apiHit = true;
      });
    });
  }

  Future<void> dataSet(User user) async {
    // ignore: omit_local_variable_types
    List<UserAvailableDays> useravailability = [];
    // user.liveSessionTrigger = isVisible;
    postBodyResponse.isAvailable = isVisible;
    postBodyResponse.userId = User().userId;
    var pb = postBodyResponse.isAvailable;
    print(pb);
    for (var i = 0; i < 7; i++) {
      // ignore: omit_local_variable_types
      UserAvailableDays availableDays = UserAvailableDays();
      try {
        availableDays.day = intDayToEnglish(i);
        availableDays.userStartTime = _startTimeController[i].text;
        availableDays.userEndTime = _endTimeController[i].text;
      } catch (e) {
        print(e);
      }
      useravailability.add(availableDays);
    }
    postBodyResponse.userAvailableDay = useravailability;
  }

  _pickDate() async {
    // ignore: omit_local_variable_types
    DateTime date = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
      initialDate: pickedDate,
    );
    if (date != null) {
      setState(() {
        pickedDate = date;
      });
    }
  }

  Future<String> _pickTime() async {
    // ignore: omit_local_variable_types
    TimeOfDay t = await showTimePicker(context: context, initialTime: time);
    if (t != null) {
      setState(() {
        time = t;
      });
    }
    // ignore: omit_local_variable_types
    DateTime tempDate = DateFormat('hh:mm')
        .parse(time.hour.toString() + ':' + time.minute.toString());
    var dateFormat = DateFormat('h:mm a'); // you can change the format here
    print(dateFormat.format(tempDate));
    return dateFormat.format(tempDate);
  }

  Future<Null> _showTime({@required int index}) {
    return showModalBottomSheet(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.3,
              // decoration: BoxDecoration(
              //   color: Colors.white,
              //   borderRadius: BorderRadius.only(
              //     topLeft: Radius.circular(50),
              //     topRight: Radius.circular(50),
              //   ),
              // ),
              child: Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  title: Text('Select time'),
                ),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerDocked,
                floatingActionButton: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Confirm')),
                body: Column(
                  children: [
                    // Text(
                    //   'Start Time',
                    //   style: TextStyle(
                    //       color: Colors.black, fontWeight: FontWeight.bold),
                    // ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            // flex: 2,
                            child: TextField(
                              readOnly: true,
                              controller: _startTimeController[index],
                              decoration: const InputDecoration(
                                suffixIcon: Icon(
                                  CupertinoIcons.clock,
                                  color: kChatColor,
                                ),
                                // fillColor: kPrimaryGreenColor,
                                filled: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    borderSide: BorderSide(
                                        color: Colors.red, width: 2)),
                                labelText: 'Start',
                                errorBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.amber)),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xffF6F7FA), width: 1),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xffF6F7FA), width: 1),
                                ),
                                labelStyle: TextStyle(
                                    color: Color(0xff9D9FA0),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16),
                                hintText: '09:00',
                                hintStyle: TextStyle(
                                    color: Color(0xff9D9FA0),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16),
                              ),
                              onTap: () {
                                _pickTime().then((value) => {
                                      setState(() {
                                        _startTimeController[index].text =
                                            value;
                                        // '${time.hour}:${time.minute}';
                                        liveSessionResponse
                                            .data
                                            .first
                                            .userAvailableDay[index]
                                            .userStartTime = value;
                                        // '${time.hour}:${time.minute}';
                                      })
                                    });
                              },
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            // flex: 2,
                            child: TextField(
                              readOnly: true,
                              controller: _endTimeController[index],
                              decoration: const InputDecoration(
                                suffixIcon: Icon(
                                  CupertinoIcons.clock,
                                  color: kChatColor,
                                ),
                                // fillColor: kPrimaryGreenColor,
                                // Color(0xffF6F7FA),
                                filled: true,
                                // border: InputBorder.none,
                                labelText: 'End',
                                errorBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.amber)),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xffF6F7FA), width: 1),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xffF6F7FA), width: 1),
                                ),
                                labelStyle: TextStyle(
                                    color: Color(0xff9D9FA0),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16),
                                hintText: '10:00',
                                hintStyle: TextStyle(
                                    color: Color(0xff9D9FA0),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16),
                              ),
                              onTap: () {
                                _pickTime().then((value) => {
                                      setState(() {
                                        _endTimeController[index].text = value;
                                        // '${time.hour}:${time.minute}';
                                        liveSessionResponse
                                            .data
                                            .first
                                            .userAvailableDay[index]
                                            .userEndTime = value;
                                        // '${time.hour}:${time.minute}';
                                      })
                                    });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Text(
                    //   'End Time',
                    //   style: TextStyle(
                    //       color: Colors.black, fontWeight: FontWeight.bold),
                    // ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Future<void> setLiveSession(bool value) async {
    final url = '$kBaseApiUrl/user/session_update_status_user_by_id';
    var body = json.encode({'user_id': User().userId, 'is_available': value});
    // ignore: omit_local_variable_types
    final http.Response response = await http.post(Uri.parse(url),
        headers: {'Content-Type': 'application/json'}, body: body);
    if (response.statusCode == 200) {
      print('Successfully Update ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    // final user = Provider.of(context);
    final user = context.watch<User>();
    final liveSession = context.watch<LiveSessionProvider>();
    return WillPopScope(
      onWillPop: () => Future.value(true),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'Live Sessions',
            style: TextStyle(fontSize: 24),
          ),
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              CupertinoIcons.back,
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              // user.setTrigger(isVisible);
              dataSet(user).then(
                (value) {
                  liveSessionDetails
                      .setLiveSessionDetails(
                    postBodyResponse,
                    isUpdate ? liveSessionUpdate : liveSessionsInsertUrl,
                  )
                      .then(
                    (value) async {
                      liveSession.containerState = true;
                      await Future.delayed(Duration(
                        seconds: 1,
                      ));
                      Navigator.pop(context, isVisible);
                      liveSession.containerState = false;
                    },
                  );
                },
              );
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            ),
            child: AnimatedContainer(
              duration: Duration(seconds: 1),
              width: liveSession.containerState ? 50 : 125,
              height: 30,
              alignment: Alignment.center,
              child: liveSession.containerState
                  ? Icon(Icons.done)
                  : Text(
                      'Save changes',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
            ),
          ),
        ),
        body: apiHit
            ? Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24.0, vertical: 21),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Enable live sessions',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        Expanded(
                          // padding: const EdgeInsets.only(left: 150),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              height: 24,
                              width: 55,
                              child: FittedBox(
                                fit: BoxFit.cover,
                                child: CustomSwitch(
                                  activeColor: kPrimaryGreenColor,
                                  onChanged: (bool value) {
                                    setLiveSession(value);
                                    if (user.liveSessionTrigger == false) {
                                      setState(() {
                                        user.setTrigger(true);
                                        isVisible = !isVisible;

                                        // user.setTrigger(isVisible);
                                      });
                                    } else {
                                      setState(() {
                                        user.setTrigger(false);
                                        isVisible = false;
                                      });
                                    }
                                  },
                                  value: user.liveSessionTrigger,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Visibility(
                      visible: isVisible,
                      child: Column(
                        children: [
                          Divider(),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Share your availability',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          Column(
                            children:
                                List.generate(7, (index) => listDay(index)),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            : MyShimmer(),
      ),
    );
  }

  Widget listDay(int index) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(
            intDayToEnglish(index),
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
          ),
          subtitle: Visibility(
            visible: _startTimeController[index].text != '',
            child: Text(
              '${_startTimeController[index].text} - ${_endTimeController[index].text}',
              style: TextStyle(fontSize: 10),
            ),
          ),
          trailing: _startTimeController[index].text != ''
              ? IconButton(
                  onPressed: () {
                    _showTime(index: index);
                  },
                  icon: SvgPicture.asset('assets/editIcon.svg'),
                )
              : TextButton(
                  onPressed: () {
                    _showTime(index: index);
                  },
                  child: Text(
                    '+ Select a time',
                    style: TextStyle(
                        color: kPrimaryGreenColor,
                        fontSize: 10,
                        fontWeight: FontWeight.w500),
                  ),
                ),
        ),
        Divider(
          height: 0,
        ),
      ],
    );
  }

  String intDayToEnglish(int day) {
    if (day % 7 == DateTime.monday % 7) return 'Monday';
    if (day % 7 == DateTime.tuesday % 7) return 'Tueday';
    if (day % 7 == DateTime.wednesday % 7) return 'Wednesday';
    if (day % 7 == DateTime.thursday % 7) return 'Thursday';
    if (day % 7 == DateTime.friday % 7) return 'Friday';
    if (day % 7 == DateTime.saturday % 7) return 'Saturday';
    if (day % 7 == DateTime.sunday % 7) return 'Sunday';
    throw 'This should never have happened: $day';
  }
}

          // Visibility(
          //   visible: isVisible,
          //   child: Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: Column(
          //       children: [
          //         Divider(
          //           indent: 10,
          //           endIndent: 10,
          //         ),
          //         Container(
          //           height: 250,
          //           width: double.infinity,
          //           child: Form(
          //             key: _formKey,
          //             child: Card(
          //               elevation: 2,
          //               child: Column(
          //                 crossAxisAlignment: CrossAxisAlignment.start,
          //                 children: [
          //                   Padding(
          //                     padding: const EdgeInsets.symmetric(
          //                         horizontal: 10.0, vertical: 20),
          //                     child: Text(
          //                       'Share Your Availability',
          //                       style: TextStyle(
          //                           fontSize: 18.0,
          //                           color: Colors.black,
          //                           fontWeight: FontWeight.w400),
          //                     ),
          //                   ),
          //                   Padding(
          //                     padding:
          //                         const EdgeInsets.only(left: 10.0, top: 0),
          //                     child: Text(
          //                       'Select Days',
          //                       style: TextStyle(
          //                           color: Colors.black,
          //                           fontWeight: FontWeight.bold),
          //                     ),
          //                   ),
          //                   Padding(
          //                     padding: const EdgeInsets.only(
          //                         left: 6.0, right: 8.0, bottom: 8.0),
          //                     child: WeekdaySelector(
          //                       firstDayOfWeek: 1,
          //                       onChanged: (int day) {
          //                         setState(() {
          //                           final index = day % 7;
          //                           values[index] = !values[index];
          //                           print(values);
          //                         });
          //                       },
          //                       values: values,
          //                     ),
          //                   ),
          //                   Padding(
          //                     padding: const EdgeInsets.symmetric(
          //                         horizontal: 10.0, vertical: 13.0),
          //                     child: Row(
          //                       children: <Widget>[
          //                         Expanded(
          //                           child: Column(
          //                             crossAxisAlignment:
          //                                 CrossAxisAlignment.start,
          //                             children: [
          //                               Text(
          //                                 'Start Time',
          //                                 style: TextStyle(
          //                                     color: Colors.black,
          //                                     fontWeight: FontWeight.bold),
          //                               ),
          //                               TextField(
          //                                 readOnly: true,
          //                                 controller: _startTimeController,
          //                                 decoration: const InputDecoration(
          //                                   hintText: 'Start Time',
          //                                   suffixIcon: Icon(Icons.access_time),
          //                                 ),
          //                                 onTap: () {
          //                                   _pickTime().then((value) => {
          //                                         setState(() {
          //                                           _startTimeController.text =
          //                                               '${time.hour}:${time.minute}';
          //                                         })
          //                                       });
          //                                 },
          //                               ),
          //                             ],
          //                           ),
          //                         ),
          //                         SizedBox(
          //                           width: 10,
          //                         ),
          //                         Expanded(
          //                           child: Column(
          //                             crossAxisAlignment:
          //                                 CrossAxisAlignment.start,
          //                             children: [
          //                               Text(
          //                                 'End Time',
          //                                 style: TextStyle(
          //                                     color: Colors.black,
          //                                     fontWeight: FontWeight.bold),
          //                               ),
          //                               TextField(
          //                                 readOnly: true,
          //                                 controller: _endTimeController,
          //                                 decoration: const InputDecoration(
          //                                   hintText: 'End Time',
          //                                   suffixIcon: Icon(Icons.access_time),
          //                                 ),
          //                                 onTap: () {
          //                                   _pickTime().then((value) => {
          //                                         setState(() {
          //                                           _endTimeController.text =
          //                                               '${time.hour}:${time.minute}';
          //                                         })
          //                                       });
          //                                 },
          //                               ),
          //                             ],
          //                           ),
          //                         ),
          //                       ],
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),















          // child: DefaultTabController(
          //       length: 2,
          //       child: Scaffold(
          //         appBar: AppBar(
          //           automaticallyImplyLeading: false,
          //           bottom: TabBar(
          //               labelColor: kChatColor,
          //               labelStyle: TextStyle(color: kChatColor),
          //               tabs: const [
          //                 Tab(
          //                   text: 'Start time',
          //                 ),
          //                 Tab(
          //                   text: 'Stop time',
          //                 ),
          //               ]),
          //         ),
          //         body: TabBarView(
          //           children: [
                      
          //           ],
          //         ),
          //       ),
          //     ),