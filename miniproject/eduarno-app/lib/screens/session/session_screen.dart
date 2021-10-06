import 'package:eduarno/Utilities/constants.dart';
import 'package:eduarno/Utilities/dimentions.dart';
import 'package:eduarno/repo/bloc/profile/model/notification_model.dart';
import 'package:eduarno/screens/session/session_detail.dart';
import 'package:eduarno/screens/session/session_list_model.dart';
import 'package:eduarno/screens/session/session_provider.dart';
import 'package:eduarno/widgets/no_data_screen.dart';
import 'package:eduarno/widgets/shimmer_screen.dart';
import 'package:eduarno/screens/session/session_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SessionScreen extends StatefulWidget {
  final String specialization;
  final List<Map<String, dynamic>> topicList;
  final VoidCallback openDrawer;

  SessionScreen({Key key, this.specialization, this.topicList, this.openDrawer})
      : super(key: key);

  @override
  _SessionScreenState createState() => _SessionScreenState();
}

class _SessionScreenState extends State<SessionScreen> {
  SessionService api = SessionService();
  SessionProvider sessionProvider = SessionProvider();
  NotificationProvider notify = NotificationProvider();
  SessionListModule sessionListModule;
  bool _apiHit = false;
  var sessionList;
  _getSessionList() async {
    sessionList = await api.getSessionlist().then((value) {
      sessionListModule = value;
      // sessionProvider.posted_url;
      // sessionProvider.noOfSessions = sessionListModule.datas.length;
      // sessionProvider.posted_url;
      List<String> reqId = [];
      sessionListModule.datas.forEach(
        (request) {
          reqId.add(request.sId);
        },
      );
      notify.setRequestId(reqId);
      setState(() {
        _apiHit = true;
      });
      //print("payment status: "+sessionListModule.datas[0].paymentStatus);
    });
    return sessionList;
  }

  @override
  void initState() {
    super.initState();
    _getSessionList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: Colors.white,
            backwardsCompatibility: true,
            systemOverlayStyle:
                SystemUiOverlayStyle(statusBarColor: Colors.white),
            elevation: .6,
            title: Text('Session',
                style: TextStyle(
                  fontSize: 22.0,
                  color: Colors.black,
                  // fontWeight: FontWeight.w700,
                )),
            centerTitle: true,
            leading: IconButton(
                icon: Icon(Icons.menu_open, color: kLightGreen),
                onPressed: widget.openDrawer),
            actions: [
              SvgPicture.asset('assets/icon_artwork.svg'),
              SizedBox(width: 8),
              SvgPicture.asset('assets/filter.svg'),
              SizedBox(width: 16)
            ]),
        body: _apiHit
            ? SafeArea(
                child: sessionListModule.datas.isNotEmpty
                    ? SingleChildScrollView(
                        child: Column(
                        children: [
                          SizedBox(height: 16),
                          ListView.builder(
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: sessionListModule.datas.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SessionDetail(
                                              api: api,
                                              sessionListModule:
                                                  sessionListModule,
                                              index: index,
                                            )),
                                  );
                                },
                                child: Card(
                                  shadowColor: Colors.grey[200],
                                  elevation: 5,
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 20),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Row(
                                              children: [
                                                Container(
                                                    margin: EdgeInsets.only(
                                                        left: 16),
                                                    padding: EdgeInsets.symmetric(
                                                        horizontal: 8,
                                                        vertical: 2),
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.all(
                                                            Radius.circular(5)),
                                                        color: sessionListModule.datas[index].requestType ==
                                                                'General'
                                                            ? purple
                                                            : btnBlue),
                                                    child: Text(
                                                        sessionListModule
                                                            .datas[index]
                                                            .requestType,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontFamily: 'Poppins',
                                                            fontSize: Dimensions.FONT_SIZE_SMALL))),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Icon(Icons.timer,
                                                      color: Colors.black54),
                                                  SizedBox(width: 8),
                                                  Container(
                                                      margin: EdgeInsets.only(
                                                          right: 16),
                                                      child: Text(
                                                          sessionListModule
                                                              .datas[index]
                                                              .timeline,
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black54,
                                                              fontSize: Dimensions
                                                                  .FONT_SIZE_SMALL,
                                                              fontFamily:
                                                                  'Poppins')))
                                                ]),
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 16),
                                      Container(
                                          margin: EdgeInsets.only(
                                              left: Dimensions
                                                  .MARGIN_SIZE_DEFAULT),
                                          child: Text(
                                            sessionListModule
                                                .datas[index].specialisation,
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w400,
                                                fontSize:
                                                    Dimensions.FONT_SIZE_LARGE),
                                          )),
                                      SizedBox(height: 8),
                                      Container(
                                          margin: EdgeInsets.only(
                                              left: Dimensions
                                                  .MARGIN_SIZE_DEFAULT),
                                          child: Text(
                                            sessionListModule
                                                .datas[index].topic,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: 'Poppins',
                                                fontSize: Dimensions
                                                    .FONT_SIZE_EXTRA_LARGE),
                                          )),
                                      Divider(
                                        color: Colors.grey[200],
                                        height: 20,
                                        thickness: 2,
                                        indent: 20,
                                        endIndent: 20,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Row(
                                              children: [
                                                Container(
                                                    margin: EdgeInsets.only(
                                                        left: 16),
                                                    child: Text('Content: ',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black87,
                                                            fontFamily:
                                                                'Poppins',
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: Dimensions
                                                                .FONT_SIZE_SMALL))),
                                                Flexible(
                                                  child: Container(
                                                      margin: EdgeInsets.only(
                                                          left: Dimensions
                                                              .MARGIN_SIZE_SMALL),
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 8,
                                                              vertical: 2),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      5)),
                                                          color: shadowGreen),
                                                      child: Text('Added',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              color:
                                                                  kLightGreen,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontFamily: 'Poppins',
                                                              fontSize: Dimensions.FONT_SIZE_SMALL))),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Container(
                                                      margin: EdgeInsets.only(
                                                          left: 16),
                                                      child: Text('Payment: ',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black87,
                                                              fontFamily:
                                                                  'Poppins',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: Dimensions
                                                                  .FONT_SIZE_SMALL))),
                                                  Container(
                                                      margin: EdgeInsets.only(
                                                          left: Dimensions
                                                              .MARGIN_SIZE_SMALL,
                                                          right: Dimensions
                                                              .MARGIN_SIZE_SMALL),
                                                      padding: EdgeInsets.symmetric(
                                                          horizontal: 8,
                                                          vertical: 2),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      5)),
                                                          color: sessionListModule.datas[index].paymentStatus == 'Disbursed'
                                                              ? Colors
                                                                  .yellow[100]
                                                              : shadowPink),
                                                      child: Text(sessionListModule.datas[index].paymentStatus,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              color: sessionListModule.datas[index].paymentStatus == 'Disbursed' ? btnYellow : Colors.pink[200],
                                                              fontFamily: 'Poppins',
                                                              fontWeight: FontWeight.w500,
                                                              fontSize: Dimensions.FONT_SIZE_SMALL))),
                                                ]),
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 20)
                                    ],
                                  ),
                                ),
                              );
                            },
                          )
                        ],
                      ))
                    : MyNoData(message: 'No data found'),
              )
            : MyShimmer());
  }
}
