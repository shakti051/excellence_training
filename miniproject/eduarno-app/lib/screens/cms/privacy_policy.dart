import 'package:eduarno/Utilities/constants.dart';
import 'package:eduarno/repo/bloc/cms/cms_provider.dart';
import 'package:eduarno/widgets/load_html.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({Key key}) : super(key: key);

  @override
  _PrivacyPolicyState createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  bool isLoading = true;

  @override
  void initState() {
    // if (CMSProvider().cmsItemList.isEmpty) {
    CMSProvider()
        .getCMS()
        .then((value) => {
              setState(() {
                isLoading = false;
              })
            })
        .catchError((e) {
      print('Error = $e #33232');
    });
    // } else {
    // setState(() {
    // isLoading = true;
    // });
    // }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          backwardsCompatibility: false,
          systemOverlayStyle:
              SystemUiOverlayStyle(statusBarColor: Colors.white),
          elevation: 0,
          title: Text(
            "Privacy policy",
            style: TextStyle(
              // fontSize: 22.0,
              color: kChatColor,
              // fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: SvgPicture.asset("assets/back.svg"),
            onPressed: () => {Navigator.of(context).pop()},
          ),
        ),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : getPrivacyPolicy(
                context,
                Provider.of<CMSProvider>(context, listen: false).cmsItemList,
                'Privacy Policy'));
  }
}
