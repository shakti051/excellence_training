import 'dart:developer';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:provider/provider.dart';
import 'package:vlcc/database/db_helper.dart';
import 'package:vlcc/providers/explore_clinics_provider.dart';
import 'package:vlcc/resources/app_colors.dart';
import 'package:vlcc/resources/assets_path.dart';
import 'package:vlcc/resources/dimensions.dart';
import 'package:vlcc/resources/string_extensions.dart';
import 'package:vlcc/resources/util_functions.dart';

class ExploreClinics extends StatefulWidget {
  final LatLng? currentPostion;
  const ExploreClinics({Key? key, this.currentPostion}) : super(key: key);

  @override
  _ExploreClinicsState createState() => _ExploreClinicsState();
}

class _ExploreClinicsState extends State<ExploreClinics> {
  final _searchController = TextEditingController();
  Set<Marker> markers = {};
  BitmapDescriptor? mapMarker;
  final DatabaseHelper db = DatabaseHelper();
  GoogleMapController? _mapController;
  String? searchAddr;

  double resultLat = 28.5488181;
  double resultLong = 77.1185522;
  double radius = 5000;

  double getZoomlevel() {
    double zoomLevel = 0;
    double newRadius = radius + radius / 2;
    double scale = newRadius / 500;
    zoomLevel = 6 - math.log(scale) / math.log(2);
    return zoomLevel;
  }

