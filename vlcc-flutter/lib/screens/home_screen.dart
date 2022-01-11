import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:vlcc/database/db_helper.dart';
import 'package:vlcc/providers/notifications_provider.dart';
import 'package:vlcc/providers/shared_pref.dart';
import 'package:vlcc/resources/app_colors.dart';
import 'package:vlcc/resources/assets_path.dart';
import 'package:vlcc/resources/common_strings.dart';
import 'package:vlcc/resources/dimensions.dart';
import 'package:vlcc/screens/categories_widget.dart';
import 'package:vlcc/screens/packages/package_provider.dart';
import 'package:vlcc/screens/packages/package_routes.dart';
import 'package:vlcc/widgets/dashboard_widgets/dashboard_widgets.dart';

class HomeScreen extends StatefulWidget {
  static final GlobalKey bannerKey = GlobalKey(debugLabel: '_bannerKey');
  static final GlobalKey notificationKey =
      GlobalKey(debugLabel: '_notificationKey');
  static final GlobalKey profileKey = GlobalKey(debugLabel: '_profileKey');

  final String title;
  final Color titleColor;

  const HomeScreen({
    Key? key,
    required this.title,
    this.titleColor = Colors.black,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PackageProvider _packageProvider = PackageProvider();
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  final DashboardProvider _dashboardProvider = DashboardProvider();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  final NotificationProvider _notificationProvider = NotificationProvider();
  num unreadCount = 0;

  @override
  void initState() {
    super.initState();
    apiCall();
    _getUnreadCount();
  }

  Future<void> apiCall() async {
    await _packageProvider.getPackageModelData();
    await _packageProvider.getCashInvoice();
    _databaseHelper.getUniqueSpeciality();
    await _dashboardProvider.getAppointmentList();
    _dashboardProvider.getProfileDetails();
    await _dashboardProvider.getGeneralAppointmentList();
  }

  @override
  Widget build(BuildContext context) {
    final _sharedPrefs = context.watch<VlccShared>();
    final _packageProvider = context.watch<PackageProvider>();
    final dashboardProvider = context.watch<DashboardProvider>();
    final databaseHelper = context.watch<DatabaseHelper>();
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        centerTitle: false,
        title: Text(
          widget.title,
          textAlign: TextAlign.left,
          style: TextStyle(
            color: widget.titleColor,
            fontWeight: FontWeight.w700,
            fontSize: FontSize.heading,
            fontFamily: FontName.frutinger,
          ),
        ),
        actions: [
          IconButton(
            padding: EdgeInsets.all(0),
            onPressed: () {
              Navigator.pushNamed(context, PackageRoutes.notifications)
                  .then((value) {
                _getUnreadCount();
              });
            },
            icon: Badge(
              padding: EdgeInsets.all(4.0),
              animationType: BadgeAnimationType.scale,
              animationDuration: const Duration(milliseconds: 200),
              showBadge: unreadCount == 0 ? false : true,
              badgeContent: Text(
                '${unreadCount.ceil()}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: FontSize.extraSmall,
                ),
              ),
              position: BadgePosition.topEnd(end: -4),
              child: SvgPicture.asset(
                SVGAsset.notification,
                key: HomeScreen.notificationKey,
                color: Colors.black,
              ),
            ),
          ),
          InkWell(
            onTap: showMenuDialog,
            child: CircleAvatar(
              key: HomeScreen.profileKey,
              backgroundImage: Image.asset(PNGAsset.avatar).image,
              foregroundImage: NetworkImage(_sharedPrefs.profileImage),
            ),
          ),
          SizedBox(width: 16)
        ],
      ),
      body: SafeArea(
        child: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: () async {
            apiCall();
          },
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 26),
                DashboardSlider(),
                Visibility(
                  visible: _packageProvider.inActivePackages.isNotEmpty,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: ViewPackages(),
                  ),
                ),
                SizedBox(height: 20),
                Categories()
              ],
            ),
          ),
        ),
      ),
    );
  }

  _getUnreadCount() {
    _notificationProvider.getNotifications().then((value) {
      setState(() {
        unreadCount = _notificationProvider.unreadCount;
      });
    });
  }

  showMenuDialog() {
    return showDialog(
      context: context,
      builder: (BuildContext c) {
        return ProfileDialouge();
      },
    );
  }
}
