import 'package:eduarno/Utilities/constants.dart';
import 'package:eduarno/repo/bloc/cms/cms_provider.dart';
import 'package:eduarno/widgets/load_html.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class RefundPolicy extends StatefulWidget {
  const RefundPolicy({Key key}) : super(key: key);

  @override
  _RefundPolicyState createState() => _RefundPolicyState();
}

class _RefundPolicyState extends State<RefundPolicy> {
  bool isLoading = true;

  @override
  void initState() {
    if (CMSProvider().cmsItemList.isEmpty) {
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
    } else {
      setState(() {
        isLoading = false;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: kLightGray,
        appBar: AppBar(
          // backgroundColor: kLightGray,
          backwardsCompatibility: false,
          // systemOverlayStyle:
          // SystemUiOverlayStyle(statusBarColor: Colors.white),
          elevation: 0,
          title: Text(
            "Refund Policy",
            style: TextStyle(
              fontSize: 18.0,
              color: kChatColor,
              // fontWeight: FontWeight.w700,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.keyboard_backspace, color: Colors.black),
            onPressed: () => {Navigator.of(context).pop()},
          ),
          // backwardsCompatibility: false,
          // systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.white),
          // elevation: 0,
          // title: Text(
          //   "Refund Policy",
          //   style: TextStyle(
          //       fontSize: 18.0, color: Colors.black, fontWeight: FontWeight.w700),
          // ),
          // centerTitle: true,
          // leading: IconButton(
          //   icon: Icon(Icons.keyboard_backspace, color: Colors.black),
          //   onPressed: () => {Navigator.of(context).pop()},
        ),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : getPrivacyPolicy(
                context,
                Provider.of<CMSProvider>(context, listen: false).cmsItemList,
                'Refund Policy'));
  }
}
