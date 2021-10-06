// import 'package:eduarno/repo/bloc/profile/model/user_profile.dart';
// import 'package:eduarno/repo/bloc/profile/personal_detail_data.dart';
// import 'package:eduarno/repo/bloc/user.dart';
// import 'package:eduarno/repo/utils/validator.dart';
// import 'package:eduarno/screens/profile/edit_personal_profile.dart';
// import 'package:eduarno/widgets/bottom_app_bar.dart';
// import 'package:eduarno/widgets/bottom_sheet.dart';
// import 'package:eduarno/widgets/custom_button.dart';
// import 'package:eduarno/widgets/custom_text_field.dart';
// import 'package:eduarno/widgets/select_state_sheet.dart';
// import 'package:eduarno/widgets/shimmer_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:provider/provider.dart';

// import '../../constants.dart';

// class PersonalInfo extends StatefulWidget {
//   const PersonalInfo({Key key}) : super(key: key);

//   @override
//   _PersonalInfoState createState() => _PersonalInfoState();
// }

// class _PersonalInfoState extends State<PersonalInfo> {
//   String name;
//   String email;
//   final TextEditingController _userNameController = TextEditingController();
//   final TextEditingController _userCountryCode = TextEditingController();

//   final TextEditingController _userEmailController = TextEditingController();
//   final TextEditingController _userPhoneNumberController =
//       TextEditingController();
//   final TextEditingController _userWhatsappNumberController =
//       TextEditingController();
//   final TextEditingController _userLocationController = TextEditingController();
//   final TextEditingController _userStateController = TextEditingController();
//   final TextEditingController _userCityController = TextEditingController();
//   final TextEditingController _userPinController = TextEditingController();
//   final TextEditingController _userAccountNumberController =
//       TextEditingController();
//   final TextEditingController _userIFSCCodeController = TextEditingController();
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   bool _isLoading = false;
//   bool value = false;

//   @override
//   void initState() {
//     ProfileProvider().getState();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         // resizeToAvoidBottomInset: false,
//         backgroundColor: Colors.white,
//         //bottomNavigationBar: MyBottomBar(),
//         appBar: AppBar(
//           backgroundColor: Colors.white,
//           backwardsCompatibility: true,
//           brightness: Brightness.light,
//           systemOverlayStyle:
//               SystemUiOverlayStyle(statusBarColor: Colors.white),
//           elevation: 0,
//           title: Text(
//             "Personal Information",
//             overflow: TextOverflow.visible,
//             style: TextStyle(
//               fontSize: 22.0,
//               color: Colors.black,
//               fontFamily: "Poppins",
//               fontWeight: FontWeight.w600,
//               fontStyle: FontStyle.normal,
//               // fontWeight: FontWeight.w600 ),
//             ),
//           ),
//           centerTitle: false,
//           leading: IconButton(
//             icon: SvgPicture.asset(
//               "assets/back.svg",
//               color: Color(0xff686B6F),
//             ),
//             onPressed: () => {
//               Navigator.pop(context),
//             },
//           ),
//           actions: [
//             Theme(
//               data: Theme.of(context).copyWith(
//                 cardColor: Colors.white,
//               ),
//               child: PopupMenuButton(
//                   iconSize: 22,
//                   itemBuilder: (context) => [
//                         PopupMenuItem(
//                           child: InkWell(
//                               onTap: () {
//                                 Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) =>
//                                             PersonalProfile()));
//                               },
//                               child: Text("Edit")),
//                           value: 1,
//                         ),
//                       ]),
//             ),
//           ],
//         ),
//         body: FutureBuilder(
//             future: ProfileProvider().getPersonalProfile(User().userId),
//             builder: (context, snapshot) {
//               if (snapshot.hasError) {
//                 return Center(child: Text('No data'));
//               }
//               if (snapshot.connectionState == ConnectionState.done) {
//                 if (Provider.of<ProfileProvider>(context).userProfile != null) {
//                   UserProfile userProfile =
//                       Provider.of<ProfileProvider>(context).userProfile;
//                   _userNameController.text = userProfile.userName;
//                   name = userProfile.userName;
//                   _userPhoneNumberController.text = userProfile.userContact;
//                   _userWhatsappNumberController.text =
//                       userProfile.userContactWhatsapp;
//                   _userAccountNumberController.text = userProfile.userAccount;
//                   _userIFSCCodeController.text = userProfile.userIfsc;
//                   _userStateController.text = userProfile.userState;
//                   _userCityController.text = userProfile.userCity;
//                   _userLocationController.text = userProfile.userLocation;
//                   _userPinController.text = userProfile.userPincode;
//                   _userEmailController.text = userProfile.userEmail;
//                   email = userProfile.userEmail;
//                   // _userLocationController.text = userProfile.;
//                 }
//                 return Form(
//                   key: _formKey,
//                   child: ListView(
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.only(top: 35),
//                             child: Stack(
//                               children: [
//                                 CircleAvatar(
//                                   radius: 72.8,
//                                   backgroundImage:
//                                       AssetImage("assets/demo.png"),
//                                 ),
//                                 Padding(
//                                   padding:
//                                       const EdgeInsets.only(top: 108, left: 8),
//                                   child: SvgPicture.asset("assets/semi.svg"),
//                                 ),
//                                 Padding(
//                                   padding:
//                                       const EdgeInsets.only(top: 115, left: 61),
//                                   child: InkWell(
//                                       onTap: () {},
//                                       child: SvgPicture.asset(
//                                           "assets/Camera.svg")),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.only(top: 16),
//                             child: Text(
//                               name,
//                               style: TextStyle(
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.w600,
//                                   color: Color(0xff303030)),
//                             ),
//                           ),
//                         ],
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.only(top: 4),
//                             child: Text(
//                               email,
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w400,
//                                 color: Color(0xff8C8C8C),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       Row(
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.only(top: 19, left: 25),
//                             child: Text(
//                               "Basic details",
//                               style: TextStyle(
//                                   color: Color(0xff303030),
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w500,
//                                   fontFamily: "Poppins"),
//                             ),
//                           )
//                         ],
//                       ),
//                       Padding(
//                         padding:
//                             const EdgeInsets.only(left: 25, right: 25, top: 0),
//                         child: CustomTextField(
//                           titleColor: kIconColor,
//                           hintColor: Colors.black54,
//                           textColor: Colors.black,
//                           label: "Full name",
//                           title: "",
//                           hint: 'Full name',
//                           controller: _userNameController,
//                           validator: (value) =>
//                               Validators.validateName(value.trim(), 'Name'),
//                         ),
//                       ),
//                       Padding(
//                         padding:
//                             const EdgeInsets.only(left: 25, right: 25, top: 0),
//                         child: CustomTextField(
//                           // isEnabled: false,
//                           titleColor: kIconColor,
//                           hintColor: Colors.black54,
//                           textColor: Colors.black,
//                           title: "",
//                           hint: 'Email',
//                           label: 'Email',
//                           controller: _userEmailController,
//                           validator: (value) =>
//                               Validators.validateEmail(value.trim()),
//                         ),
//                       ),
//                       Row(
//                         children: <Widget>[
//                           Expanded(
//                             child: Padding(
//                               padding: const EdgeInsets.only(
//                                   right: 10, left: 25, top: 0),
//                               child: CustomTextField(
//                                 // isEnabled: false,
//                                 titleColor: kIconColor,
//                                 hintColor: Colors.black54,
//                                 textColor: Colors.black,
//                                 textInputType: TextInputType.number,
//                                 title: "",

