import 'dart:ui';
import 'package:eduarno/Utilities/constants.dart';
import 'package:eduarno/repo/bloc/profile/model/user_profile.dart';
import 'package:eduarno/repo/bloc/profile/personal_detail_data.dart';
import 'package:eduarno/repo/bloc/user.dart';
import 'package:eduarno/repo/utils/validator.dart';
import 'package:eduarno/widgets/bottom_sheet.dart';
import 'package:eduarno/widgets/country_code/country_code.dart';
import 'package:eduarno/widgets/custom_button.dart';
import 'package:eduarno/widgets/custom_text_field.dart';
import 'package:eduarno/widgets/select_city_sheet.dart';
import 'package:eduarno/widgets/select_state_sheet.dart';
import 'package:eduarno/widgets/shimmer_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersonalProfile extends StatefulWidget {
  const PersonalProfile({Key key}) : super(key: key);

  @override
  _PersonalProfileState createState() => _PersonalProfileState();
}

class _PersonalProfileState extends State<PersonalProfile> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _userEmailController = TextEditingController();
  final TextEditingController _userPhoneNumberController =
      TextEditingController();
  final TextEditingController _userWhatsappNumberController =
      TextEditingController();
  final TextEditingController _userLocationController = TextEditingController();
  final TextEditingController _phoneCountryCode = TextEditingController();
  final TextEditingController _whatsAppCountryCode = TextEditingController();
  final TextEditingController _userStateController = TextEditingController();
  final TextEditingController _userCityController = TextEditingController();
  final TextEditingController _userPinController = TextEditingController();
  final TextEditingController _userAccountNumberController =
      TextEditingController();
  final TextEditingController _userIFSCCodeController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool isWhatsAppNumber = false;
  String name = "";
  String email = "";
  bool isAPI = false;
  UserProfile userProfile;
  String _accountNumber = '';
  @override
  void initState() {
    super.initState();
    ProfileProvider().getState();
    ProfileProvider().getPersonalProfile(User().userId).then((value) {
      setState(() {
        isAPI = value;
        userProfile = ProfileProvider().userProfile;
        name = userProfile.userName;
        email = userProfile.userEmail;

        String phoneNumber = userProfile.userContact;
        String phoneCountryCode = userProfile.userContactCountryCode ?? '';
        String whatsAppNumber = userProfile.userContactWhatsapp;
        String whatsAppCountryCode = userProfile.userWhatsappCountryCode ?? '';

        bool isPhoneCountryCodeEmpty = phoneCountryCode.isEmpty ?? false;
        bool isWhatsAppCountryCodeEmpty = whatsAppCountryCode?.isEmpty ?? false;

        if (phoneNumber == whatsAppNumber) {
          isWhatsAppNumber = true;
        }

        _userNameController.text = userProfile.userName;
        _phoneCountryCode.text = isPhoneCountryCodeEmpty
            ? "+ 91"
            : userProfile.userContactCountryCode;
        _whatsAppCountryCode.text = isWhatsAppCountryCodeEmpty
            ? "+ 91"
            : userProfile.userWhatsappCountryCode;

        _userPhoneNumberController.text = phoneNumber;
        _userWhatsappNumberController.text = whatsAppNumber;
        _userAccountNumberController.text = userProfile.userAccount;
        _userIFSCCodeController.text = userProfile.userIfsc;
        _userStateController.text = userProfile.userState;
        _userCityController.text = userProfile.userCity;
        _userLocationController.text = userProfile.userLocation;
        _userPinController.text = userProfile.userPincode;
        _userEmailController.text = userProfile.userEmail;
        _userLocationController.text = userProfile.userLocation;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = context.watch<ProfileProvider>();
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      //bottomNavigationBar: MyBottomBar(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        backwardsCompatibility: true,
        brightness: Brightness.light,
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.white),
        elevation: 0,
        title: Text(
          "Edit personal info",
          style: TextStyle(
            fontSize: 24.0,
            // color: Colors.black,
            fontFamily: "Poppins",
            // fontStyle: FontStyle.normal,
            // fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: SvgPicture.asset(
            "assets/back.svg",
            color: Color(0xff686B6F),
          ),
          onPressed: () => {
            Navigator.pop(context),
          },
        ),
        actions: [
          // Theme(
          //   data: Theme.of(context).copyWith(
          //     cardColor: Colors.white,
          //   ),
          //   child: PopupMenuButton(
          //       iconSize: 22,
          //       itemBuilder: (context) => [
          //             PopupMenuItem(
          //               child: InkWell(
          //                   onTap: () {
          //                     // Navigator.push(
          //                     //     context,
          //                     //     MaterialPageRoute(
          //                     //         builder: (context) => PersonalInfo()));
          //                   },
          //                   child: Text("Edit")),
          //               value: 1,
          //             ),
          //             // PopupMenuItem(
          //             //   child: Text("Second"),
          //             //   value: 2,
          //             // )
          //           ]),
          // ),
        ],
      ),
      body: isAPI
          ? Form(
              key: _formKey,
              child: ListView(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 35),
                        child: Stack(
                          children: [
                            // CircleAvatar(
                            //   radius: 72.8,
                            //   backgroundImage:
                            //       AssetImage("assets/demo.png"),
                            // ),
                            Container(
                              height: 160,
                              width: 160,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: AssetImage("assets/demo.png")),
                              ),
                            ),

                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 115, left: 15),
                              child: SvgPicture.asset("assets/semi.svg"),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 120, left: 72),
                              child: InkWell(
                                onTap: () {},
                                child: SvgPicture.asset("assets/Camera.svg"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Text(
                          name,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff303030)),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          email,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff8C8C8C),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 19, left: 25),
                        child: Text(
                          "Basic details",
                          style: TextStyle(
                              color: Color(0xff303030),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Poppins"),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, right: 25, top: 0),
                    child: CustomTextField(
                      titleColor: kIconColor,
                      hintColor: Colors.black54,
                      textColor: Colors.black,
                      title: "",
                      hint: 'Full name',
                      label: 'Full name',
                      controller: _userNameController,
                      validator: (value) =>
                          Validators.validateName(value.trim(), 'Name'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, right: 25, top: 0),
                    child: CustomTextField(
                      titleColor: kIconColor,
                      hintColor: Colors.black54,
                      textColor: Colors.black,
                      title: "",
                      hint: 'Email',
                      label: 'Email',
                      controller: _userEmailController,
                      validator: (value) =>
                          Validators.validateEmail(value.trim()),
                    ),
                  ),
                  StatefulBuilder(builder:
                      (BuildContext context, StateSetter setCheckboxState) {
                    return Column(
                      children: [
                        Row(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    right: 10, left: 25, top: 20),
                                child: TextFormField(
                                  readOnly: true,
                                  keyboardType: TextInputType.number,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                  onTap: () => showModalBottomSheet(
                                      context: context,
                                      isDismissible: true,
                                      isScrollControlled: true,
                                      enableDrag: true,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        topLeft: Radius.circular(10),
                                      )),
                                      builder: (context) => Container(
                                            padding: EdgeInsets.only(
                                                bottom: MediaQuery.of(context)
                                                    .viewPadding
                                                    .bottom),
                                            child: PhoneCodePicker(
                                              onSelected: (countries) {
                                                _phoneCountryCode.text =
                                                    countries.dialCode;
                                              },
                                            ),
                                          )),
                                  validator: (value) {
                                    return Validators.validateRequired(
                                        value.trim(), '');
                                  },
                                  controller: _phoneCountryCode,
                                  decoration: InputDecoration(
                                    fillColor: Color(0xffF6F7FA),
                                    filled: true,
                                    border: InputBorder.none,
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(
                                            color: Color(0xffF6F7FA),
                                            width: 0)),
                                    errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(
                                            color: Colors.red, width: 0)),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                          color: Colors.green, width: 1),
                                    ),
                                    labelStyle: TextStyle(
                                        color: Color(0xff9D9FA0),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16),
                                    hintText: "+ 91",
                                    hintStyle: TextStyle(
                                        color: Colors.black,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 16),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  right: 25,
                                ),
                                child: CustomTextField(
                                  // maxLength: 10,
                                  inputFormatter: [
                                    LengthLimitingTextInputFormatter(10),
                                  ],
                                  maxLengthEnforced:
                                      MaxLengthEnforcement.enforced,
                                  titleColor: kIconColor,
                                  hintColor: Colors.black54,
                                  textColor: Colors.black,
                                  textInputType: TextInputType.number,
                                  title: "",
                                  hint: 'Phone',
                                  label: 'Phone',
                                  controller: _userPhoneNumberController,
                                  validator: (value) =>
                                      Validators.validateBusinessMobile(
                                          value.trim()),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 13, top: 0),
                                  child: Transform.scale(
                                    scale: 1.2,
                                    child: Checkbox(
                                      activeColor: AppColors.primaryColor,
                                      value: isWhatsAppNumber,
                                      onChanged: (bool isChecked) {
                                        setCheckboxState(() {
                                          isWhatsAppNumber = isChecked;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "This is my whatsapp number",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  fontFamily: "Poppins",
                                  fontStyle: FontStyle.normal),
                            )
                          ],
                        ),
                        isWhatsAppNumber
                            ? Container()
                            : Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          right: 10, left: 25, top: 20),
                                      child: TextFormField(
                                        readOnly: true,
                                        keyboardType: TextInputType.number,
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500),
                                        onTap: () => showModalBottomSheet(
                                            context: context,
                                            isDismissible: true,
                                            isScrollControlled: true,
                                            enableDrag: true,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(10),
                                              topLeft: Radius.circular(10),
                                            )),
                                            builder: (context) => Container(
                                                  padding: EdgeInsets.only(
                                                      bottom:
                                                          MediaQuery.of(context)
                                                              .viewPadding
                                                              .bottom),
                                                  child: PhoneCodePicker(
                                                    onSelected: (countries) {
                                                      _whatsAppCountryCode
                                                              .text =
                                                          countries.dialCode;
                                                    },
                                                  ),
                                                )),
                                        validator: (value) {
                                          return Validators.validateRequired(
                                              value.trim(), '');
                                        },
                                        controller: _whatsAppCountryCode,
                                        decoration: InputDecoration(
                                          fillColor: Color(0xffF6F7FA),
                                          filled: true,
                                          border: InputBorder.none,
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              borderSide: BorderSide(
                                                  color: Color(0xffF6F7FA),
                                                  width: 0)),
                                          errorBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              borderSide: BorderSide(
                                                  color: Colors.red, width: 0)),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            borderSide: BorderSide(
                                                color: Colors.green, width: 1),
                                          ),
                                          labelStyle: TextStyle(
                                              color: Color(0xff9D9FA0),
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16),
                                          hintText: "+ 91",
                                          hintStyle: TextStyle(
                                              color: Colors.black,
                                              fontStyle: FontStyle.normal,
                                              fontSize: 16),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        right: 25,
                                      ),
                                      child: CustomTextField(
                                        // maxLength: 10,
                                        inputFormatter: [
                                          LengthLimitingTextInputFormatter(10),
                                        ],
                                        maxLengthEnforced:
                                            MaxLengthEnforcement.enforced,
                                        titleColor: kIconColor,
                                        hintColor: Colors.black54,
                                        textColor: Colors.black,
                                        textInputType: TextInputType.number,
                                        title: "",
                                        hint: 'WhatsApp',
                                        label: 'WhatsApp',
                                        controller:
                                            _userWhatsappNumberController,
                                        validator: (value) =>
                                            Validators.validateBusinessMobile(
                                                value.trim()),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                      ],
                    );
                  }),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 25, top: 38),
                        child: Text(
                          "Geographical details",
                          style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.normal),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 24, right: 14),
                          child: Consumer<ProfileProvider>(
                              builder: (context, data, child) {
                            // _userStateController.text = data.selectedState;
                            // if (data.isStateSelected == "true")
                            // _userCityController.text = "";
                            return CustomTextField(
                              isReadOnly: true,
                              titleColor: kIconColor,
                              hintColor: Colors.black54,
                              textColor: Colors.black,
                              title: '',
                              hint: 'State',
                              label: 'State',
                              controller: _userStateController,
                              validator: (value) {
                                return Validators.validateRequired(
                                    value, 'Select State!');
                              },
                              onTap: () {
                                kShowOptions(
                                    context,
                                    SelectLocationStateBottomSheet(
                                      title: "Select state",
                                      options: data.locationStateList,
                                      onSelected: (value, id) {
                                        _userStateController.text = value;
                                        // _userCityController.clear();
                                        profileProvider.selectedCity = '';
                                        profileProvider.selectedState = value;
                                        profileProvider.selectedStateId = id;
                                        profileProvider.isStateSelected =
                                            'loading';
                                        profileProvider
                                            .getCityByStateId(id)
                                            .then((value) => {
                                                  if (value)
                                                    {
                                                      profileProvider
                                                              .isStateSelected =
                                                          'true'
                                                    }
                                                });
                                        Navigator.pop(context);
                                      },
                                    ));
                              },
                            );
                          }),
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 24),
                            child: Consumer<ProfileProvider>(
                                builder: (context, data, child) {
                              // _userCityController.text = data.selectedCity;
                              // if (data.isStateSelected == "true")
                              //   _userCityController.text = "";
                              return CustomTextField(
                                onTap: () {
                                  // data.isStateSelected == 'true'?
                                  kShowOptions(
                                      context,
                                      SelectCityBottomSheet(
                                        title: "City",
                                        options: data.cityList,
                                        onSelected: (value, id) {
                                          _userCityController.text = value;
                                          print('City value ======> $value');
                                          Provider.of<ProfileProvider>(context,
                                                  listen: false)
                                              .selectedCityId = id;
                                          Provider.of<ProfileProvider>(context,
                                                  listen: false)
                                              .selectedCity = value;
                                          // Provider.of<ProfileProvider>(context,
                                          //         listen: false)
                                          //     .selectedStateId = id;
                                          // Provider.of<ProfileProvider>(context,
                                          //         listen: false)
                                          //     .isStateSelected = 'loading';
                                          Navigator.pop(context);
                                        },
                                      ));
                                  // : print('');
                                },
                                titleColor: kIconColor,
                                hintColor: Colors.black54,
                                textColor: Colors.black,
                                label: 'City',
                                title: "",
                                hint: 'City',
                                controller: _userCityController,
                                validator: (value) =>
                                    Validators.validateRequired(
                                        value.trim(), 'Location'),
                              );
                            }),
                          )),
                      SizedBox(width: 14),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            right: 25,
                          ),
                          child: CustomTextField(
                            // maxLength: 6,
                            inputFormatter: [
                              LengthLimitingTextInputFormatter(6),
                            ],
                            maxLengthEnforced: MaxLengthEnforcement.enforced,
                            titleColor: kIconColor,
                            hintColor: Colors.black54,
                            textInputType: TextInputType.number,
                            textColor: Colors.black,
                            title: "",
                            hint: 'Pincode',
                            label: 'Pincode',
                            controller: _userPinController,
                            validator: (value) =>
                                Validators.validatePin(value.trim()),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 32, left: 25),
                    child: Text(
                      "Bank details",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Poppins"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 0, left: 25, right: 25),
                    child: CustomTextField(
                        // maxLength: 18,
                        inputFormatter: [
                          LengthLimitingTextInputFormatter(18),
                        ],
                        maxLengthEnforced: MaxLengthEnforcement.enforced,
                        titleColor: kIconColor,
                        hintColor: Colors.black54,
                        textColor: Colors.black,
                        title: "",
                        hint: 'Account number',
                        label: 'Account number',
                        textInputType: TextInputType.number,
                        controller: _userAccountNumberController,
                        validator: (value) {
                          if (value.trim().length == 0)
                            return 'Please enter valid account number';
                          if (value.trim().length <= 9) {
                            return 'Please enter valid account number';
                          }
                          if (value.trim().length > 18) {
                            return 'Please enter valid account number';
                          }
                           //  _accountNumber = value; 
                         // print("your ac>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"+_accountNumber.substring(8));
                          return Validators.validateRequired(
                              value, 'Account Number');
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, right: 25),
                    child: CustomTextField(
                      inputFormatter: [
                        LengthLimitingTextInputFormatter(11),
                      ],
                      capitalize: true,
                      maxLengthEnforced: MaxLengthEnforcement.enforced,
                      titleColor: kIconColor,
                      hintColor: Colors.black54,
                      textColor: Colors.black,
                      title: "",
                      hint: 'IFSC code',
                      label: 'IFSC code',
                      controller: _userIFSCCodeController,
                      validator: (value) =>
                          Validators.validateIfsc(value.trim(), 'IFSC Code'),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, right: 25),
                    child: Button(
                      bgColor: kPrimaryColor,
                      isLoading: _isLoading,
                      formKey: _formKey,
                      alignment: Alignment.center,
                      title: "Update",
                      textColor: Colors.white,
                      onTap: () {
                        if (_formKey.currentState.validate()) {
                          FocusScope.of(context).unfocus();
                          var phoneNumber =
                              _userPhoneNumberController.text.trim();
                          String phoneCountryCode =
                              _phoneCountryCode.text.trim();

                          if (isWhatsAppNumber) {
                            _userWhatsappNumberController.text = phoneNumber;
                            _whatsAppCountryCode.text = phoneCountryCode;
                          }
                          String userID = User().userId;
                          setState(() {
                            _isLoading = true;
                          });
                          ProfileProvider()
                              .setPersonalProfile(
                            id: userID,
                            name: _userNameController.text.trim(),
                            phone: _userPhoneNumberController.text.trim(),
                            phoneCountryCode: _phoneCountryCode.text.trim(),
                            whatsapp: _userWhatsappNumberController.text.trim(),
                            whatsAppCountryCode:
                                _whatsAppCountryCode.text.trim(),
                            accountNumber:
                                _userAccountNumberController.text.trim(),
                            ifscCode: _userIFSCCodeController.text.trim(),
                            state: _userStateController.text.trim(),
                            city: _userCityController.text.trim(),
                            pinCode: _userPinController.text.trim(),
                          
                          )
                              .then((value) async {
                            Navigator.pop(context);
                          _accountNumber = _userAccountNumberController.text.trim();
                          String _digitCode = _accountNumber.substring(_accountNumber.length-4);
                          SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
                          sharedPrefs.setString('digit_code', _digitCode);
                          String bank_code = sharedPrefs.getString('digit_code');

                       //   print("your last digits >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"+bank_code);    
                          });
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            )
          : MyShimmer(),
    );
  }
}

// FutureBuilder(
//           future: ProfileProvider().getPersonalProfile(User().userId),
//           builder: (context, snapshot) {
//             // if (snapshot.hasError) {
//             //   return Center(
//             //       child: Image.asset(
//             //     "assets/no_data_found.png",
//             //     filterQuality: FilterQuality.high,
//             //     fit: BoxFit.cover,
//             //   ));
//             // }
//             if (snapshot.connectionState == ConnectionState.done) {
//               if (Provider.of<ProfileProvider>(context).userProfile != null) {
//                 UserProfile userProfile =
//                     Provider.of<ProfileProvider>(context).userProfile;
//                 name = userProfile.userName;
//                 email = userProfile.userEmail;

//                 String phoneNumber = userProfile.userContact;
//                 String phoneCountryCode =
//                     userProfile.userContactCountryCode ?? '';
//                 String whatsAppNumber = userProfile.userContactWhatsapp;
//                 String whatsAppCountryCode =
//                     userProfile.userWhatsappCountryCode ?? '';

//                 bool isPhoneCountryCodeEmpty =
//                     phoneCountryCode.isEmpty ?? false;
//                 bool isWhatsAppCountryCodeEmpty =
//                     whatsAppCountryCode?.isEmpty ?? false;

//                 if (phoneNumber == whatsAppNumber) {
//                   isWhatsAppNumber = !isWhatsAppNumber;
//                 }

//                 _userNameController.text = userProfile.userName;
//                 _phoneCountryCode.text = isPhoneCountryCodeEmpty
//                     ? "+ 91"
//                     : userProfile.userContactCountryCode;
//                 _whatsAppCountryCode.text = isWhatsAppCountryCodeEmpty
//                     ? "+ 91"
//                     : userProfile.userWhatsappCountryCode;

//                 _userPhoneNumberController.text = phoneNumber;
//                 _userWhatsappNumberController.text = whatsAppNumber;
//                 _userAccountNumberController.text = userProfile.userAccount;
//                 _userIFSCCodeController.text = userProfile.userIfsc;
//                 _userStateController.text = userProfile.userState;
//                 _userCityController.text = userProfile.userCity;
//                 _userLocationController.text = userProfile.userLocation;
//                 _userPinController.text = userProfile.userPincode;
//                 _userEmailController.text = userProfile.userEmail;
//                 _userLocationController.text = userProfile.userLocation;
//               }
//               return;
//             }
//             return MyShimmer();
//           }),