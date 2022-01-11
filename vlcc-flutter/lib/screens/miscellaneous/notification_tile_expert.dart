import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jiffy/jiffy.dart';
import 'package:vlcc/models/notificaitons_model.dart';
import 'package:vlcc/providers/notification_provider_expert.dart';
import 'package:vlcc/resources/app_colors.dart';
import 'package:vlcc/resources/assets_path.dart';
import 'package:vlcc/resources/dimensions.dart';

class NotificationTileExpert extends StatefulWidget {
  final NotificationDetailModel notificationDetailModel;
  final bool isRead;
  final NotificationProviderExpert notificationProvider;

  const NotificationTileExpert({
    Key? key,
    required this.notificationDetailModel,
    required this.isRead,
    required this.notificationProvider,
  }) : super(key: key);


  @override
  _NotificationTileExpertState createState() => _NotificationTileExpertState();
}

class _NotificationTileExpertState extends State<NotificationTileExpert> {
late final NotificationDetailModel notificationDetailModel;
  late bool isRead;
  late NotificationProviderExpert _notificationProvider;

  @override
  void initState() {
    isRead = widget.isRead;
    notificationDetailModel = widget.notificationDetailModel;
    _notificationProvider = widget.notificationProvider;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        isRead = await _notificationProvider.updateReadStatus(
            notificationID: notificationDetailModel.notificationId);
        setState(() {});
      },
      child: _notificationTile(
        message: notificationDetailModel.notificationmessage,
        time: notificationDetailModel.createdTime,
        date: notificationDetailModel.createdDate,
        isRead: isRead,
      ),
    );
  }

  Widget _notificationTile({
    required String message,
    required String time,
    required String date,
    required bool isRead,
  }) {
    DateTime dateTime = DateTime.parse('$date $time');
    String fromNow = Jiffy(dateTime).fromNow();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Card(
        elevation: 3,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: ListTile(
          tileColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(horizontal: 8),
          leading: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Badge(
                showBadge: !isRead,
                badgeColor: AppColors.orange,
                animationType: BadgeAnimationType.fade,
              ),
              SizedBox(
                width: 10,
              ),
              SvgPicture.asset(SVGAsset.orangeTask),
            ],
          ),
          title: RichText(
            textAlign: TextAlign.start,
            text: TextSpan(
                text: message,
                style: TextStyle(
                  color: AppColors.profileEnabled,
                  fontWeight: FontWeight.w400,
                  fontSize: FontSize.normal,
                ),
                children: const [TextSpan(text: '\n')]),
          ),
          subtitle: Text(fromNow),
        ),
      ),
    );
  }
}
