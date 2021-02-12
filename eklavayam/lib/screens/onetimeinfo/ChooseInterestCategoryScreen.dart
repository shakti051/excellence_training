import 'package:eklavayam/network_service/BackendUrl.dart';
import 'package:eklavayam/network_service/NetworkClient.dart';
import 'package:eklavayam/screens/authentication/login_signup/utils/bubble_indication_painter.dart';

//import 'package:eklavayam/screens/home/Bottomtabs/profile_bubble_indication_painter.dart';
import 'package:eklavayam/screens/home/HomeDrawerBottomScreen.dart';

import 'package:eklavayam/screens/onetimeinfo/model/CategoryModel.dart';
import 'package:eklavayam/utill/MyColour.dart';
import 'package:eklavayam/utill/utillFunction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:eklavayam/screens/authentication/login_signup/style/theme.dart'
    as Theme;
import 'package:sticky_headers/sticky_headers/widget.dart';

class ChooseInterestCategoryScreen extends StatefulWidget {
  @override
  _ChooseInterestCategoryScreenState createState() =>
      _ChooseInterestCategoryScreenState();
}

class _ChooseInterestCategoryScreenState
    extends State<ChooseInterestCategoryScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  PageController _pageController;

  Color left = Colors.white;
  Color right = Colors.black;
  Color center = Colors.white;

  // List<String> gridlist = [
  //   "ABC",
  //   "XYZ",
  //   "fwsf",
  //   "sfwr",
  //   "fdsfsd",
  //   "sfsfs",
  //   "XYZ",
  //   "fwsf",
  //   "sfwr",
  //   "fdsfsd",
  //   "sfsfs",
  //   "fwsf",
  //   "sfwr",
  //   "fdsfsd",
  //   "sfsfs",
  //   "XYZ",
  //   "fwsf",
  //   "sfwr",
  //   "fdsfsd",
  //   "sfsfs"
  // ];

  CategoryData artdata;
  CategoryData litreaturedata;
  CategoryData culturedata;

  List<SubInterest> artlist;
  List<SubInterest> litreaturelist;
  List<SubInterest> culturelist;

  int selectedCount = 0;

  Future<void> getCategoryList() async {
    showAlertDialog(context);
    NetworkClient networkClient = new NetworkClient();
    var responsedata = await networkClient.getApiCall(getCategoryUrl);

    print(responsedata);
    Navigator.pop(context);
    if (responsedata['status'] == 1) {
      CategoryModel categoryModel = new CategoryModel.fromJson(responsedata);

      setState(() {
        artdata = categoryModel.data[0];
        litreaturedata = categoryModel.data[1];
        culturedata = categoryModel.data[2];

        artlist = artdata.subInterest;
        litreaturelist = litreaturedata.subInterest;
        culturelist = culturedata.subInterest;
      });
    } else
      showSnakbarWithGlobalKey(_scaffoldKey, "some error occure");
    //print(responsedata['status']);
  }

  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    _pageController = PageController();

    Future.delayed(Duration.zero, () => getCategoryList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowGlow();
        },
        child: SingleChildScrollView(
          child: Container(
            color: bluecolor,
            height: Get.height,
            width: Get.width,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Text(
                    "Choose Category",
                    style: TextStyle(
                        color: whitecolor,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: _buildMenuBar(context),
                ),
                Expanded(
                  flex: 2,
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (i) {
                      if (i == 0) {
                        setState(() {
                          right = Colors.black;
                          left = Colors.white;
                          center = Colors.white;
                        });
                      } else if (i == 1) {
                        setState(() {
                          right = Colors.white;
                          left = Colors.black;
                          center = Colors.white;
                        });
                      } else if (i == 2) {
                        setState(() {
                          right = Colors.white;
                          left = Colors.white;
                          center = Colors.black;
                        });
                      }
                    },
                    children: <Widget>[
                      new ConstrainedBox(
                        constraints: const BoxConstraints.expand(),
                        child: _buildArtGrid(context),
                      ),
                      new ConstrainedBox(
                        constraints: const BoxConstraints.expand(),
                        child: _buildLitratureGrid(context),
                      ),
                      new ConstrainedBox(
                        constraints: const BoxConstraints.expand(),
                        child: _buildCultureGrid(context),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (selectedCount > 0)
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeDrawerBottomScreen()));
                    else
                      showSnakbarWithGlobalKey(_scaffoldKey, "Choose Interest");
                    // _sendToServer();
                    // continuebtn();
                    // onLoginBtn();
                  },
                  child: Container(
                    height: 60,
                    margin: EdgeInsets.symmetric(horizontal: 0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: orangecolor),
                    child: Center(
                      child: Text(
                        "CONTINUE (" + selectedCount.toString() + ")",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuBar(BuildContext context) {
    return Container(
      //width: Get.width - 5,
      height: 50.0,
      decoration: BoxDecoration(
        gradient: new LinearGradient(
            colors: [
              Theme.Colors.loginGradientEnd,
              Theme.Colors.loginGradientEnd
            ],
            begin: const FractionalOffset(0.2, 0.2),
            end: const FractionalOffset(1.0, 1.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
      ),
      child: CustomPaint(
        painter:
            TabIndicationPainter(dxTarget: 90, pageController: _pageController),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: FlatButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: _onTabPress0,
                child: Text(
                  "ART",
                  style: TextStyle(
                    color: right,
                    fontSize: 14.0,
                  ),
                ),
              ),
            ),
            //Container(height: 33.0, width: 1.0, color: Colors.white),
            Expanded(
              child: FlatButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: _onTabPress1,
                child: Text(
                  "LITREATURE",
                  style: TextStyle(
                    color: left,
                    fontSize: 13.0,
                  ),
                ),
              ),
            ),

            Expanded(
              child: FlatButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: _onTabPress2,
                child: Text(
                  "CULTURE",
                  style: TextStyle(
                    color: center,
                    fontSize: 14.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildArtGrid(BuildContext context) {
    return artlist != null
        ? Container(
            child: ListView.builder(
                itemCount: artlist.length,
                itemBuilder: (context, indexx) {
                  return StickyHeader(
                      header: Container(
                        margin: EdgeInsets.only(top: 0, bottom: 10),
                        height: 50.0,
                        color: orangecolor,
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          artlist[indexx].termText,
                          style: TextStyle(
                              color: whitecolor,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                      content: Container(
                        padding: EdgeInsets.only(top: 0.0),
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: artlist[indexx].interest.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 2, crossAxisCount: 2),
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  artlist[indexx].interest[index].value =
                                      !artlist[indexx].interest[index].value;
                                });

                                if (artlist[indexx].interest[index].value)
                                  selectedCount++;
                                else
                                  selectedCount--;
                              },
                              child: Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.all(8),

                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  border:
                                      Border.all(color: Colors.grey, width: 2),
                                  color: artlist[indexx].interest[index].value
                                      ? orangecolor
                                      : whitecolor,
                                ),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    artlist[indexx].interest[index].termText,
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: artlist[indexx]
                                                .interest[index]
                                                .value
                                            ? whitecolor
                                            : orangecolor,
                                        fontSize: 16),
                                  ),
                                ),
                                // child: Row(
                                //   mainAxisAlignment: MainAxisAlignment.center,
                                //   children: [
                                //     //Container(width: 20,),
                                //     Padding(
                                //       padding: const EdgeInsets.all(0.0),
                                //       child: Center(
                                //           child: Expanded(
                                //         child: Text(
                                //           artlist[indexx]
                                //               .interest[index]
                                //               .termText,
                                //           style: TextStyle(
                                //               color: artlist[indexx]
                                //                       .interest[index]
                                //                       .value
                                //                   ? whitecolor
                                //                   : orangecolor,
                                //               fontSize: 16),
                                //         ),
                                //       ),
                                //       ),
                                //     ),
                                //     // artlist[indexx].interest[index].value
                                //     //     ? Container(
                                //     //         margin: EdgeInsets.all(7),
                                //     //         // color: Colors.cyan.withAlpha(60),
                                //     //         child: Center(
                                //     //             child: Icon(
                                //     //           Icons.check_circle,
                                //     //           size: 25,
                                //     //           color: whitecolor,
                                //     //         )),
                                //     //       )
                                //     //     : Container()
                                //   ],
                                // ), //just for testing, will fill with image later
                              ),
                              // Container(
                              //   margin: EdgeInsets.all(5),
                              //   color: artlist[indexx].interest[index].value?orangecolor:whitecolor,
                              //     //footer: new Text(data[index]['name']),
                              //     child: Center(
                              //         child: Text(
                              //           artlist[indexx].interest[index].termText,
                              //       style: TextStyle(color: artlist[indexx].interest[index].value?whitecolor:bluecolor,fontSize: 20),
                              //     )), //just for testing, will fill with image later
                              //
                              // ),
                              // artlist[indexx].interest[index].value? Container(
                              //   margin: EdgeInsets.all(5),
                              //   color: Colors.cyan.withAlpha(60),
                              //   child: Center(child: Icon(Icons.check,size: 60,color: whitecolor,)),
                              // ):Container()
                            );
                          },
                        ),
                      ));
                }))
        : Container();
  }

  Widget _buildCultureGrid(BuildContext context) {
    return culturelist != null
        ? Container(
            child: ListView.builder(
                itemCount: culturelist.length,
                itemBuilder: (context, indexx) {
                  return StickyHeader(
                      header: Container(
                        margin: EdgeInsets.only(top: 0, bottom: 10),
                        height: 50.0,
                        color: orangecolor,
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          culturelist[indexx].termText,
                          style: TextStyle(
                              color: whitecolor,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                      content: Container(
                        padding: EdgeInsets.only(top: 0.0),
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: culturelist[indexx].interest.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 2, crossAxisCount: 2),
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  culturelist[indexx].interest[index].value =
                                      !culturelist[indexx]
                                          .interest[index]
                                          .value;
                                });

                                if (culturelist[indexx].interest[index].value)
                                  selectedCount++;
                                else
                                  selectedCount--;
                              },
                              child: Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  border:
                                      Border.all(color: Colors.grey, width: 2),
                                  color:
                                      culturelist[indexx].interest[index].value
                                          ? orangecolor
                                          : whitecolor,
                                ),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    culturelist[indexx]
                                        .interest[index]
                                        .termText,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: culturelist[indexx]
                                                .interest[index]
                                                .value
                                            ? whitecolor
                                            : orangecolor,
                                        fontSize: 16),
                                  ),
                                ),
                                // child: Row(
                                //   mainAxisAlignment: MainAxisAlignment.center,
                                //   children: [
                                //     //Container(width: 20,),
                                //     Padding(
                                //       padding: const EdgeInsets.all(0.0),
                                //       child: Center(
                                //           child: Text(
                                //         culturelist[indexx]
                                //             .interest[index]
                                //             .termText,
                                //         style: TextStyle(
                                //             color: culturelist[indexx]
                                //                     .interest[index]
                                //                     .value
                                //                 ? whitecolor
                                //                 : orangecolor,
                                //             fontSize: 16),
                                //       ),
                                //       ),
                                //     ),
                                //     // culturelist[indexx].interest[index].value
                                //     //     ? Container(
                                //     //         margin: EdgeInsets.all(7),
                                //     //         // color: Colors.cyan.withAlpha(60),
                                //     //         child: Center(
                                //     //             child: Icon(
                                //     //           Icons.check_circle,
                                //     //           size: 25,
                                //     //           color: whitecolor,
                                //     //         )),
                                //     //       )
                                //     //     : Container()
                                //   ],
                                // ), //just for testing, will fill with image later
                              ),
                              // child: Stack(
                              //   children: <Widget>[
                              //     Card(
                              //       margin: EdgeInsets.all(5),
                              //       elevation: 2,
                              //       color: culturelist[indexx].interest[index].value?orangecolor:whitecolor,
                              //       shadowColor: bluecolor,
                              //       child: new GridTile(
                              //         //footer: new Text(data[index]['name']),
                              //         child: Center(
                              //             child: Text(
                              //               culturelist[indexx].interest[index].termText,
                              //               style: TextStyle(color: culturelist[indexx].interest[index].value?whitecolor:bluecolor,fontSize: 20),
                              //             )), //just for testing, will fill with image later
                              //       ),
                              //     ),
                              //     // artlist[indexx].interest[index].value? Container(
                              //     //   margin: EdgeInsets.all(5),
                              //     //   color: Colors.cyan.withAlpha(60),
                              //     //   child: Center(child: Icon(Icons.check,size: 60,color: whitecolor,)),
                              //     // ):Container()
                              //   ],
                              // ),
                            );
                          },
                        ),
                      ));
                }))
        : Container();
  }

  Widget _buildLitratureGrid(BuildContext context) {
    return litreaturelist != null
        ? Container(
            child: ListView.builder(
                itemCount: litreaturelist.length,
                itemBuilder: (context, indexx) {
                  return StickyHeader(
                      header: Container(
                        margin: EdgeInsets.only(top: 0, bottom: 10),
                        height: 50.0,
                        color: orangecolor,
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          litreaturelist[indexx].termText,
                          style: TextStyle(
                              color: whitecolor,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                      content: Container(
                        padding: EdgeInsets.only(top: 0.0),
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: litreaturelist[indexx].interest.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 2, crossAxisCount: 2),
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  litreaturelist[indexx].interest[index].value =
                                      !litreaturelist[indexx]
                                          .interest[index]
                                          .value;
                                });

                                if (litreaturelist[indexx]
                                    .interest[index]
                                    .value)
                                  selectedCount++;
                                else
                                  selectedCount--;
                              },
                              child: Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  border:
                                      Border.all(color: Colors.grey, width: 2),
                                  color: litreaturelist[indexx]
                                          .interest[index]
                                          .value
                                      ? orangecolor
                                      : whitecolor,
                                ),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    litreaturelist[indexx]
                                        .interest[index]
                                        .termText,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: litreaturelist[indexx]
                                                .interest[index]
                                                .value
                                            ? whitecolor
                                            : orangecolor,
                                        fontSize: 20),
                                  ),
                                ),
                                // child: Row(
                                //   mainAxisAlignment: MainAxisAlignment.center,
                                //   children: [
                                //     //Container(width: 20,),
                                //     Padding(
                                //       padding: const EdgeInsets.all(0.0),
                                //       child: Center(
                                //           child: Text(
                                //         litreaturelist[indexx]
                                //             .interest[index]
                                //             .termText,
                                //         style: TextStyle(
                                //             color: litreaturelist[indexx]
                                //                     .interest[index]
                                //                     .value
                                //                 ? whitecolor
                                //                 : orangecolor,
                                //             fontSize: 20),
                                //       ),
                                //       ),
                                //     ),
                                //     // litreaturelist[indexx].interest[index].value
                                //     //     ? Container(
                                //     //         margin: EdgeInsets.all(7),
                                //     //         // color: Colors.cyan.withAlpha(60),
                                //     //         child: Center(
                                //     //             child: Icon(
                                //     //           Icons.check_circle,
                                //     //           size: 25,
                                //     //           color: whitecolor,
                                //     //         )),
                                //     //       )
                                //     //     : Container()
                                //   ],
                                // ), //just for testing, will fill with image later
                              ),
                              // child: Stack(
                              //   children: <Widget>[
                              //     Card(
                              //       margin: EdgeInsets.all(5),
                              //       elevation: 2,
                              //       color: litreaturelist[indexx].interest[index].value?orangecolor:whitecolor,
                              //       shadowColor: bluecolor,
                              //       child: new GridTile(
                              //         //footer: new Text(data[index]['name']),
                              //         child: Center(
                              //             child: Text(
                              //               litreaturelist[indexx].interest[index].termText,
                              //               style: TextStyle(color: litreaturelist[indexx].interest[index].value?whitecolor:bluecolor,fontSize: 20),
                              //             )), //just for testing, will fill with image later
                              //       ),
                              //     ),
                              //     // artlist[indexx].interest[index].value? Container(
                              //     //   margin: EdgeInsets.all(5),
                              //     //   color: Colors.cyan.withAlpha(60),
                              //     //   child: Center(child: Icon(Icons.check,size: 60,color: whitecolor,)),
                              //     // ):Container()
                              //   ],
                              // ),
                            );
                          },
                        ),
                      ));
                }))
        : Container();
  }

  void _onTabPress0() {
    _pageController.animateToPage(0,
        duration: Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  void _onTabPress1() {
    _pageController.animateToPage(1,
        duration: Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  void _onTabPress2() {
    _pageController.animateToPage(2,
        duration: Duration(milliseconds: 500), curve: Curves.decelerate);
  }
}
