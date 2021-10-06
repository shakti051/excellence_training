import 'package:eduarno/repo/bloc/cms/cms_provider.dart';
import 'package:eduarno/widgets/load_html.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class TermsandCondition extends StatefulWidget {
  const TermsandCondition({Key key}) : super(key: key);

  @override
  _TermsandConditionState createState() => _TermsandConditionState();
}

class _TermsandConditionState extends State<TermsandCondition> {
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
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          backwardsCompatibility: false,
          systemOverlayStyle:
              SystemUiOverlayStyle(statusBarColor: Colors.white),
          elevation: 0,
          title: Text(
            "Terms and conditions",
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.black,
              // fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: SvgPicture.asset("assets/back.svg"),
            onPressed: () => {Navigator.pop(context)},
          ),
        ),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : getPrivacyPolicy(
                context,
                Provider.of<CMSProvider>(context, listen: false).cmsItemList,
                'Terms & Conditions'));
  }
}
