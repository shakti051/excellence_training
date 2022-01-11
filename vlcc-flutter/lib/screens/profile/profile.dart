import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:badges/badges.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:vlcc/mixins/text_field_validator.dart';
import 'package:vlcc/models/profile_model.dart';
import 'package:vlcc/providers/shared_pref.dart';
import 'package:vlcc/resources/apiHandler/api_call.dart';
import 'package:vlcc/resources/app_colors.dart';
import 'package:vlcc/resources/assets_path.dart';
import 'package:vlcc/resources/dimensions.dart';
import 'package:vlcc/screens/profile/profile_booking.dart';
import 'package:vlcc/widgets/custom_input_cards.dart';
import 'package:vlcc/widgets/custom_shimmers.dart';
import 'package:vlcc/widgets/custom_text_field.dart';
import 'package:vlcc/widgets/dashboard_widgets/dashboard_provider.dart';
import 'package:vlcc/widgets/date_time_widgets/date_selector.dart';
import 'package:vlcc/widgets/gender_selector.dart';
import 'package:vlcc/widgets/heading_title_text.dart';
import 'package:vlcc/widgets/phone_code_picker/phone_code.dart';
import 'package:vlcc/widgets/signup_widgets/profile_provider.dart';
import 'package:dio/dio.dart' as dio;

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

enum AppState {
  free,
  picked,
  cropped,
}

class _ProfileState extends State<Profile> {
  final DateFormat _dateFormatter = DateFormat('MMM dd, yyyy');
  File? _image;
  final picker = ImagePicker();
  final Services _services = Services();
  String name = '';
  String gender = '';
  bool apiHit = false;
  DateTime dob = DateTime.now();
  String emailId = '';
  String city = '';
  String phoneNumber = '';
  int? age;
  late AppState state;
  ProfileProvider profileProvider = ProfileProvider();
  VlccShared sharedPrefs = VlccShared();
  ProfileModel profileModel = ProfileModel(
      clientProfileDetails:
          ClientProfileDetails(clientDateofBirth: DateTime.now()));

  Future<void> getProfileDetails() async {
    var body = {
      'auth_token': sharedPrefs.authToken,
      'client_mobile': sharedPrefs.mobileNum,
      'device_id': sharedPrefs.deviceId,
    };
    _services
        .callApi(body, '/api/api_client_profile.php?request=client_profile',
            apiName: 'Profile details')
        .then((value) {
      setState(() {
        apiHit = true;
        profileProvider.isUpdateChanged = false;
        var testVal = value;
        var jsonTest = json.decode(value);
        if (jsonTest['Status'] == 2000) {
          profileModel = profileModelFromJson(testVal);
          name = profileModel.clientProfileDetails.clientName
                  .split('')[0]
                  .toUpperCase() +
              profileModel.clientProfileDetails.clientName
                  .split('')
                  .sublist(1)
                  .join('');
          gender = profileModel.clientProfileDetails.clientGender;
          dob = profileModel.clientProfileDetails.clientDateofBirth;
          emailId = profileModel.clientProfileDetails.clientEmailid;
          profileProvider.profileImage =
              profileModel.clientProfileDetails.clientProfilePic;
          city = profileModel.clientProfileDetails.clientCity;
          phoneNumber = profileModel.clientProfileDetails.clientMobileNo;
          _birthdayController.text = _dateFormatter
              .format(profileModel.clientProfileDetails.clientDateofBirth);
          // "${profileModel.clientProfileDetails.clientDateofBirth.month.toString().padLeft(2, "0")}${profileModel.clientProfileDetails.clientDateofBirth.day.toString().padLeft(2, "0")}/${profileModel.clientProfileDetails.clientDateofBirth.year}";
          //.format(profileModel.clientProfileDetails.clientDateofBirth);
          _genderController.text = gender;
          _phoneController.text = phoneNumber;
          _emailController.text = emailId;
          _cityController.text = city;
          genderSelector(gender);
          age = calculateAge(dob);
        }
      });
    });
  }

