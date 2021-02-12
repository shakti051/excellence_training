import 'package:feedback/widgets/account_widgets/account_widgets.dart';
import 'package:feedback/widgets/account_widgets/my_documents/documents.dart';
import 'package:feedback/widgets/account_widgets/my_documents/my_documents.dart';
import 'package:flutter/material.dart';
import 'package:feedback/resources/app_colors.dart';

class ResponsiveDocument extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.THEME_COLOR,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MobMenuhzr(),
              MobAdvertise(),
              SizedBox(height: 10),
              AccountType(),
              SizedBox(height: 10),
              MobProfileMenu(),
              SizedBox(height: 10),
              DocumentHeading(),
              Documents(),
              UploadedDocuments(),
              SizedBox(height: 30),
              BrowseFiles(),
              SizedBox(height: 30)
            ],
          ),
        ),
      ),
    );
  }
}