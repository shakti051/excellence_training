import 'dart:convert';
import 'package:eduarno/screens/session/session_detail.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:badges/badges.dart';
import 'package:eduarno/Notification/notificationResponseModel.dart';
import 'package:eduarno/Utilities/constants.dart';
import 'package:eduarno/repo/bloc/profile/model/notification_model.dart';
import 'package:eduarno/widgets/shimmer_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class NotificationScreen extends StatefulWidget {
  final VoidCallback openDrawer;

  NotificationScreen({Key key, this.openDrawer}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  NotificationProvider notifications = NotificationProvider();
  bool apiHit = false;
  // NotificationResultResponse _notificationResponse;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  bool setstate = false;

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance
    //     .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
    // notifications.getNotifications().then((value) {
    //   setState(() {
    //     apiHit = true;
    //     // _notificationResponse = value;
    //   });
    // });
  }

  Future<Null> _refresh() {
    return notifications.getNotifications().then((value) {
      setState(() {
        // _notificationResponse = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.white),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.menu_open, color: Color(0xff303030)),
          onPressed: widget.openDrawer,
        ),
        title: Text(
          'Notifications',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 22.0,
            color: Color(0xff303030),
            // fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        // leading: IconButton(
        //   icon: Icon(Icons.keyboard_backspace, color: Colors.black),
        //   onPressed: () => {Navigator.pop(context)},
        // ),
      ),
      body: true
          ? RefreshIndicator(
              key: _refreshIndicatorKey,
              onRefresh: _refresh,
              child: Padding(
                padding: const EdgeInsets.only(top: 27.0, right: 16, left: 14),
                child: ListView.builder(
                  itemCount: notifications.notificationList.length,
                  itemBuilder: (context, index) {
                    return notificationList(
                      context,
                      notificationText:
                          notifications.notificationList[index].notification ??
                              'No new notifications to show',
                      type:
                          notifications.notificationList[index].type ?? 'None',
                      // isRead: notifications.notificationList[index].isRead,
                      index: index,
                    );
                  },
                ),
              ),
            )
          : MyShimmer(),
    );
  }

  Future<void> notificationUpdate(
      {@required String notificationId, int index}) async {
    var body = json.encode(
      {
        'notification_id': notificationId,
      },
    );
    // ignore: omit_local_variable_types
    String updateNotifyUrl = '$kBaseApiUrl/user/get_notification_update';
    // ignore: omit_local_variable_types
    final http.Response response = await http.post(Uri.parse(updateNotifyUrl),
        headers: {'Content-Type': 'application/json'}, body: body);
    if (response.statusCode == 200) {
      print('Response Updated ----------------> ${response.body}');
      notifications.notificationList[index].isRead = true;
      notifications.notificationCountSet();
    }
  }

  Widget notificationList(BuildContext context,
      {String notificationText, String type, int index}) {
    // var time = notifications.notificationList[index].createdAt / 60000;
    // ignore: unnecessary_new

    final time = DateTime.now().subtract(Duration(
        microseconds: notifications.notificationList[index].createdAt));

    var dt = DateTime.fromMillisecondsSinceEpoch(
        notifications.notificationList[index].createdAt);
    var timeFinal = timeago.format(dt).split(' ');
    var d12 = DateFormat('MM/dd/yyyy, hh:mm a').format(dt);
    var timeinit = timeFinal[0] + ' ' + timeFinal[1];

    // var timeinit = DateTime.now().subtract();
    print(timeFinal);
    return InkWell(
      onTap: () {
        if (notifications.notificationList[index].requestId != null &&
            notifications.notificationList[index].requestId != '') {
          // ignore: omit_local_variable_types
          int indent = notifications.requestId
              .indexOf(notifications.notificationList[index].requestId);
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return SessionDetail(
              requestId: notifications.notificationList[index].requestId,
              fromNotification: true,
              index: indent,
            );
          }));
        }

        if (notifications.notificationList[index].isRead == false) {
          notificationUpdate(
                  notificationId: notifications.notificationList[index].id,
                  index: index)
              .then((value) {
            setState(() {});
          });
        }
      },
      child: Container(
        padding: const EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/award.png'),
              alignment: Alignment.centerLeft),
        ),
        //height: 93,
        width: MediaQuery.of(context).size.width,
        child: Container(
          padding: const EdgeInsets.only(left: 45),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      notificationText,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Text(
                    timeinit,
                    style: TextStyle(
                      color: Color(0xffC7C9D9),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      type,
                      softWrap: true,
                      style: TextStyle(
                        color: Color(0xff8C8C8C),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: !notifications.notificationList[index].isRead,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Badge(
                        badgeColor: kPrimaryGreenColor,
                      ),
                    ),
                  )
                ],
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
