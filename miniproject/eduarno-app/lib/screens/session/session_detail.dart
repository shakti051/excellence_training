import 'dart:io';
import 'package:eduarno/screens/session/session_bottomsheet.dart';
import 'package:eduarno/screens/session/session_detail_service.dart';
import 'package:eduarno/screens/session/details_model/session_details_model.dart';
import 'package:eduarno/screens/session/session_list_model.dart';
import 'package:eduarno/screens/session/session_provider.dart';
import 'package:eduarno/screens/session/session_service.dart';
import 'package:eduarno/screens/session/upload_image_api.dart';
import 'package:eduarno/widgets/bottom_app_bar.dart';
import 'package:eduarno/widgets/shimmer_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:eduarno/Utilities/constants.dart';
import 'package:eduarno/Utilities/dimentions.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SessionDetail extends StatefulWidget {
  SessionListModule sessionListModule;
  SessionService api;
  int index;
  final requestId;
  final bool fromNotification;
  SessionDetail({
    this.api,
    this.sessionListModule,
    this.index,
    this.requestId,
    this.fromNotification = false,
  });
  @override
  _SessionDetailState createState() => _SessionDetailState(
      api: api, sessionListModule: sessionListModule, index: index);
}

class _SessionDetailState extends State<SessionDetail> {
  final TextEditingController _commentTextController = TextEditingController();
  SessionListModule sessionListModule;
  SessionService api = SessionService();
  SessionDetailModel sessionDetailModel;
  SessionDetailService apiDetails = SessionDetailService();
  SessionProvider sessions = SessionProvider();
  int index;
  File _image;
  var val;
  UploadImageApi apiImage = UploadImageApi();
  final picker = ImagePicker();
  bool uploading = false;
  bool hideBottomSheet = false;
  var sessionDetails;
  bool _apiHit = false;

  _SessionDetailState({this.api, this.sessionListModule, this.index});

  _launchURL(String url) async =>
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';

  _getSessionDetailList() async {
    sessionDetails = await apiDetails
        .getSessionDetails(
            request_id: widget.fromNotification
                ? widget.requestId
                : sessionListModule.datas[index].sId)
        .then((value) {
      sessionDetailModel = value;
      setState(() {
        _apiHit = true;
      });
      //     print(">>>>>>>>>>>>>>>>>>>>>>>>"+sessionDetailModel.datas[0].student);
    });
    return sessionDetails;
  }

  @override
  void initState() {
    super.initState();
    _getSessionDetailList();
    print('At Session detail -----> ${sessions.posted_url}');
    print(index);
//  print("requestid>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"+sessionListModule.datas[1].sId);
  }

