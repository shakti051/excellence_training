import 'dart:convert';

import 'package:custom_switch/custom_switch.dart';
import 'package:eduarno/repo/bloc/user.dart';
import 'package:eduarno/screens/cms/privacy_policy.dart';
import 'package:eduarno/screens/profile/academic_screen.dart';
import 'package:eduarno/screens/profile/edit_personal_profile.dart';
import 'package:eduarno/screens/profile/experience_screen.dart';
import 'package:eduarno/screens/profile/interest_screen.dart';
import 'package:eduarno/screens/profile/live_session.dart';

import 'package:eduarno/screens/profile/t&c.dart';
import 'package:eduarno/screens/session/session_screen.dart';
import 'package:eduarno/screens/wallet/wallet.dart';
import 'package:eduarno/widgets/shimmer_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';
//import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../../Utilities/constants.dart';
import 'experience_screen.dart';
import 'package:http/http.dart' as http;

class Profile extends StatefulWidget {
  final VoidCallback openDrawer;

  Profile({Key key, this.openDrawer}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
    // ProfileProvider().getState();
  }

  bool isLive = false;
  bool isNotification = false;

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
    var name = User().name[0].toUpperCase() + User().name.substring(1);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        backwardsCompatibility: true,
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.white),
        elevation: 0,
        title: Text(
          'Profile',
          style: TextStyle(
            fontSize: 24.0,
            fontFamily: 'Poppins',
            // color: Color(0xff303030),
            // fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.menu_open, color: Color(0xff303030)),
          onPressed: widget.openDrawer,
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 140,
                    width: 140,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage('assets/demo.png')),
                    ),
                  ),
                ],
              ),
              Text(
                name ?? 'none',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff303030)),
              ),
              Text(
                User().email ?? 'none',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff8C8C8C),
                ),
              ),
              if (true) ...[
                Padding(
                  padding: const EdgeInsets.only(
                      top: 24, left: 24, right: 24, bottom: 24),
                  child: Column(
                    children: [
                      Card(
                        elevation: 0,
                        color: AppColors.neutralGray,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        child: Column(
                          children: [
                            buildListTile(
                              'Personal information',
                              () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PersonalProfile()));
                              },
                              SvgPicture.asset('assets/Profile_fill.svg'),
                            ),
                            buildListTile(
                              'Academic information',
                              () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            AcademicScreen()));
                              },
                              SvgPicture.asset('assets/Folder.svg'),
                            ),
                            buildListTile(
                              'Experience information',
                              () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ExperienceScreen()));
                              },
                              SvgPicture.asset('assets/Work.svg'),
                            ),
                            buildListTile(
                              'Interest',
                              () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            InterestScreen()));
                              },
                              SvgPicture.asset('assets/Heart.svg'),
                            ),
                            buildListTile(
                              'Wallet',
                              () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Wallet()));
                              },
                              Icon(Icons.wallet_membership,
                                  size: 24, color: Colors.black),
                              // SvgPicture.asset("assets/Heart.svg"),
                            ),
                            Consumer<User>(
                              builder: (context, data, child) {
                                final user = context.watch<User>();
                                return ListTile(
                                  leading: SvgPicture.asset('assets/Play.svg'),
                                  title: Text(
                                    'Live sessions',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Poppins'),
                                  ),
                                  onTap: () => Navigator.push(
                                    context,
                                    PageTransition(
                                      type: PageTransitionType.bottomToTop,
                                      child: LiveSessions(),
                                    ),
                                  ),
                                  trailing: Container(
                                    height: 24,
                                    width: 55,
                                    child: FittedBox(
                                      fit: BoxFit.cover,
                                      child: CustomSwitch(
                                        value: user.liveSessionTrigger ?? false,
                                        activeColor: Colors.green,
                                        onChanged: (value) {
                                          user.setTrigger(value);
                                          setLiveSession(value);
                                        },
                                      ),
                                    ),
                                  ),
                                );
                              },
                            )
                          ], // Add tiles Within cards
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: Card(
                          elevation: 0,
                          color: AppColors.neutralGray,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              buildListTile(
                                'Terms of Services',
                                () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              TermsandCondition()));
                                },
                                SvgPicture.asset('assets/Paper.svg'),
                              ),
                              buildListTile(
                                'Privacy Policy',
                                () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PrivacyPolicy()));
                                },
                                SvgPicture.asset('assets/Folder.svg'),
                              ),
                              buildListTile(
                                'Feedback',
                                () {},
                                SvgPicture.asset('assets/Messagesicon.svg'),
                              ),
                            ], // Add tiles Within cards
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: Card(
                          elevation: 0,
                          color: AppColors.neutralGray,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          child: Column(
                            children: [
                              ListTile(
                                leading: SvgPicture.asset(
                                  'assets/Notification.svg',
                                  color: Colors.black,
                                ),
                                title: Text(
                                  'Notifications',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Poppins'),
                                ),
                                trailing: Container(
                                  height: 24,
                                  width: 55,
                                  child: FittedBox(
                                    fit: BoxFit.cover,
                                    child: CustomSwitch(
                                      value: isNotification,
                                      activeColor: Colors.green,
                                      onChanged: (value) {
                                        isNotification = value;
                                      },
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget buildListTile(String title, Function userFunction, Widget icon) {
    return ListTile(
      leading: icon,
      onTap: () {
        userFunction();
      },
      title: Text(
        title,
        style: TextStyle(
            fontSize: 16, fontWeight: FontWeight.w500, fontFamily: 'Poppins'),
      ),
      trailing: SvgPicture.asset('assets/Stroke 1.svg'),
    );
  }
}
