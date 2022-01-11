import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:vlcc/database/db_helper.dart';
import 'package:vlcc/providers/shared_pref.dart';
import 'package:vlcc/resources/app_colors.dart';
import 'package:vlcc/resources/assets_path.dart';
import 'package:vlcc/resources/common_strings.dart';
import 'package:vlcc/resources/dimensions.dart';
import 'package:vlcc/screens/packages/packages.dart';
import 'package:vlcc/screens/search/explore_clinics.dart';
import 'package:vlcc/screens/search/packages.dart';
import 'package:vlcc/screens/search/search_location_sheet.dart';
import 'package:vlcc/screens/search/search_speciality.dart';
import 'package:vlcc/widgets/custom_loader.dart';
import 'package:vlcc/widgets/custom_text_field.dart';
import 'package:vlcc/widgets/nodata.dart';
import 'package:vlcc/widgets/search_widgets/search_widgets.dart';

class SearchPage extends StatefulWidget {
  final String pageTitle;
  final bool isBook;
  final bool isBack;
  final bool isComingFromBookNow;

  const SearchPage({
    Key? key,
    this.pageTitle = 'Search',
    this.isBook = false,
    this.isBack = false,
    required this.isComingFromBookNow,
  }) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchEditingController =
      TextEditingController();
  Placemark? place;
  LatLng? currentPostion;
  late Position position;
  String location = 'Press Button';
  String address = 'search';
  late LocationPermission permission;
  final VlccShared _vlccShared = VlccShared();
  @override
  void initState() {
    _getUserLocation();
    super.initState();
    place = Placemark(
        locality: _vlccShared.localityString,
        subLocality: _vlccShared.subLocalityString);
  }

  @override
  Widget build(BuildContext context) {
    final databaseHelper = context.read<DatabaseHelper>();
    final packageProviderList = context.watch<PackageProvider>();

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: Container(
          margin: EdgeInsets.only(top: 8),
          child: AppBar(
            backgroundColor: AppColors.backgroundColor,
            elevation: 0,
            centerTitle: false,
            automaticallyImplyLeading: false,
            title: Visibility(
              visible: widget.isBack,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  'VLCC',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: AppColors.logoOrange,
                    fontWeight: FontWeight.w700,
                    fontSize: FontSize.heading,
                    fontFamily: FontName.frutinger,
                  ),
                ),
              ),
            ),
            leading: Visibility(
              visible: widget.isBack,
              child: Transform.scale(
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
            ),
            actions: [
              SizedBox(width: 8),
              Visibility(
                visible: !widget.isBack,
                child: GestureDetector(
                  child: SearchLocation(
                    sublocality: place?.subLocality ?? '',
                    locality: place?.locality ?? '',
                  ),
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        builder: (context) {
                          return SearchLocationSheet(
                            callback: (newPlace) {
                              setState(() {
                                place = Placemark(
                                  locality: newPlace.state,
                                  subLocality: newPlace.city,
                                );
                                _vlccShared.locality(withValue: newPlace.state);
                                _vlccShared.subLocality(
                                    withValue: newPlace.state);
                                currentPostion = LatLng(
                                  newPlace.latitude,
                                  newPlace.longitude,
                                );
                              });
                            },
                          );
                        });
                  },
                ),
              ),
              Visibility(
                visible: !widget.isBack,
                child: Spacer(),
              ),
              Visibility(
                visible: !widget.isBook,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ExploreClinics(currentPostion: currentPostion)),
                    );
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: MarginSize.small),
                          child: SvgPicture.asset("assets/images/map.svg")),
                      Container(
                        margin: const EdgeInsets.only(right: 24),
                        child: Text(
                          "Explore VLCC Centres",
                          style: TextStyle(
                              color: AppColors.calanderColor,
                              fontFamily: 'Mulish',
                              fontWeight: FontWeight.w700,
                              fontSize: FontSize.normal),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: PaddingSize.extraLarge),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(
                visible: widget.isBack,
                child: SizedBox(
                  height: 24,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.pageTitle,
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: FontSize.heading),
                  ),
                ],
              ),
              CustomTextField(
                fillColor: AppColors.greyBackground,
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                    SVGAsset.searchIcon,
                    color: Colors.grey,
                  ),
                ),
                isPrefixIcon: true,
                isReadOnly: true,
                customField: CustomField.clickable,
                textEditingController: _searchEditingController,
                textFormatter: [LengthLimitingTextInputFormatter(50)],
                hintText: 'Search service, location and centres',
                ontap: () {
                  databaseHelper.centerMasterDbFilterList1 =
                      databaseHelper.centerMasterDbList;
                  databaseHelper.serviceFilterList =
                      databaseHelper.serviceMasterDbList;
                  databaseHelper.uniqueServiceListFilter =
                      databaseHelper.uniqueServiceList;
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.bottomToTop,
                      child: SearchSpeciality(),
                    ),
                  );
                },
              ),
              if (widget.isComingFromBookNow) ...[
                SizedBox(height: 16),
                Text(
                    "Subscribed packages(${packageProviderList.activePackages.length})",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: FontSize.extraLarge)),
                SizedBox(height: 20),
                Visibility(
                  visible: packageProviderList.activePackages.isNotEmpty,
                  child: Column(
                      children: List.generate(
                    packageProviderList.activePackages.length,
                    (index) => PackageCards(
                      color: packageProviderList.packageCardColor,
                      tags: GestureDetector(
                          child: GetTag(
                        variableTag: VariableTag.none,
                      )),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Packages(
                                    packageDetail: packageProviderList
                                        .activePackages[index],
                                  )),
                        );
                      },
                      packageDetail: packageProviderList.activePackages[index],
                    ),
                  )),
                ),
                Visibility(
                  visible: packageProviderList.activePackages.isEmpty,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: NoDataScreen(
                      noDataSelect: NoDataSelectType.empty,
                    ),
                  ),
                ),
              ],
              PopularSpeciality(),
              SizedBox(height: 20),
              Text("Centres",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: FontSize.extraLarge)),
              SizedBox(height: 20),
              databaseHelper.centerMasterDbList.isNotEmpty
                  ? PopularClinics(
                      centerMasterDatabaseList:
                          databaseHelper.centerMasterDbList,
                      currentLatitude: currentPostion?.latitude ?? 0,
                      currentLongitude: currentPostion?.longitude ?? 0,
                    )
                  : CustomLoader(
                      customLoaderType: CustomLoaderType.quoted,
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getAddressFromLatLong(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    place = placemarks[0];
    address =
        '${place?.street}, ${place?.subLocality}, ${place?.locality}, ${place?.postalCode}, ${place!.country}';
    _vlccShared.locality(withValue: place?.locality ?? '');
    _vlccShared.subLocality(withValue: place?.subLocality ?? '');

    setState(() {
      currentPostion = LatLng(position.latitude, position.longitude);
    });
  }

  void _getUserLocation() async {
    await _determinePosition();

    position = await GeolocatorPlatform.instance.getCurrentPosition(
        locationSettings: LocationSettings(accuracy: LocationAccuracy.best));
    if (mounted) {
      setState(() {
        currentPostion = LatLng(position.latitude, position.longitude);
        getAddressFromLatLong(position);
      });
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }
}
