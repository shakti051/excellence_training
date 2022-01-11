import 'dart:developer';
import 'dart:io';
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:vlcc/mixins/validation_mixin.dart';
import 'package:vlcc/providers/shared_pref.dart';
import 'package:vlcc/resources/apiHandler/api_call.dart';
import 'package:vlcc/resources/app_colors.dart';
import 'package:vlcc/resources/assets_path.dart';
import 'package:vlcc/resources/common_strings.dart';
import 'package:vlcc/resources/dimensions.dart';
import 'package:vlcc/screens/sign_up/predashboard.dart';
import 'package:vlcc/widgets/gender_selector.dart';
import 'package:vlcc/widgets/gradient_button.dart';
import 'package:vlcc/widgets/signup_widgets/profile_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

enum AppState {
  free,
  picked,
  cropped,
}

class _ProfileScreenState extends State<ProfileScreen> with ValidationMixin {
  final TextEditingController dateOfBirthTextController =
      TextEditingController();
  File? _image;
  final VlccShared _vlccSharedPrefs = VlccShared();
  DateTime dob = DateTime.now();
  final picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();
  late AppState state;

  Future<void> _pickImageGallery() async {
    final pickedImage =
        await ImagePicker().getImage(source: ImageSource.gallery);
    _image = pickedImage != null ? File(pickedImage.path) : null;
    if (_image != null) {
      setState(() {
        state = AppState.picked;
        _cropImage();
      });
    }
  }

  Future<Null> _pickImageCamera() async {
    final pickedImage =
        await ImagePicker().getImage(source: ImageSource.camera);
    _image = pickedImage != null ? File(pickedImage.path) : null;
    if (_image != null) {
      setState(() {
        state = AppState.picked;
        _cropImage();
      });
    }
  }

  Future<void> _openImagePicker() async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
        state = AppState.picked;
      });
    }
  }

  Future<Null> _cropImage() async {
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
      });
    }
  }

  void _clearImage() {
    _image = null;
    setState(() {
      state = AppState.free;
    });
  }

  void _showPicker(context) {
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
                      if (state == AppState.free)
                        _pickImageGallery();
                      else if (state == AppState.picked)
                        _cropImage();
                      else if (state == AppState.cropped) _clearImage();

                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: Icon(Icons.photo_camera),
                  title: Text('Camera'),
                  onTap: () {
                    if (state == AppState.free) {
                      _pickImageCamera();
                    } else if (state == AppState.picked) {
                      _cropImage();
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

  @override
  void initState() {
    state = AppState.free;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final profiles = context.watch<ProfileProvider>();
    final sharedPrefs = context.watch<VlccShared>();

    Future<void> uploadImage() async {
      var db =
          '${dob.year}-${dob.month.toString().padLeft(2, "0")}-${dob.day.toString().padLeft(2, "0")}';
      var imageFile =
          _image != null ? await MultipartFile.fromFile(_image!.path) : '';
      FormData formData = FormData.fromMap({
        'client_mobile': _vlccSharedPrefs.mobileNum,
        'device_id': _vlccSharedPrefs.deviceId,
        'auth_token': _vlccSharedPrefs.authToken,
        'client_gender': profiles.gender,
        'client_dob': db,
        'client_pic': imageFile,
      });
      Dio dio = Dio();
      var response = await dio.post(
          '${Services.baseUrl}/api/api_client_profile_update.php?request=client_profile_update',
          data: formData);

      log(response.toString(), name: 'Partial image upload');
    }

    Future<void> _selectedDate(BuildContext context) async {
      final profiles = context.read<ProfileProvider>();
      var today = DateTime.now();
      final DateTime? _selDate = await showDatePicker(
        context: context,
        initialDate: DateTime(today.year - 13),
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
        dateOfBirthTextController.text = _birthDate;
      }
    }

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppBar(
          backgroundColor: AppColors.backgroundColor,
          elevation: 0,
          automaticallyImplyLeading: false,
          leading: Opacity(
            opacity: 0,
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
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: PaddingSize.extraLarge),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 28),
                Stack(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(32),
                        child: SizedBox(
                          width: 112,
                          height: 112,
                          child: _image != null
                              ? Image.file(_image!, fit: BoxFit.cover)
                              : Image.asset(PNGAsset.avatar),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 95, bottom: 80),
                      alignment: Alignment.center,
                      child: Container(
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
                              _showPicker(context);
                            } else if (state == AppState.cropped) {
                              _clearImage();
                            }
                          },
                          child: _buildButtonIcon(),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 40),
                Text(
                  "Hey ${_vlccSharedPrefs.name}",
                  style: TextStyle(
                      letterSpacing: 1,
                      fontWeight: FontWeight.w700,
                      fontSize: FontSize.heading),
                ),
                SizedBox(height: 16),
                Text(
                  AppStrings.knowDateOfBirthForPersonalisedExperience,
                  style: TextStyle(
                      height: 1.5,
                      fontWeight: FontWeight.w400,
                      fontSize: FontSize.normal),
                ),
                SizedBox(height: 40),
                GenderSelector(),
                SizedBox(height: 42),
                Text(
                  "Birthday",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: FontSize.normal,
                  ),
                ),
                SizedBox(height: 8),
                InkWell(
                  onTap: () {
                    _selectedDate(context);
                  },
                  child: Container(
                    height: 46,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: AppColors.backBorder),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                            child: SvgPicture.asset(
                                "assets/images/invitation.svg",
                                color: AppColors.calanderColor)),
                        Expanded(
                          flex: 7,
                          child: Visibility(
                            visible: true,
                            child: Container(
                              height: 45,
                              padding: EdgeInsets.only(top: 15),
                              child: Text(
                                profiles.getShowDates
                                    ? DateFormat("dd/MM/yyyy")
                                        .format(profiles.getCurrentDate)
                                        .toString()
                                    : 'dd/mm/yyyy',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: profiles.getShowDates
                                        ? Colors.black87
                                        : Colors.grey,
                                    fontFamily: FontName.frutinger,
                                    fontWeight: FontWeight.w600,
                                    fontSize: FontSize.normal),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 24),
                Visibility(
                  visible: profiles.gender == '' ? false : true,
                  child: GradientButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text("Continue",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: FontSize.large,
                                color: Colors.white)),
                        SizedBox(width: 16),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    onPressed: () {
                      if (profiles.getShowDates && (profiles.gender != '')) {
                        uploadImage();
                        sharedPrefs.isSignupProfileComplete = true;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PreDashboard()));
                      } else {
                        Fluttertoast.showToast(
                            msg: "Enter DOB",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.redAccent,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }
                    },
                  ),
                ),
                SizedBox(height: 24)
              ],
            ),
          ),
        ),
      )),
    );
  }

  Widget _buildButtonIcon() {
    if (state == AppState.free) {
      return CircleAvatar(
        radius: 22,
        backgroundColor: Colors.white,
        child: SvgPicture.asset(SVGAsset.camera),
      );
    } else if (state == AppState.cropped) {
      return CircleAvatar(
          radius: 22,
          backgroundColor: Colors.white,
          child: Icon(Icons.clear, color: Colors.black87));
    } else {
      return Container();
    }
  }
}
