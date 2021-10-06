import 'package:eduarno/repo/bloc/cms/cms_provider.dart';
import 'package:eduarno/widgets/load_html.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../Utilities/constants.dart';

class About extends StatefulWidget {
  const About({Key key}) : super(key: key);

  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
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
          backgroundColor: kLightGray,
          backwardsCompatibility: false,
          systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: kLightGray),
          elevation: 0,
          title: Text(
            'About Us',
            style: TextStyle(
              fontSize: 18.0,
              color: kChatColor,
              fontWeight: FontWeight.w700,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.keyboard_backspace, color: Colors.black),
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
                'About Us'));
  }
}
