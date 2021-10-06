import 'package:eduarno/repo/bloc/cms/model/CMSItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

Widget loadHtml(BuildContext context, String data1) {
  return Scaffold(
    body: ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          // child: Text(
          //   data1,
          //   style: TextStyle(
          //       fontSize: 16,
          //       fontWeight: FontWeight.w500,
          //       fontFamily: 'Poppins'),
          // ),
          child: Html(data: data1),
        )
      ],
    ),
  );
}

Widget getPrivacyPolicy(BuildContext context, List<CMSItem> list, String type) {
  String data = '';
  for (CMSItem cmsItem in list) {
    if (cmsItem.page == type) {
      data = cmsItem.description;
    }
  }
  return loadHtml(context, data);
}
