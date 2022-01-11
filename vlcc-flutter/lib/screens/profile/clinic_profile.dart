import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vlcc/database/db_helper.dart';
import 'package:vlcc/models/center_master_model.dart';
import 'package:vlcc/models/service_master_model.dart';
import 'package:vlcc/resources/apiHandler/api_url/api_url.dart';
import 'package:vlcc/resources/app_colors.dart';
import 'package:vlcc/resources/assets_path.dart';
import 'package:vlcc/resources/common_strings.dart';
import 'package:vlcc/resources/dimensions.dart';
import 'package:vlcc/resources/string_extensions.dart';
import 'package:vlcc/screens/appointments/book_service.dart';
import 'package:vlcc/widgets/custom_input_cards.dart';
import 'package:vlcc/widgets/heading_title_text.dart';
import 'package:vlcc/widgets/signup_widgets/profile_provider.dart';

class ClinicProfileBooking extends StatefulWidget {
  final CenterMasterDatabase centerMasterDatabase;
  const ClinicProfileBooking({
    Key? key,
    required this.centerMasterDatabase,
  }) : super(key: key);

  @override
  _ClinicProfileBookingState createState() => _ClinicProfileBookingState();
}

bool isExpanded = false;

class _ClinicProfileBookingState extends State<ClinicProfileBooking>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  Set<Marker> _markers = {};
  BitmapDescriptor? mapMarker;
  final DatabaseHelper db = DatabaseHelper();
  final LatLng _initialcameraposition = LatLng(20.5937, 78.9629);
  GoogleMapController? _mapController;
  String? searchAddr;

  void setCustomMarker() async {
    mapMarker = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(50, 70)), PNGAsset.markerIcon);
  }

  @override
  void initState() {
    setCustomMarker();
    tabController = TabController(initialIndex: 0, length: 2, vsync: this);
    super.initState();
  }

  void _onMapCreated(controller) {
    setState(() {
      _mapController = controller;
      _markers.add(Marker(
        markerId: MarkerId("id-1"),
        position: LatLng(
            double.parse(widget.centerMasterDatabase.centerLatitude),
            double.parse(widget.centerMasterDatabase.centerLongitude)),
        infoWindow: InfoWindow(
          title: widget.centerMasterDatabase.areaName,
          snippet: widget.centerMasterDatabase.cityName,
        ),
        icon: mapMarker!,
      ));

      //28.5561671,77.0977691
    });
  }

  Future<void> launchCentre({required String url}) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> launchCaller({required String phoneNumber}) async {
    String url = "tel:$phoneNumber";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> launchMail({required String email}) async {
    String url = "mailto:$email";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    final databaseProvider = context.watch<DatabaseHelper>();
    final profileProvider = context.read<ProfileProvider>();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(width: 15),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                    padding: EdgeInsets.all(PaddingSize.small),
                    decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.circular(8)),
                    child: Icon(
                      Icons.keyboard_backspace,
                      size: 24,
                    )),
              ),
            ],
          ),
          actions: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: InkWell(
                    onTap: () {
                      launchCentre(url: widget.centerMasterDatabase.centerMap);
                    },
                    child: Container(
                      padding: EdgeInsets.all(PaddingSize.small),
                      decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(8)),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: SvgPicture.asset('assets/icons/forward.svg'),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 15)
              ],
            ),
          ],
        ),
        body: Column(
          children: [
            Container(
              color: AppColors.backgroundColor,
              child: Stack(
                children: [
                  SizedBox(
                    height: 253,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Image.asset(
                        SVGAsset.clinicImage,
                        filterQuality: FilterQuality.high,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 200, bottom: 0),
                        child: clinicCard(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              color: AppColors.backgroundColor,
              height: 50,
              child: TabBar(
                padding: EdgeInsets.only(right: screenSize.width * 0.32),
                indicatorColor: AppColors.profileEnabled,
                controller: tabController,
                tabs: const <Widget>[
                  Tab(
                    child: Text(
                      'Basic information',
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Services',
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                child: body(
              databaseHelper: databaseProvider,
              profileProvider: profileProvider,
            ))
          ],
        ),
      ),
    );
  }

  Widget body(
          {required DatabaseHelper databaseHelper,
          required ProfileProvider profileProvider}) =>
      TabBarView(
        controller: tabController,
        children: [
          basicInformation(),
          services(
            databaseHelper: databaseHelper,
            profileProvider: profileProvider,
          ),
        ],
      );

  Padding services(
      {required DatabaseHelper databaseHelper,
      required ProfileProvider profileProvider}) {
    return Padding(
      padding: const EdgeInsets.only(
          left: PaddingSize.extraLarge, right: PaddingSize.extraLarge, top: 16),
      child: ListView.builder(
          padding: EdgeInsets.all(0),
          itemCount: databaseHelper.uniqueServiceList.length,
          itemBuilder: (context, index) {
            return serviceCategory(
                databaseHelper: databaseHelper,
                count: databaseHelper.uniqueServiceList[index].count,
                serviceCategory:
                    databaseHelper.uniqueServiceList[index].serviceCategory,
                profileProvider: profileProvider);
          }),
    );
  }

  Column serviceCategory(
      {required String serviceCategory,
      required int count,
      required DatabaseHelper databaseHelper,
      required ProfileProvider profileProvider}) {
    var services = databaseHelper.serviceFilterList
        .where(
          (service) => service.serviceCategory.toLowerCase().contains(
                serviceCategory.toLowerCase(),
              ),
        )
        .toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            HeadingTitleText(
              fontSize: FontSize.extraLarge,
              title: serviceCategory,
            ),
          ],
        ),
        bookingList(
            listCount: services.length,
            serviceDatabase: services,
            profileProvider: profileProvider),
      ],
    );
  }

  Widget bookingList({
    required int listCount,
    required List<ServiceMasterDatabase> serviceDatabase,
    required ProfileProvider profileProvider,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: PaddingSize.extraLarge),
      child: Column(
        children: List.generate(listCount, (index) {
          return listCount != 0
              ? ListTile(
                  leading: Container(
                    width: 52,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Image.asset(PNGAsset.clinicLogo),
                  ),
                  trailing: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 20),
                      onPrimary: AppColors.orangeShadow,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      elevation: 0,
                      primary: Colors.white,
                      side: BorderSide(color: AppColors.orange),
                    ),
                    onPressed: () {
                      profileProvider.isLoading = false;
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return BookService(
                            centerMasterDatabase: widget.centerMasterDatabase,
                            serviceMasterDatabase: serviceDatabase[index],
                          );
                        }),
                      );
                    },
                    child: HeadingTitleText(
                      fontSize: FontSize.normal,
                      title: 'Book',
                      color: AppColors.orange,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  tileColor:
                      index % 2 == 0 ? AppColors.greyBackground : Colors.white,
                  title: HeadingTitleText(
                    padding: 0,
                    fontSize: FontSize.normal,
                    title: serviceDatabase[index].serviceName,
                    fontWeight: FontWeight.w400,
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      '₹ ${serviceDatabase[index].serviceType.trim().toLowerCase().toTitleCase}',
                      style: TextStyle(
                        fontFamily: FontName.frutinger,
                        fontWeight: FontWeight.w600,
                        fontSize: FontSize.small,
                        color: AppColors.orangeCategoryTextBackground,
                      ),
                    ),
                  ),
                )
              : ListTile(
                  title: HeadingTitleText(
                    title:
                        'Sorry the service you are looking for is not available at the moment',
                    fontSize: FontSize.defaultFont,
                  ),
                );
        }),
      ),
    );
  }

  Widget basicInformation() {
    return ListView(
      padding: const EdgeInsets.all(0),
      children: [
        FieldCards(
          columnWidgets: [
            Wrap(
              children: [
                AnimatedSize(
                  duration: const Duration(milliseconds: 500),
                  child: ConstrainedBox(
                    constraints: isExpanded
                        ? BoxConstraints()
                        : BoxConstraints(maxHeight: 50.0),
                    child: Text(
                      ApiUrl.aboutSectionInfo,
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),
                isExpanded
                    ? TextButton(
                        onPressed: () => setState(() => isExpanded = false),
                        child: Text(
                          'Read less',
                          style: TextStyle(color: AppColors.orange),
                        ))
                    : TextButton(
                        onPressed: () => setState(() => isExpanded = true),
                        child: Text(
                          'Read more',
                          style: TextStyle(color: AppColors.orange),
                        ))
              ],
            ),
          ],
          cardTitle: 'About',
          headerPadding: PaddingSize.normal,
        ),
        FieldCards(columnWidgets: [
          ConstrainedBox(
            constraints: BoxConstraints(),
            child: HeadingTitleText(
              fontSize: FontSize.normal,
              title:
                  '''${widget.centerMasterDatabase.addressLine1},\n${widget.centerMasterDatabase.addressLine2}\n${widget.centerMasterDatabase.addressLine3}''',
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Row(
            children: const [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.watch_later_rounded,
                  color: AppColors.orange,
                ),
              ),
              HeadingTitleText(
                fontSize: FontSize.normal,
                title: '08:00 am - 08:00 pm',
                fontWeight: FontWeight.w400,
              ),
            ],
          ),
          InkWell(
            onTap: () => launchCaller(
              phoneNumber:
                  widget.centerMasterDatabase.phoneNumber.split('/')[0],
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset('assets/icons/orangeCall.svg'),
                ),
                HeadingTitleText(
                  fontSize: FontSize.normal,
                  title: widget.centerMasterDatabase.phoneNumber,
                  color: AppColors.orange,
                ),
              ],
            ),
          ),
          // InkWell(
          //   onTap: () => launchMail(
          //       email: widget.centerMasterDatabase.phoneNumber.toString()),
          //   child: Row(
          //     children: [
          //       Padding(
          //         padding: const EdgeInsets.all(8.0),
          //         child: SvgPicture.asset('assets/icons/orangeMail.svg'),
          //       ),
          //       HeadingTitleText(
          //         fontSize: FontSize.normal,
          //         title: widget.centerMasterDatabase.phoneNumber.toString(),
          //         color: AppColors.orange,
          //       ),
          //     ],
          //   ),
          // ),
        ], cardTitle: 'Contact details'),
        Container(
          margin:
              EdgeInsets.symmetric(horizontal: 28, vertical: MarginSize.middle),
          height: 500,
          child: GoogleMap(
            onMapCreated: _onMapCreated,
            markers: _markers,
            initialCameraPosition: CameraPosition(
                target: LatLng(
                    double.parse(widget.centerMasterDatabase.centerLatitude),
                    double.parse(widget.centerMasterDatabase.centerLongitude)),
                zoom: 8),
          ),
        ),
        SizedBox(height: 50)
      ],
    );
  }

  Widget clinicCard() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        color: Colors.white,
        shadowColor: Colors.black26,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 24, 0),
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: Image.asset(
                  PNGAsset.clinicLogo,
                  width: 52,
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: HeadingTitleText(
                          fontSize: FontSize.heading,
                          title: widget.centerMasterDatabase.centerName
                              .toUpperCase(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 2.0),
                        child: HeadingTitleText(
                          fontSize: FontSize.normal,
                          fontWeight: FontWeight.w600,
                          title: widget.centerMasterDatabase.centerStatus,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 2.0),
                        child: HeadingTitleText(
                          fontSize: FontSize.normal,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey,
                          title:
                              "${widget.centerMasterDatabase.areaName}, ${widget.centerMasterDatabase.cityName}"
                                  .toLowerCase()
                                  .toTitleCase,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 2.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            RichText(
                              text: TextSpan(
                                text:
                                    ' ${widget.centerMasterDatabase.centerRatelist} ',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.profileEnabled,
                                ),
                                children: const <TextSpan>[],
                              ),
                            )
                          ],
                        ),
                      )
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
