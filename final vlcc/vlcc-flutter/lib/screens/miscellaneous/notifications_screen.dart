import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vlcc/models/notificaitons_model.dart';
import 'package:vlcc/providers/notifications_provider.dart';
import 'package:vlcc/resources/app_colors.dart';
import 'package:vlcc/resources/assets_path.dart';
import 'package:vlcc/resources/dimensions.dart';
import 'package:vlcc/screens/miscellaneous/notification_tile.dart';
import 'package:vlcc/widgets/heading_title_text.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late Future<List<NotificationDetailModel>> notifications;
  final NotificationProvider _notificationProvider = NotificationProvider();

  @override
  void initState() {
    super.initState();
    notifications = _notificationProvider.getNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: _appBar(),
      body: _body(),
    );
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: AppColors.backgroundColor,
      leading: Transform.scale(
        scale: 1.4,
        child: Container(
          margin: EdgeInsets.only(left: 24, top: 12, bottom: 12),
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: AppColors.backBorder),
              borderRadius: BorderRadius.circular(8)),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: SvgPicture.asset(SVGAsset.backButton),
          ),
        ),
      ),
      title: Text(
        ' VLCC',
        textAlign: TextAlign.left,
        style: TextStyle(
          color: AppColors.logoOrange,
          fontWeight: FontWeight.w700,
          fontSize: FontSize.heading,
        ),
      ),
      centerTitle: false,
    );
  }

  Widget _body() {
    return FutureBuilder<List<NotificationDetailModel>>(
      future: notifications,
      builder: (BuildContext context,
          AsyncSnapshot<List<NotificationDetailModel>> snapshot) {
        Widget child = SizedBox();
        switch (snapshot.connectionState) {
          case ConnectionState.active:
            break;
          case ConnectionState.done:
            List<NotificationDetailModel> notificationList =
                snapshot.data ?? [];
            child = SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: HeadingTitleText(
                      fontSize: FontSize.heading,
                      title: 'Notifications',
                    ),
                  ),
                  ListView.builder(
                    itemCount: notificationList.length,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      NotificationDetailModel notificationDetailModel =
                          notificationList[index];
                      bool isRead = notificationDetailModel.notificationstatus
                                  .toLowerCase() ==
                              'pending'
                          ? false
                          : true;
                      return NotificationTile(
                        isRead: isRead,
                        notificationDetailModel: notificationDetailModel,
                        notificationProvider: _notificationProvider,
                      );
                    },
                  )
                ],
              ),
            );
            break;
          case ConnectionState.waiting:
            child = Center(
                child: CircularProgressIndicator(color: AppColors.orange));
            break;
          default:
        }
        return child;
      },
    );
  }
}