  calculateAge(DateTime dob) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - dob.year;
    int month1 = currentDate.month;
    int month2 = dob.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = dob.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age;
  }

  void genderSelector(String gender) {
    switch (gender.toLowerCase()) {
      case 'male':
        return profileProvider.selectMale();
      case 'female':
        return profileProvider.selectFemale();
      case 'common':
        return profileProvider.selectCommon();
      default:
    }
  }

  // Future<int> updateCompleteProfile() async {
  //   // DateTime selectedDate = profileProvider.getCurrentDate;
  //   var db = '${dob.year}-${dob.month}-${dob.day}';
  //   var body = {
  //     'client_mobile': _phoneController.text.trim(),
  //     'device_id': '00000000-89ABCDEF-01234567-89ABCDEF',
  //     'auth_token':
  //         'b0597dd284f69c982b1b7294db8e510bf8ade7063d95a76563eea20377bde3fb',
  //     'client_gender': _genderController.text.trim(),
  //     'client_dob': db,
  //     'client_pic': await MultipartFile.fromFile(_image!.path,
  //         filename: 'shikharTestimage'),
  //     'client_title': profileModel.clientProfileDetails.clientTitle,
  //     'client_name': profileModel.clientProfileDetails.clientName,
  //     'client_email': _emailController.text.trim(),
  //     'client_address': profileModel.clientProfileDetails.clientAddress,
  //     'client_city': _cityController.text.trim(),
  //     'client_state': profileModel.clientProfileDetails.clientState,
  //     'client_pin': profileModel.clientProfileDetails.clientPin,
  //     'client_pan': profileModel.clientProfileDetails.clientPan,
  //     'client_marital_status':
  //         profileModel.clientProfileDetails.clientMaritalStatus,
  //   };
  //   int value = 400;
  //   _services
  //       .callApi(body,
  //           '/api/api_client_complete_profile_update.php?request=client_complete_profile_update',
  //           apiName: 'Update profile details')
  //       .then((value) {
  //     value = value['Status'];
  //   });
  //   return value;
  // }

  // void updateImageProfile() {
  //   // DateTime selectedDate = profileProvider.getCurrentDate;
  //   var db = '${dob.year}-${dob.month}-${dob.day}';
  //   var body = {
  //     'client_mobile': _phoneController.text.trim(),
  //     'device_id': '00000000-89ABCDEF-01234567-89ABCDEF',
  //     'auth_token':
  //         'b0597dd284f69c982b1b7294db8e510bf8ade7063d95a76563eea20377bde3fb',
  //     'client_gender': _genderController.text.trim(),
  //     'client_dob': db,
  //     'client_pic':
  //         'http://lms.vlccwellness.com/client_profile_pic/9172_20211009082149_dandia_poster.png',
  //   };
  //   _services
  //       .callApi(body,
  //           '/api/api_client_profile_update.php?request=client_profile_update',
  //           apiName: 'Update profile image')
  //       .then((value) {
  //     // profiles.profileImage = value['client_pic'];
  //   });
  // }

  Future<void> _openImagePicker(ProfileProvider profileProvider) async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
        profileProvider.isUpdateChanged = true;
        // updateImageProfile(profileProvider);
      });
    }
  }

  Future<void> _pickImageGallery(
      {required ProfileProvider profileProvider}) async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    _image = pickedImage != null ? File(pickedImage.path) : null;
    if (_image != null) {
      setState(() {
        state = AppState.picked;
        _cropImage(profileProvider: profileProvider);
      });
    }
  }

  Future<void> _pickImageCamera(
      {required ProfileProvider profileProvider}) async {
    final pickedImage = await picker.pickImage(source: ImageSource.camera);
    _image = pickedImage != null ? File(pickedImage.path) : null;
    if (_image != null) {
      setState(() {
        state = AppState.picked;
        _cropImage(profileProvider: profileProvider);
      });
    }
  }

  Future<void> _cropImage({required ProfileProvider profileProvider}) async {
    File? croppedFile = await ImageCropper.cropImage(
      sourcePath: _image!.path,
      aspectRatioPresets: Platform.isAndroid
          ? [
              CropAspectRatioPreset.square,
            ]
          : [
              CropAspectRatioPreset.square,
            ],
      androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Crop',
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
    );
    if (croppedFile != null) {
      _image = croppedFile;
      setState(() {
        state = AppState.cropped;
        profileProvider.isUpdateChanged = true;
      });
    }
  }

  void _clearImage() {
    _image = null;
    setState(() {
      state = AppState.free;
    });
  }

  void _showPicker(context, {required ProfileProvider profileProvider}) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: Icon(Icons.photo_library),
                    title: Text('Photo Library'),
                    onTap: () {
                      if (state == AppState.free) {
                        _pickImageGallery(profileProvider: profileProvider);
                      } else if (state == AppState.picked) {
                        _cropImage(profileProvider: profileProvider);
                      } else if (state == AppState.cropped) {
                        _clearImage();
                      }

                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: Icon(Icons.photo_camera),
                  title: Text('Camera'),
                  onTap: () {
                    if (state == AppState.free) {
                      _pickImageCamera(profileProvider: profileProvider);
                    } else if (state == AppState.picked) {
                      _cropImage(profileProvider: profileProvider);
                    } else if (state == AppState.cropped) {
                      _clearImage();
                    }

                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }

  final TextEditingController _birthdayController = TextEditingController();
  final TextEditingController _anniversaryController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    state = AppState.free;
    super.initState();
    getProfileDetails().then((value) {
      setState(() {
        apiHit = true;
      });
    });
    log(sharedPrefs.authToken, name: 'Auth token');
    log(sharedPrefs.deviceId, name: 'device id');
  }

  Future<void> uploadCompleteProfile() async {
    var db = '${dob.year}-${dob.month}-${dob.day}';
    FormData formData = FormData.fromMap({
      'client_mobile': sharedPrefs.mobileNum,
      'device_id': sharedPrefs.deviceId,
      'auth_token': sharedPrefs.authToken,
      'client_gender': _genderController.text.trim(),
      'client_dob': db,
      'client_title': profileModel.clientProfileDetails.clientTitle,
      'client_name': profileModel.clientProfileDetails.clientName,
      'client_email': _emailController.text.trim(),
      'client_address': profileModel.clientProfileDetails.clientAddress,
      'client_city': _cityController.text.trim(),
      'client_state': profileModel.clientProfileDetails.clientState,
      'client_pin': profileModel.clientProfileDetails.clientPin,
      'client_pan': profileModel.clientProfileDetails.clientPan,
      'client_marital_status':
          profileModel.clientProfileDetails.clientMaritalStatus,
    });
    Dio dio = Dio();
    var response = await dio.post(
        '${Services.baseUrl}/api/api_client_complete_profile_update.php?request=client_complete_profile_update',
        data: formData);
    log(response.toString(), name: 'Profile details upload');
  }

  Future<void> uploadImage() async {
    FormData formData = FormData.fromMap({
      'client_mobile': _phoneController.text.trim(),
      'device_id': sharedPrefs.deviceId,
      'auth_token': sharedPrefs.authToken,
      'client_pic': await MultipartFile.fromFile(_image!.path),
    });
    Dio dio = Dio();
    var response = await dio.post(
        '${Services.baseUrl}/api/api_client_profile_picture_update.php?request=client_profile_picture_update',
        data: formData);
    log(response.toString(), name: 'Partial image upload');
  }

  Future<void> updateProfile() async {
    if (_formKey.currentState!.validate()) {
      uploadCompleteProfile().then((value) {
        if (_image != null) {
          uploadImage();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = context.watch<ProfileProvider>();
    final dashBoardProvider = context.read<DashboardProvider>();
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 8),
        child: Visibility(
          visible: profileProvider.isUpdateChanged,
          child: ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                updateProfile().then((value) {
                  final snackBar = SnackBar(
                    content: Text('Your profile has been updated!'),
                    backgroundColor: AppColors.orange,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  // profileProvider.isUpdateChanged = false;
                  apiHit = false;
                  Future.delayed(Duration(seconds: 1), () {
                    getProfileDetails().then((value) {
                      // setState(() {
                      dashBoardProvider.getProfileDetails();
                      profileProvider.isUpdateChanged = false;
                      _clearImage();
                      // });
                    });
                  });
                });
              }
            },
            child: Text(
              'Update',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            centerTitle: false,
            automaticallyImplyLeading: true,
            floating: true,
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
            backgroundColor: AppColors.backgroundColor,
            title: HeadingTitleText(
                title: 'My Profile', fontSize: FontSize.heading),
          ),
          apiHit
              ? body(context)
              : SliverToBoxAdapter(
                  child: CustomShimmer(
                  shimmers: ShimmerType.profile,
                ))
        ],
      ),
    );
  }

  Widget body(BuildContext context) {
    final profiles = context.watch<ProfileProvider>();
    return SliverToBoxAdapter(
      child: Column(
        children: [
          profileImageSelector(profiles),
          SizedBox(height: PaddingSize.extraLarge),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ClinicProfileBooking()),
              );
            },
            child: HeadingTitleText(
              title: name,
              fontSize: FontSize.extraLarge,
            ),
          ),
          HeadingTitleText(
            fontSize: FontSize.small,
            title: '$gender, $age years',
            fontWeight: FontWeight.w400,
          ),
          Form(
            key: _formKey,
            child: FieldCards(cardTitle: 'Basic information', columnWidgets: [
              CustomTextField(
                ontap: () {
                  _selectedDate(context);
                },
                customField: CustomField.clickable,
                textEditingController: _birthdayController,
                isPrefixIcon: true,
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset("assets/images/invitation.svg",
                      color: AppColors.calanderColor),
                ),
                textFormatter: const [],
                labelText: 'Birthday',
                hintText: 'Birthday',
              ),
              CustomTextField(
                ontap: () {
                  _selectedDate(context);
                },
                customField: CustomField.clickable,
                textEditingController: _anniversaryController,
                isPrefixIcon: true,
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset("assets/images/invitation.svg",
                      color: AppColors.calanderColor),
                ),
                textFormatter: const [],
                labelText: 'Anniversary',
                hintText: 'Anniversary',
              ),
              CustomTextField(
                ontap: () {
                  genderSelect(profiles, () {
                    profiles.isUpdateChanged = true;
                    _genderController.text = profiles.gender;
                    Navigator.pop(context);
                  });
                },
                customField: CustomField.clickable,
                textEditingController: _genderController,
                textFormatter: const [],
                labelText: 'Gender',
                hintText: 'Male',
              ),
            ]),
          ),
          FieldCards(
            cardTitle: 'Contact information',
            columnWidgets: [
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin:
                      EdgeInsets.only(left: 4, top: 10, right: 0, bottom: 0),
                  child: Text(
                    'City',
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 0, top: 10, right: 0, bottom: 4),
                child: GooglePlaceAutoCompleteTextField(
                  textEditingController: _cityController,
                  textStyle: TextStyle(
                    fontFamily: "Muli",
                    color: Colors.black,
                    fontSize: 16,
                  ),
                  googleAPIKey: "AIzaSyCJ1HGjRHt15_gyI0fLho4T9hsF7TaOTZE",
                  inputDecoration: InputDecoration(
                    hintText: 'New Delhi',
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.location_on_outlined,
                        color: AppColors.orange,
                      ),
                    ),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: const Icon(
                        CupertinoIcons.pencil_ellipsis_rectangle,
                        color: AppColors.profileEnabled,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.aquaGreen),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                  itmClick: (Prediction prediction) {
                    // if (prediction.types?.contains('locality') ?? false) {
                    //   int index = prediction.types?.indexOf('locality') ?? 0;
                    //   _cityController.text =
                    //       prediction.terms?[index].value ?? '';
                    // } else {}
                    // String sublocality = pred
                    _cityController.text = prediction.terms?.first.value ?? '';
                    // _cityController.selection = TextSelection.fromPosition(
                    //   TextPosition(
                    //     offset: prediction.description?.length ?? 0,
                    //   ),
                    // );
                    profiles.isUpdateChanged = true;
                    FocusScopeNode currentFocus = FocusScope.of(context);
                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }
                  },
                ),
              ),
              CustomTextField(
                ontap: () {
                  profiles.isUpdateChanged = true;
                },
                customField: CustomField.input,
                textEditingController: _emailController,
                textFormatter: [
                  LengthLimitingTextInputFormatter(150),
                ],
                validator: (value) => Validators.validateEmail(value!),
                labelText: 'Email',
                hintText: 'johndoe@gmail.com',
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      ontap: () {},
                      customField: CustomField.clickable,
                      textEditingController: _phoneController,
                      textFormatter: [
                        LengthLimitingTextInputFormatter(10),
                      ],
                      labelText: 'Phone',
                      hintText: '9717393656',
                      // validator: (value) =>
                      //     Validators.validateBusinessMobile(value!),
                      // keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget profileImageSelector(ProfileProvider profileProvider) {
    return Padding(
      padding: const EdgeInsets.only(top: PaddingSize.extraLarge),
      child: Badge(
        badgeColor: Colors.white,
        badgeContent: Container(
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.1),
                  blurRadius: 15,
                  offset: Offset(0, 2)),
            ],
          ),
          child: GestureDetector(
            onTap: () {
              if (state == AppState.free) {
                _showPicker(context, profileProvider: profileProvider);
              } else if (state == AppState.cropped) {
                _clearImage();
              }
              // _openImagePicker(profileProvider);
            },
            // child: SvgPicture.asset(SVGAsset.camera),
            child: _buildButtonIcon(),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(32),
          child: SizedBox(
              width: 112,
              height: 112,
              child: (profileProvider.profileImage != '' && _image == null)
                  ? Image.network(
                      profileProvider.profileImage,
                      fit: BoxFit.cover,
                      errorBuilder: (context, stack, trace) {
                        return Image.asset(
                          PNGAsset.avatar,
                          fit: BoxFit.cover,
                        );
                      },
                    )
                  : _image != null
                      ? Image.file(
                          _image!,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          PNGAsset.avatar,
                          fit: BoxFit.cover,
                        )),
        ),
      ),
    );
  }

  Future<void> _selectedDate(BuildContext context) async {
    final profiles = context.read<ProfileProvider>();
    var today = DateTime.now();
    final DateTime? _selDate = await showDatePicker(
      context: context,
      initialDate: dob,
      firstDate: DateTime(today.year - 100),
      lastDate: DateTime(today.year - 13),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.orange,
              onPrimary: Colors.white,
              surface: Colors.orange,
            ),
            dialogBackgroundColor: AppColors.backgroundColor,
          ),
          child: child ?? SizedBox(),
        );
      },
    );

    if (_selDate != null) {
      profiles.updateDate(_selDate);
      dob = _selDate;
      profiles.isUpdateChanged = true;
      var _birthDate =
          "${_selDate.day.toString().padLeft(2, "0")}/${_selDate.month.toString().padLeft(2, "0")}/${_selDate.year}";
      _birthdayController.text = _dateFormatter.format(dob);
    }
  }

  Future<void> dateSelectDialogue() {
    return showDialog(
        barrierColor: Colors.transparent,
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text('Date of Birth'),
            content: SizedBox(
              height: 400,
              child: DateSelector(),
            ),
          );
        });
  }

  Future<void> genderSelect(
      ProfileProvider profileProvider, VoidCallback onSelect) {
    return showDialog(
        barrierColor: Colors.transparent,
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text('Gender'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GenderSelector(),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(onPressed: onSelect, child: Text('Ok')),
              ],
            ),
          );
        });
  }

  Widget _buildButtonIcon() {
    if (state == AppState.free) {
      return SvgPicture.asset(SVGAsset.camera);
    } else if (state == AppState.cropped) {
      return Icon(Icons.clear, color: Colors.black87);
    } else {
      return Container();
    }
  }
}
