import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:badges/badges.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/src/provider.dart';
import 'package:vlcc/mixins/text_field_validator.dart';
import 'package:vlcc/models/expert_profile_model.dart';
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
import 'package:vlcc/widgets/signup_widgets/profile_provider.dart';

class ExpertProfile extends StatefulWidget {
  const ExpertProfile({Key? key}) : super(key: key);

  @override
  _ExpertProfileState createState() => _ExpertProfileState();
}

enum AppState {
  free,
  picked,
  cropped,
}

class _ExpertProfileState extends State<ExpertProfile> {
  File? _image;
  final picker = ImagePicker();
  final Services _services = Services();
  String name = '';
  String gender = '';
  bool apiHit = false;
  DateTime dob = DateTime.now();
  String emailId = '';
  String city = '';
  String centerName = '';
  String empCode = '';
  String empId = '';
  String centerCode = '';
  String phoneNumber = '';
  int? age;
  late AppState state;
  VlccShared sharedPrefs = VlccShared();
  ExertProfileModel? _exertProfileModel;

  final DateFormat _dateFormatter = DateFormat('MMM dd, yyyy');
  
  void expertProfileAPI() {
    var body = {
      'auth_token': VlccShared().authToken,
      'staff_mobile' : VlccShared().mobileNum,
      'device_id': Provider.of<VlccShared>(context, listen: false).deviceId,
    
    };
    _services
        .callApi(body, '/api/api_staff_list.php?request=staff_list',apiName: 'Get Expert Profile')
        .then((value) {
      _exertProfileModel = exertProfileModelFromJson(value);
      if(_exertProfileModel!.status == 2000){
            gender = _exertProfileModel!.staffDetails!.staffGender!;
            name = _exertProfileModel!.staffDetails!.staffname!;
            dob = _exertProfileModel!.staffDetails!.staffDateofBirth!;
            age = calculateAge(dob);
            empCode = _exertProfileModel!.staffDetails!.staffcode!; 
            centerName = _exertProfileModel!.staffDetails!.centerName!;
            centerCode = _exertProfileModel!.staffDetails!.centerCode!;
            empId = _exertProfileModel!.staffDetails!.staffInfoId!;
            empCode = _exertProfileModel!.staffDetails!.staffcode!;
            phoneNumber = _exertProfileModel!.staffDetails!.staffMobileNo!;  
            setState(() {
              Provider.of<VlccShared>(context, listen: false).setEmployeeCode(empCode);
              apiHit = true;
            });
      }      
    
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
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    state = AppState.free;
    expertProfileAPI();
    super.initState();
  }


  

  @override
  Widget build(BuildContext context) {
    final profileProvider = context.watch<ProfileProvider>();
    final dashBoardProvider = context.read<DashboardProvider>();
    return Scaffold(
            body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            centerTitle: false,
            automaticallyImplyLeading: false,
            floating: true,
            backgroundColor: AppColors.backgroundColor,
            title: HeadingTitleText(
                title: 'My Profile', fontSize: FontSize.heading),
          ),
         apiHit ? body(context):
           SliverToBoxAdapter(
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
          SizedBox(
            height: PaddingSize.extraLarge,
          ),
          GestureDetector(
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => ClinicProfileBooking()),
              // );
            },
            child: HeadingTitleText(
              title: name, 
              fontSize: FontSize.extraLarge,
            ),
          ),
          HeadingTitleText(
            fontSize: FontSize.small,
            title: '$gender ,$age years', //needs dyanamic
            fontWeight: FontWeight.w400,
          ),
          Form(
            key: _formKey,
            child: FieldCards(cardTitle: 'Basic information', columnWidgets: [
              CustomTextField(
                ontap: () {},
                customField: CustomField.clickable,
                textEditingController: _genderController,
                textFormatter: const [],
                labelText: 'Center Name',
                hintText: centerName
              ),
              CustomTextField(
                ontap: () {
                  // _selectedDate(context);
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
                hintText: _dateFormatter.format(dob),
              ),              
              CustomTextField(
                ontap: () {},
                customField: CustomField.clickable,
                textEditingController: _genderController,
                textFormatter: const [],
                labelText: 'Gender',
                hintText: gender
              ),
              CustomTextField(
                ontap: () {},
                customField: CustomField.clickable,
                textEditingController: _genderController,
                textFormatter: const [],
                labelText: 'Center Code',
                hintText: centerCode
              ),
              CustomTextField(
                ontap: () {},
                customField: CustomField.clickable,
                textEditingController: _genderController,
                textFormatter: const [],
                labelText: 'Staff Code',
                hintText: empCode
              ),
              CustomTextField(
                ontap: () {},
                customField: CustomField.clickable,
                textEditingController: _genderController,
                textFormatter: const [],
                labelText: 'Staff Id',
                hintText: empId
              ),
            ]),
          ),
          FieldCards(
            cardTitle: 'Contact information',
            columnWidgets: [
              CustomTextField(
                ontap: () {},
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
                      hintText: phoneNumber,
                    ),
                  ),
                ],
              ),
              CustomTextField(
                customField: CustomField.input,
                textEditingController: _cityController,
                textFormatter: [
                  LengthLimitingTextInputFormatter(50),
                ],
                labelText: 'City',
                hintText: 'New Delhi',
                isSuffixIcon: true,
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const Icon(
                    CupertinoIcons.pencil_ellipsis_rectangle,
                    color: AppColors.profileEnabled,
                  ),
                ),
                isPrefixIcon: true,
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.location_on_outlined,
                    color: AppColors.orange,
                  ),
                ),
                ontap: () {},
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