  @override
  Widget build(BuildContext context) {
    //  String myUrl = Provider.of<SessionProvider>(context).url;
    final sessions = context.watch<SessionProvider>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        backwardsCompatibility: true,
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.white),
        elevation: .6,
        title: Text(
          'Session Detail',
          style: TextStyle(
            fontSize: 22.0,
            // color: Colors.black,
            // fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left, color: kChatColor),
          onPressed: () => {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => MyBottomBar())),
          },
        ),
        actions: [
          Icon(Icons.live_help, color: Colors.black54, size: 24),
          SizedBox(width: 16)
        ],
      ),
      bottomNavigationBar: Visibility(
        visible: sessions.posted_url[index] != null &&
                sessions.posted_url[index] != ''
            ? false
            : true,
        child: Container(
          color: shadowGreen,
          height: 130,
          width: MediaQuery.of(context).size.width,
          child: Column(children: [
            SizedBox(height: 16),
            SvgPicture.asset('assets/line.svg'),
            SizedBox(height: 8),
            Text(
              'Know the answer ?',
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                  fontSize: Dimensions.FONT_SIZE_LARGE),
            ),
            RaisedButton(
                color: btnGreen,
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (BuildContext context) => SingleChildScrollView(
                          child: Container(
                              padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom),
                              child: SessionBottomSheet(
                                  index: index,
                                  requestId:
                                      sessionDetailModel.datas.first.sId))));
                },
                // ignore: sort_child_properties_last
                child: Container(
                  width: 150,
                  child: Row(
                    children: [
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Icon(Icons.add, color: Colors.white)),
                      Container(
                          margin: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            'Upload Answer',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: Dimensions.FONT_SIZE_DEFAULT),
                          ))
                    ],
                  ),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0))),
          ]),
        ),
      ),
      body: _apiHit
          ? SafeArea(
              child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Card(
                    shadowColor: Colors.grey[200],
                    elevation: 5,
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Container(
                                      margin: EdgeInsets.only(left: 16),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 2),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)),
                                          color: sessionDetailModel.datas.first
                                                      .requestType ==
                                                  'General'
                                              ? purple
                                              : btnBlue),
                                      child: Text(
                                          sessionDetailModel
                                              .datas.first.requestType,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'Poppins',
                                              fontSize:
                                                  Dimensions.FONT_SIZE_SMALL))),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                        child: Text('session ID:',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.black87,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w400,
                                                fontSize: Dimensions
                                                    .FONT_SIZE_SMALL))),
                                    SizedBox(width: 4),
                                    Container(
                                        margin: EdgeInsets.only(right: 16),
                                        child: Text(
                                            sessionDetailModel
                                                .datas.first.sessionId,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.black87,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w400,
                                                fontSize: Dimensions
                                                    .FONT_SIZE_SMALL)))
                                  ]),
                            )
                          ],
                        ),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Container(
                                      margin: EdgeInsets.only(
                                          left: Dimensions.MARGIN_SIZE_DEFAULT),
                                      child: Text(
                                        sessionDetailModel
                                            .datas.first.specialisation,
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w400,
                                            fontSize:
                                                Dimensions.FONT_SIZE_LARGE),
                                      )),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Icon(Icons.timer, color: Colors.black54),
                                    SizedBox(width: 8),
                                    Container(
                                        margin: EdgeInsets.only(right: 16),
                                        child: Text(
                                            sessionDetailModel
                                                .datas.first.timeline,
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontSize:
                                                    Dimensions.FONT_SIZE_SMALL,
                                                fontFamily: 'Poppins')))
                                  ]),
                            )
                          ],
                        ),
                        SizedBox(height: 8),
                        Container(
                            margin: EdgeInsets.only(
                                left: Dimensions.MARGIN_SIZE_DEFAULT),
                            child: Text(
                              sessionDetailModel.datas.first.topic,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Poppins',
                                  fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE),
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
                                      margin: EdgeInsets.only(left: 16),
                                      child: Text('Content: ',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w400,
                                              fontSize:
                                                  Dimensions.FONT_SIZE_SMALL))),
                                  Flexible(
                                    child: Container(
                                        margin: EdgeInsets.only(
                                            left: Dimensions.MARGIN_SIZE_SMALL),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 2),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5)),
                                            color: shadowGreen),
                                        child: Text('Added',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: kLightGreen,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'Poppins',
                                                fontSize: Dimensions
                                                    .FONT_SIZE_SMALL))),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                        margin: EdgeInsets.only(left: 16),
                                        child: Text('Payment: ',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.black87,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w400,
                                                fontSize: Dimensions
                                                    .FONT_SIZE_SMALL))),
                                    Container(
                                        margin: EdgeInsets.only(
                                            left: Dimensions.MARGIN_SIZE_SMALL,
                                            right:
                                                Dimensions.MARGIN_SIZE_DEFAULT),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 2),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5)),
                                            color: sessionDetailModel.datas
                                                        .first.paymentStatus ==
                                                    'Disbursed'
                                                ? Colors.yellow[100]
                                                : shadowPink),
                                        child: Text('Pending',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: sessionDetailModel
                                                            .datas
                                                            .first
                                                            .paymentStatus ==
                                                        'Disbursed'
                                                    ? btnYellow
                                                    : Colors.pink[200],
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w500,
                                                fontSize:
                                                    Dimensions.FONT_SIZE_SMALL))),
                                  ]),
                            )
                          ],
                        ),
                        SizedBox(height: 20)
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                      margin:
                          EdgeInsets.only(left: Dimensions.MARGIN_SIZE_DEFAULT),
                      child: Text(
                        'Question',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            fontSize: Dimensions.FONT_SIZE_LARGE),
                      )),
                  Container(
                      margin: EdgeInsets.only(
                          left: Dimensions.MARGIN_SIZE_DEFAULT,
                          right: Dimensions.MARGIN_SIZE_DEFAULT),
                      child: Html(data: sessionDetailModel.datas.first.content)
                      // Text(sessionListModule.datas[index].content,
                      //     textAlign: TextAlign.justify,
                      //     style: TextStyle(
                      //         color: Colors.black87,
                      //         fontFamily: 'Poppins',
                      //         fontWeight: FontWeight.w400,
                      //         fontSize: Dimensions.FONT_SIZE_DEFAULT)),
                      ),
                  SizedBox(height: 16),
                  Container(
                      margin:
                          EdgeInsets.only(left: Dimensions.MARGIN_SIZE_DEFAULT),
                      child: Text(
                        'Attachments',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            fontSize: Dimensions.FONT_SIZE_LARGE),
                      )),
                  SizedBox(height: 16),
                  Visibility(
                    visible: (sessionDetailModel.datas.first.fileUrl != null &&
                        sessionDetailModel.datas.first.fileUrl != ''),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.grey[200]),
                      margin: EdgeInsets.symmetric(
                          horizontal: Dimensions.MARGIN_SIZE_DEFAULT),
                      child: ListTile(
                        onTap: () {
                          _launchURL(sessionDetailModel.datas.first.fileUrl);
                        },
                        leading: (sessionDetailModel.datas.first.fileUrl !=
                                    null &&
                                sessionDetailModel.datas.first.fileUrl != '')
                            ? sessionDetailModel.datas.first.fileUrl
                                    .contains('.pdf')
                                ? Icon(
                                    Icons.picture_as_pdf,
                                    color: Colors.red,
                                  )
                                : sessionDetailModel.datas.first.fileUrl
                                        .contains(RegExp(
                                            r'[^\\s]+(.*?)\\.(docx|xlsx|doc|txt|DOCX|DOC|TXT|GIF)$'))
                                    ? Icon(
                                        CupertinoIcons.doc,
                                        color: Colors.blue,
                                      )
                                    : Icon(
                                        Icons.image_outlined,
                                        color: Colors.blue,
                                      )
                            : Icon(Icons.attachment),
                        title: Text('Admin attachment',
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                                color: Colors.black87,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                                fontSize: Dimensions.FONT_SIZE_DEFAULT)),
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.grey[200]),
                    margin: EdgeInsets.symmetric(
                        horizontal: Dimensions.MARGIN_SIZE_DEFAULT),
                    child: Visibility(
                      visible: sessions.posted_url[index] == null ||
                              sessions.posted_url[index] == ''
                          ? false
                          : true,
                      child: ListTile(
                        onTap: () {
                          _launchURL(Provider.of<SessionProvider>(context,
                                  listen: false)
                              .posted_url[index]);
                        },
                        leading: (sessions.posted_url[index] != null &&
                                sessions.posted_url[index] != '')
                            ? (sessions.posted_url[index].contains('.pdf')
                                ? Icon(
                                    Icons.picture_as_pdf,
                                    color: Colors.red,
                                  )
                                : (RegExp(r'([a-zA-Z0-9\s_\\.\-\(\):])+(.spreadsheet|.docx|.pdf|.document)$')
                                        .hasMatch(sessions.posted_url[index])
                                    ? Icon(
                                        CupertinoIcons.doc,
                                        color: Colors.green,
                                      )
                                    : Icon(
                                        Icons.image_outlined,
                                        color: Colors.blue,
                                      )))
                            : Icon(Icons.attachment),
                        title: Align(
                          alignment: Alignment.centerLeft,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                                // sessions.posted_url[index] != null &&
                                sessions.posted_url[index] != ''
                                    ? sessions.posted_url[index].substring(51)
                                    : 'None',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                    fontSize: Dimensions.FONT_SIZE_DEFAULT)),
                          ),
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            sessions.removeUrl(index);
                          },
                          icon: Icon(
                            Icons.clear,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(height: 16),
                  Container(
                      margin:
                          EdgeInsets.only(left: Dimensions.MARGIN_SIZE_DEFAULT),
                      child: Text(
                        'Comments',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            fontSize: Dimensions.FONT_SIZE_LARGE),
                      )),
                  Container(
                      margin: EdgeInsets.only(
                          left: Dimensions.MARGIN_SIZE_DEFAULT,
                          right: Dimensions.MARGIN_SIZE_DEFAULT),
                      child:
                          Html(data: sessionDetailModel.datas.first.comment)),
                ],
              ),
            ))
          : MyShimmer(),
    );
  }
}
