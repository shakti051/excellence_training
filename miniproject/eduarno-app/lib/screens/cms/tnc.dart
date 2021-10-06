import 'package:eduarno/repo/bloc/cms/cms_provider.dart';
import 'package:eduarno/widgets/shimmer_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../Utilities/constants.dart';
import '../../widgets/load_html.dart';

class Tnc extends StatefulWidget {
  const Tnc({Key key}) : super(key: key);

  @override
  _TncState createState() => _TncState();
}

class _TncState extends State<Tnc> {
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
        // backgroundColor: kLightGray,
        appBar: AppBar(
          backgroundColor: kLightGray,
          backwardsCompatibility: false,
          // systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: kLightGray),
          elevation: 0,
          title: Text(
            "TNC",
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.black,
              fontWeight: FontWeight.w700,
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
          //   "TNC",
          //   style: TextStyle(
          //       fontSize: 18.0, color: Colors.black, fontWeight: FontWeight.w700),
          // ),
          // centerTitle: true,
          // leading: IconButton(
          //     icon: Icon(Icons.keyboard_backspace, color: Colors.black),
          //     onPressed: () => {Navigator.of(context).pop()},
          //     >>>>>>> 63937530bbe126c1705142b4190bc9d7f6820e71
        ),
        body: isLoading
            ? MyShimmer()
            : getPrivacyPolicy(
                context,
                Provider.of<CMSProvider>(context, listen: false).cmsItemList,
                'Terms & Conditions'));
  }
}