//                                 hint: '+91 ',
//                                 controller: _userCountryCode,
//                                 validator: (value) =>
//                                     Validators.validateBusinessMobile(
//                                         value.trim()),
//                               ),
//                             ),
//                           ),
//                           // SizedBox(
//                           //   width: 10.0,
//                           // ),
//                           Expanded(
//                             flex: 3,
//                             child: Padding(
//                               padding: const EdgeInsets.only(right: 25),
//                               child: CustomTextField(
//                                 titleColor: kIconColor,
//                                 hintColor: Colors.black54,
//                                 textColor: Colors.black,
//                                 textInputType: TextInputType.number,
//                                 title: "",
//                                 hint: 'Phone',
//                                 controller: _userWhatsappNumberController,
//                                 validator: (value) =>
//                                     Validators.validateBusinessMobile(
//                                         value.trim()),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       // Row(
//                       //   children: [
//                       //     Expanded(
//                       //       flex: 2,
//                       //       child: CustomTextField(
//                       //         titleColor: kIconColor,
//                       //         hintColor: Colors.black54,
//                       //         textColor: Colors.black,
//                       //         title: "",
//                       //         hint: 'Delhi',
//                       //         controller: _userLocationController,
//                       //         validator: (value) => Validators.validateRequired(
//                       //             value.trim(), 'Location'),
//                       //       ),
//                       //     ),
//                       //     SizedBox(width: 10),
//                       //     Expanded(
//                       //       child: CustomTextField(
//                       //         titleColor: kIconColor,
//                       //         hintColor: Colors.black54,
//                       //         textInputType: TextInputType.number,
//                       //         textColor: Colors.black,
//                       //         title: "",
//                       //         hint: '243434',
//                       //         controller: _userPinController,
//                       //         validator: (value) =>
//                       //             Validators.validatePin(value.trim()),
//                       //       ),
//                       //     ),
//                       //   ],
//                       // ),
//                       Row(
//                         // mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Stack(
//                             children: [
//                               Padding(
//                                 padding:
//                                     const EdgeInsets.only(left: 13, top: 0),
//                                 child: Transform.scale(
//                                   scale: 1,
//                                   child: Checkbox(
//                                     activeColor: Colors.green,
//                                     value: this.value,
//                                     onChanged: (bool value) {
//                                       setState(() {
//                                         this.value = value;
//                                       });
//                                     },
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Text(
//                             "This is my whatsapp number.",
//                             style: TextStyle(
//                                 fontWeight: FontWeight.w400,
//                                 fontSize: 14,
//                                 fontFamily: "Poppins",
//                                 fontStyle: FontStyle.normal),
//                           )
//                         ],
//                       ),
//                       Row(
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.only(left: 25, top: 38),
//                             child: Text(
//                               "Geographical details",
//                               style: TextStyle(
//                                   fontFamily: "Poppins",
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w500,
//                                   fontStyle: FontStyle.normal),
//                             ),
//                           )
//                         ],
//                       ),
//                       Row(
//                         children: [
//                           Expanded(
//                             flex: 1,
//                             child: Padding(
//                               padding: const EdgeInsets.only(left: 25),
//                               child: CustomTextField(
//                                 // isEnabled: false,
//                                 titleColor: kIconColor,
//                                 hintColor: Colors.black54,
//                                 textInputType: TextInputType.number,
//                                 textColor: Colors.black,
//                                 title: "",
//                                 hint: 'Pincode',
//                                 controller: _userPinController,
//                                 validator: (value) =>
//                                     Validators.validatePin(value.trim()),
//                               ),
//                             ),
//                           ),
//                           SizedBox(width: 14),
//                           Expanded(
//                             flex: 2,
//                             child: Padding(
//                               padding:
//                                   const EdgeInsets.only(left: 5, right: 25),
//                               child: CustomTextField(
//                                 // isEnabled: false,
//                                 titleColor: kIconColor,
//                                 hintColor: Colors.black54,
//                                 textColor: Colors.black,
//                                 title: "",
//                                 hint: 'City',
//                                 controller: _userLocationController,
//                                 validator: (value) =>
//                                     Validators.validateRequired(
//                                         value.trim(), 'Location'),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       Row(
//                         children: <Widget>[
//                           Expanded(
//                             child: Consumer<ProfileProvider>(
//                                 builder: (context, data, child) {
//                               _userStateController.text = data.selectedState;
//                               if (data.isStateSelected == "true")
//                                 _userCityController.text = "";
//                               return Padding(
//                                 padding:
//                                     const EdgeInsets.only(left: 25, right: 18),
//                                 child: CustomTextField(
//                                   // isEnabled: false,
//                                   isReadOnly: true,
//                                   titleColor: kIconColor,
//                                   hintColor: Colors.black54,
//                                   textColor: Colors.black,
//                                   title: '',
//                                   hint: 'State',
//                                   controller: _userStateController,
//                                   validator: (value) {
//                                     return Validators.validateRequired(
//                                         value, 'Select State!');
//                                   },
//                                   onTap: () {
//                                     kShowOptions(
//                                         context,
//                                         SelectLocationStateBottomSheet(
//                                           title: "",
//                                           options: data.locationStateList,
//                                           onSelected: (value, id) {
//                                             // _userStateController.text = value;
//                                             // _userCityController.clear();
//                                             Provider.of<ProfileProvider>(
//                                                     context,
//                                                     listen: false)
//                                                 .selectedCity = '';
//                                             Provider.of<ProfileProvider>(
//                                                     context,
//                                                     listen: false)
//                                                 .selectedState = value;
//                                             Provider.of<ProfileProvider>(
//                                                     context,
//                                                     listen: false)
//                                                 .selectedStateId = id;
//                                             Provider.of<ProfileProvider>(
//                                                     context,
//                                                     listen: false)
//                                                 .isStateSelected = 'loading';
//                                             ProfileProvider()
//                                                 .getCityByStateId(id)
//                                                 .then((value) => {
//                                                       if (value)
//                                                         {
//                                                           Provider.of<ProfileProvider>(
//                                                                   context,
//                                                                   listen: false)
//                                                               .isStateSelected = 'true'
//                                                         }
//                                                     });
//                                             Navigator.pop(context);
//                                           },
//                                         ));
//                                   },
//                                 ),
//                               );
//                             }),
//                           ),
//                           SizedBox(
//                             width: 10.0,
//                           ),
//                           // Expanded(
//                           //   child: Consumer<ProfileProvider>(
//                           //       builder: (context, data, child) {
//                           //     _userCityController.text = data.selectedCity;
//                           //     return
//                           //         // data.isStateSelected == 'true' ?
//                           //         CustomTextField(
//                           //       isReadOnly: true,
//                           //       titleColor: kIconColor,
//                           //       hintColor: Colors.black54,
//                           //       textColor: Colors.black,
//                           //       title: '',
//                           //       hint: 'Bijnor',
//                           //       controller: _userCityController,
//                           //       validator: (value) {
//                           //         return Validators.validateRequired(
//                           //             value, 'Select City!');
//                           //       },
//                           //       onTap: () {
//                           //         // data.isStateSelected == 'true'?
//                           //         kShowOptions(
//                           //             context,
//                           //             SelectCityBottomSheet(
//                           //               title: "State",
//                           //               options: data.cityList,
//                           //               onSelected: (value, id) {
//                           //                 _userCityController.text = value;
//                           //                 print('City value ======> $value');
//                           //                 Provider.of<ProfileProvider>(context,
//                           //                         listen: false)
//                           //                     .selectedCityId = id;
//                           //                 Provider.of<ProfileProvider>(context,
//                           //                         listen: false)
//                           //                     .selectedCity = value;
//                           //                 // Provider.of<ProfileProvider>(context,
//                           //                 //         listen: false)
//                           //                 //     .selectedStateId = id;
//                           //                 // Provider.of<ProfileProvider>(context,
//                           //                 //         listen: false)
//                           //                 //     .isStateSelected = 'loading';
//                           //                 Navigator.pop(context);
//                           //               },
//                           //             ));
//                           //         // : print('');
//                           //       },
//                           //     );
//                           //     // : SizedBox();
//                           //   }),
//                           // ),
//                         ],
//                       ),
//                       // SizedBox(
//                       //   height: 16,
//                       // ),
//                       Padding(
//                         padding: const EdgeInsets.only(top: 32, left: 25),
//                         child: Text(
//                           "Bank details",
//                           style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w500,
//                               fontFamily: "Poppins"),
//                         ),
//                       ),
//                       // SizedBox(
//                       //   height: 16,
//                       // ),
//                       Padding(
//                         padding:
//                             const EdgeInsets.only(top: 0, left: 25, right: 25),
//                         child: CustomTextField(
//                             // isEnabled: false,
//                             titleColor: kIconColor,
//                             hintColor: Colors.black54,
//                             textColor: Colors.black,
//                             title: "",
//                             hint: 'Account number',
//                             textInputType: TextInputType.number,
//                             controller: _userAccountNumberController,
//                             validator: (value) {
//                               if (value.trim().length == 0)
//                                 return 'Please enter valid account number';
//                               if (value.trim().length <= 7) {
//                                 return 'Please enter valid account number';
//                               }
//                               if (value.trim().length >= 19) {
//                                 return 'Please enter valid account number';
//                               }
//                               print(value);
//                               return Validators.validateRequired(
//                                   value, 'Account Number');
//                             }),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(left: 25, right: 25),
//                         child: CustomTextField(
//                           // isEnabled: false,
//                           titleColor: kIconColor,
//                           hintColor: Colors.black54,
//                           textColor: Colors.black,
//                           title: "",
//                           hint: 'IFSC code',
//                           controller: _userIFSCCodeController,
//                           validator: (value) => Validators.validateRequired(
//                               value.trim(), 'IFSC Code'),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       // false
//                       //     ? SizedBox()
//                       //     : Padding(
//                       //         padding:
//                       //             const EdgeInsets.only(left: 25, right: 25),
//                       //         child: Button(
//                       //           bgColor: kPrimaryColor,
//                       //           isLoading: _isLoading,
//                       //           formKey: _formKey,
//                       //           alignment: Alignment.center,
//                       //           title: "Save",
//                       //           textColor: Colors.white,
//                       //           onTap: () {
//                       //             if (_formKey.currentState.validate()) {
//                       //               FocusScope.of(context).unfocus();
//                       //               setState(() {
//                       //                 _isLoading = true;
//                       //               });
//                       //               ProfileProvider()
//                       //                   .setPersonalProfile(
//                       //                 User().userId,
//                       //                 _userNameController.text.trim(),
//                       //                 _userPhoneNumberController.text.trim(),
//                       //                 _userWhatsappNumberController.text.trim(),
//                       //                 _userAccountNumberController.text.trim(),
//                       //                 _userIFSCCodeController.text.trim(),
//                       //                 _userStateController.text.trim(),
//                       //                 _userCityController.text.trim(),
//                       //                 _userLocationController.text.trim(),
//                       //                 _userPinController.text.trim(),
//                       //               )
//                       //                   .then((value) {
//                       //                 setState(() {
//                       //                   _isLoading = false;
//                       //                 });
//                       //               });
//                       //             }
//                       //           },
//                       //         ),
//                       //       ),
//                       SizedBox(
//                         height: 20,
//                       )
//                     ],
//                   ),
//                 );
//               }
//               return MyShimmer();
//             }));
//   }
// }
