import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:vlcc/database/db_helper.dart';
import 'package:vlcc/models/unique_service_model.dart';
import 'package:vlcc/models/vlcc_reminder_model.dart';
import 'package:vlcc/resources/app_colors.dart';
import 'package:vlcc/resources/assets_path.dart';
import 'package:vlcc/resources/dimensions.dart';
import 'package:vlcc/screens/search/specialities.dart';
import 'package:vlcc/widgets/appointment_widgets/add_reminder.dart';
import 'package:vlcc/widgets/appointment_widgets/view_reminder.dart';
import 'package:vlcc/widgets/dashboard_widgets/dashboard_widgets.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  viewReminderDialog({required VlccReminderModel vlccReminderModel}) {
    return showDialog(
        context: context,
        builder: (BuildContext c) {
          return ViewReminder(
            vlccReminderModel: vlccReminderModel,
          );
        });
  }

  addReminderDialog(
      {required int index,
      int appointmentType = 0,
      required String addressLine1,
      required String addressLine2,
      required String appointmentId,
      required DateTime appointmentDate,
      required String title,
      required int appointmentSeconds}) {
    return showDialog(
        context: context,
        builder: (BuildContext c) {
          return AddReminder(
            appointmentType: appointmentType,
            addressLine1: addressLine1,
            appointmentseconds: appointmentSeconds,
            index: index,
            serviceName: title,
            addressLine2: addressLine2,
            appointmentDate: appointmentDate,
            appointmentId: appointmentId,
          );
        });
  }

  int findSnapshotIndex(
      {required int appointmentId,
      required List<VlccReminderModel> listReminder}) {
    var result = listReminder
        .indexWhere((element) => element.appointmentId == appointmentId);
    return result;
  }

  late DashboardProvider dashboardProvider;
  late DatabaseHelper databaseHelper;

  @override
  void initState() {
    super.initState();
    // dashboardProvider = context.watch<DashboardProvider>();
    // databaseProvider = context.watch<DatabaseHelper>();
    // databaseProvider.uniqueServiceListFilter =
    //     databaseProvider.uniqueServiceList;
  }

  Future<bool> rebuild() async {
    if (!mounted) return false;

    // if there's a current frame,
    if (SchedulerBinding.instance?.schedulerPhase != SchedulerPhase.idle) {
      // wait for the end of that frame.
      await SchedulerBinding.instance?.endOfFrame;
      databaseHelper.uniqueServiceListFilter =
          // ignore: avoid_function_literals_in_foreach_calls
          databaseHelper.uniqueServiceList;
      //     .forEach((element) {
      //   log('$element category name');
      // });
      if (!mounted) return false;
    }

    setState(() {});
    return true;
  }

  final GlobalKey _categoryKey = GlobalKey(debugLabel: '_categoryKey');
  final GlobalKey _bannerKey = GlobalKey(debugLabel: '_bannerKey');
  final GlobalKey _notificationKey = GlobalKey(debugLabel: '_notificationKey');
  final GlobalKey _profileKey = GlobalKey(debugLabel: '_profileKey');

  @override
  Widget build(BuildContext context) {
    dashboardProvider = context.watch<DashboardProvider>();
    databaseHelper = context.watch<DatabaseHelper>();
    rebuild();

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          Row(
            children: const [
              Text("Categories",
                  // "Categories (${databaseHelper.uniqueServiceListFilter.length})",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: FontSize.extraLarge)),
              Spacer(),
              // InkWell(
              //     onTap: () {
              //       Navigator.push(
              //           context,
              //           PageTransition(
              //               type: PageTransitionType.rightToLeft,
              //               child: UpcomingGeneralAppointment()));
              //     },
              //     child: Icon(Icons.arrow_forward))
            ],
          ),
          SizedBox(
            height: 20,
          ),
          _categories(
            dashboardProvider: dashboardProvider,
            databaseHelper: databaseHelper,
          ),
        ],
      ),
    );
  }

  int convertToTime({required DateTime temp}) {
    var seconds = temp.difference(DateTime.now()).inSeconds;
    return seconds;
  }

  Widget _categories({
    required DashboardProvider dashboardProvider,
    required DatabaseHelper databaseHelper,
  }) {
    /*
    
 
            databaseHelper.uniqueServiceListFilter.every((element) {
              return !(element.serviceCategory.toLowerCase() == 'card');
            })

    */
    List<UniqueServiceModel> _uniqueServiceModelList = [];
    for (var element in databaseHelper.uniqueServiceListFilter) {
      switch (element.serviceCategory.toLowerCase()) {
        case 'beauty':
          _uniqueServiceModelList.add(element);
          break;
        case 'card':
          break;
        case 'cards':
          break;
        case 'dermat':
          _uniqueServiceModelList.add(element);
          break;
        case 'laser':
          _uniqueServiceModelList.add(element);
          break;
        case 'memberships':
          _uniqueServiceModelList.add(element);
          break;
        case 'product':
          break;
        case 'rbs':
          _uniqueServiceModelList.add(element);
          break;
        case 'slimming':
          _uniqueServiceModelList.add(element);
          break;
        default:
      }
    }

    return _uniqueServiceModelList.isNotEmpty
        ? GridView.builder(
            clipBehavior: Clip.antiAlias,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: _uniqueServiceModelList.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                child: Card(
                    clipBehavior: Clip.antiAlias,
                    elevation: 12,
                    child: Stack(
                      children: [
                        _image(
                          uniqueServiceModel: _uniqueServiceModelList[index],
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Container(
                            color: AppColors.orangeCategoryTextBackground,
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  _uniqueServiceModelList[index]
                                      .serviceCategory
                                      .toString(),
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.normal,
                                    color: Colors.white,
                                  )),
                            ),
                          ),
                        )
                      ],
                    )),
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      child: Specialities(
                        uniqueServiceModel: _uniqueServiceModelList[index],
                      ),
                      type: PageTransitionType.rightToLeft,
                    ),
                  );
                },
              );
            },
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1 / 1.1,
            ),
          )
        : _shimmer();

    // NoDataScreen(
    //     noDataSelect: NoDataSelectType.feelsEmptyHere,
    //   );
  }

  Image _image({
    required UniqueServiceModel uniqueServiceModel,
  }) {
    String _imageAsset = PNGAsset.clinicLogo;

    switch (uniqueServiceModel.serviceCategory.toLowerCase()) {
      case 'beauty':
        _imageAsset = PNGAsset.beauty;
        break;
      case 'cards':
        _imageAsset = PNGAsset.hairTransplant;
        break;
      case 'card':
        _imageAsset = PNGAsset.slimming;
        break;
      case 'dermat':
        _imageAsset = PNGAsset.dermatology;
        break;
      case 'laser':
        _imageAsset = PNGAsset.laser;
        break;
      case 'memberships':
        _imageAsset = JPGAsset.beautyHomeWellness;
        break;
      case 'product':
        _imageAsset = PNGAsset.hairTransplant;
        break;
      case 'rbs':
        _imageAsset = JPGAsset.coupleEnd;
        break;
      case 'slimming':
        _imageAsset = PNGAsset.slimming;
        break;
      default:
        _imageAsset = PNGAsset.beauty;
    }

    Image _image = Image.network(
      '',
      errorBuilder: (context, object, _) {
        return SizedBox(
          width: double.infinity,
          child: Image.asset(
            _imageAsset,
            fit: BoxFit.fill,
          ),
        );
      },
    );

    return _image;
  }

  Shimmer _shimmer() {
    return Shimmer.fromColors(
      highlightColor: Colors.white,
      baseColor: Colors.grey.shade300,
      child: GridView.builder(
        clipBehavior: Clip.antiAlias,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: 2,
        itemBuilder: (context, index) {
          return Card(
            clipBehavior: Clip.antiAlias,
            elevation: 12,
          );
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 1 / 1.1,
        ),
      ),
    );
  }
}
