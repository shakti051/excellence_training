// To parse this JSON data, do
//
//     final userProfile = userProfileFromJson(jsonString);

import 'dart:convert';

UserProfile userProfileFromJson(String str) =>
    UserProfile.fromJson(json.decode(str));

String userProfileToJson(UserProfile data) => json.encode(data.toJson());

class UserProfile {
  UserProfile({
    this.id,
    this.userId,
    this.userName,
    this.userEmail,
    this.userPassword,
    this.userRole,
    this.tutorId,
    this.createdAt,
    this.userOtp,
    this.userAccount,
    this.userCity,
    this.userContact,
    this.userContactWhatsapp,
    this.userIfsc,
    this.userLocation,
    this.userPincode,
    this.userState,
    this.isActive,
    this.userContactCountryCode,
    this.userWhatsappCountryCode,
  });

  String id;
  String userId;
  String userName;
  String userEmail;
  String userPassword;
  String userRole;
  String tutorId;
  int createdAt;
  String userOtp;
  String userAccount;
  String userCity;
  String userContact;
  String userContactWhatsapp;
  String userIfsc;
  String userLocation;
  String userPincode;
  String userState;
  bool isActive;
  String userContactCountryCode;
  String userWhatsappCountryCode;

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        id: json["_id"],
        userId: json["user_id"],
        userName: json["user_name"],
        userEmail: json["user_email"],
        userPassword: json["user_password"],
        userRole: json["user_role"],
        tutorId: json["tutor_id"],
        createdAt: json["created_at"],
        userOtp: json["user_otp"],
        userAccount: json["user_account"],
        userCity: json["user_city"],
        userContact: json["user_contact"],
        userContactWhatsapp: json["user_contact_whatsapp"],
        userIfsc: json["user_ifsc"],
        userLocation: json["user_location"],
        userPincode: json["user_pincode"],
        userState: json["user_state"],
        isActive: json["is_active"],
        userContactCountryCode: json["user_contact_country_code"],
        userWhatsappCountryCode: json["user_whatsapp_country_code"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user_id": userId,
        "user_name": userName,
        "user_email": userEmail,
        "user_password": userPassword,
        "user_role": userRole,
        "tutor_id": tutorId,
        "created_at": createdAt,
        "user_otp": userOtp,
        "user_account": userAccount,
        "user_city": userCity,
        "user_contact": userContact,
        "user_contact_whatsapp": userContactWhatsapp,
        "user_ifsc": userIfsc,
        "user_location": userLocation,
        "user_pincode": userPincode,
        "user_state": userState,
        "is_active": isActive,
        "user_contact_country_code": userContactCountryCode,
        "user_whatsapp_country_code": userWhatsappCountryCode,
      };
}