  filterDistance() {
    setState(() {
      _mapController!.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
              target: searchAddr == null
                  ? widget.currentPostion!
                  : LatLng(resultLat, resultLong),
              zoom: getZoomlevel())));
    });
  }

  searchandNavigate() {
    setState(() {
      GeocodingPlatform.instance
          .locationFromAddress(searchAddr ?? '')
          .then((result) {
        log(result.toString(), name: 'map result');
        resultLat = result[0].latitude;
        resultLong = result[0].longitude;
        _mapController!.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(
                target: LatLng(result[0].latitude, result[0].longitude),
                zoom: 10.0)));
      });
    });
  }

  void onMapCreated(controller) {
    setState(() {
      _mapController = controller;
    });
  }

  void setCustomMarker() async {
    mapMarker = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(50, 70)), PNGAsset.markerIcon);
  }

  @override
  void initState() {
    setCustomMarker();
    super.initState();
  }

  void _onMapCreated(controller) {
    //log(db.centerMasterDbList.length.toString());
    setState(() {
      _mapController = controller;
      for (int i = 0; i < db.centerMasterDbList.length; i++) {
        if (db.centerMasterDbList[i].centerLatitude == "") {
          continue;
        } else if (db.centerMasterDbList[i].centerLongitude == "") {
          continue;
        } else {
          markers.add(Marker(
            markerId: MarkerId("id-$i"), //28.5488181,77.1185522
            position: LatLng(
                double.parse(db.centerMasterDbList[i].centerLatitude),
                double.parse(db.centerMasterDbList[i].centerLongitude)),
            infoWindow: InfoWindow(
                title: db.centerMasterDbList[i].addressLine1
                    .toLowerCase()
                    .toTitleCase,
                snippet:
                    db.centerMasterDbList[i].cityName.toLowerCase().toTitleCase,
                onTap: () {
                  double destinationLatitude =
                      double.parse(db.centerMasterDbList[i].centerLatitude);
                  double destinationLongitude =
                      double.parse(db.centerMasterDbList[i].centerLongitude);
                  UtilityFunctions.launchMapsUrl(
                    sourceLatitude:
                        widget.currentPostion?.latitude ?? destinationLatitude,
                    sourceLongitude: widget.currentPostion?.longitude ??
                        destinationLongitude,
                    destinationLatitude: destinationLatitude,
                    destinationLongitude: destinationLongitude,
                  );
                }),
            icon: mapMarker!,
          ));
        }
      }
      //28.5561671,77.0977691
    });
  }

  @override
  Widget build(BuildContext context) {
    final distance = context.watch<ExploreClinicsProvider>();

    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(90),
          child: AppBar(
            toolbarHeight: 80,
            backgroundColor: AppColors.backgroundColor,
            elevation: 0,
            //centerTitle: true,
            automaticallyImplyLeading: false,
            leading: Transform.scale(
              scale: 1.4,
              child: Container(
                margin: EdgeInsets.only(left: 24, top: 25, bottom: 20),
                width: 50,
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
            title: Container(
              margin: EdgeInsets.only(left: 16, top: 10, right: 16, bottom: 4),
              child: GooglePlaceAutoCompleteTextField(
                textEditingController: _searchController,
                textStyle: TextStyle(
                  fontFamily: "Muli",
                  color: Colors.black,
                  fontSize: 16,
                ),
                googleAPIKey: "AIzaSyCJ1HGjRHt15_gyI0fLho4T9hsF7TaOTZE",
                inputDecoration: InputDecoration(
                  hintText: 'Enter Address',
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(
                        top: 15, left: 5, right: 0, bottom: 15),
                    child: SizedBox(
                      height: 4,
                      child: SvgPicture.asset(SVGAsset.searchIcon),
                    ),
                  ),
                  suffixIcon: InkWell(
                    onTap: () {
                      _searchController.text = '';
                    },
                    child: Icon(Icons.clear_rounded, color: Colors.black54),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.aquaGreen),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
                debounceTime: 800,
                itmClick: (Prediction prediction) {
                  _searchController.text = prediction.description ?? '';
                  _searchController.selection = TextSelection.fromPosition(
                    TextPosition(
                      offset: prediction.description?.length ?? 0,
                    ),
                  );
                  searchAddr = _searchController.text;
                  FocusScopeNode currentFocus = FocusScope.of(context);

                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                  searchandNavigate();
                },
              ),
            ),
          ),
        ),
        body: Stack(
          children: [
            GoogleMap(
                onMapCreated: _onMapCreated,
                markers: markers,
                initialCameraPosition: CameraPosition(
                    target: widget.currentPostion == null
                        ? LatLng(
                            double.parse(
                                db.centerMasterDbList[0].centerLatitude),
                            double.parse(
                                db.centerMasterDbList[0].centerLongitude))
                        : widget.currentPostion!,
                    zoom: 11)),
            Positioned(
              top: 16,
              left: 16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      distance.selectFive();
                      setState(() {
                        radius = .5;
                        filterDistance();
                      });
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      margin: EdgeInsets.only(right: MarginSize.normal),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              width: 1,
                              color: distance.fiveKm
                                  ? Colors.redAccent
                                  : AppColors.backBorder),
                          borderRadius: BorderRadius.circular(40)),
                      child: Text("< 5km",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: FontSize.normal)),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      distance.selectThirty();
                      setState(() {
                        radius = 3;
                        filterDistance();
                      });
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      margin: EdgeInsets.only(right: MarginSize.normal),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              width: 1,
                              color: distance.thirtyKm
                                  ? Colors.redAccent
                                  : AppColors.backBorder),
                          borderRadius: BorderRadius.circular(40)),
                      child: Text("< 30km",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: FontSize.normal)),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      distance.selectFifty();
                      setState(() {
                        radius = 5;
                        filterDistance();
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: MarginSize.normal),
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              width: 1,
                              color: distance.fiftyKm
                                  ? Colors.redAccent
                                  : AppColors.backBorder),
                          borderRadius: BorderRadius.circular(40)),
                      child: Text("< 50km",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: FontSize.normal)),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      distance.selectHundred();
                      setState(() {
                        radius = 10;
                        filterDistance();
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: MarginSize.normal),
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              width: 1,
                              color: distance.hundredKm
                                  ? Colors.redAccent
                                  : AppColors.backBorder),
                          borderRadius: BorderRadius.circular(40)),
                      child: Text("< 50-100km",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: FontSize.normal)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
