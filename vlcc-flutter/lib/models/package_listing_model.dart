// To parse this JSON data, do
//
//     final packageListing = packageListingFromJson(jsonString);

import 'dart:convert';

PackageListingModel packageListingFromJson(String str) =>
    PackageListingModel.fromJson(json.decode(str));

String packageListingToJson(PackageListingModel data) =>
    json.encode(data.toJson());

class PackageListingModel {
  PackageListingModel({
    this.status,
    this.message,
    this.packageDetails,
  });

  int? status;
  String? message;
  List<PackageDetail>? packageDetails;

  factory PackageListingModel.fromJson(Map<String, dynamic> json) =>
      PackageListingModel(
        status: json["Status"],
        message: json["Message"],
        packageDetails: List<PackageDetail>.from(
            json["PackageDetails"].map((x) => PackageDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "PackageDetails":
            List<dynamic>.from(packageDetails!.map((x) => x.toJson())),
      };
}

class PackageDetail {
  PackageDetail({
    this.bookingId = '',
    this.centerName = '',
    this.centerCode = '',
    this.clientId = '',
    this.bookingNumber = '',
    this.bookingDate,
    this.bookingExpiryDate,
    this.bookingQty = '',
    this.bookingAmount = '',
    this.bookingDiscountAmount = '',
    this.bookingAmountAfterDiscount = '',
    this.bookingTaxAmount = '',
    this.bookingTotalAmount = '',
    this.bookingTotalPaidIncTaxAmount = '',
    this.bookingTotalPaidExcTaxAmount = '',
    this.bookingTotalBalExcTaxAmount = '',
    this.bookingUnexecutedAmount = '',
    this.bookingExecutedAmount = '',
    this.packageItemDtl,
    this.renewStatus = 'Yes',
  });

  String bookingId;
  String centerName;
  String centerCode;
  String clientId;
  String bookingNumber;
  DateTime? bookingDate;
  DateTime? bookingExpiryDate;
  String bookingQty;
  String bookingAmount;
  String bookingDiscountAmount;
  String bookingAmountAfterDiscount;
  String bookingTaxAmount;
  String bookingTotalAmount;
  String bookingTotalPaidIncTaxAmount;
  String bookingTotalPaidExcTaxAmount;
  String bookingTotalBalExcTaxAmount;
  String bookingUnexecutedAmount;
  String bookingExecutedAmount;
  String renewStatus;
  List<PackageItemDtl>? packageItemDtl;

  factory PackageDetail.fromJson(Map<String, dynamic> json) => PackageDetail(
        bookingId: json["BookingId"],
        centerName: json["CenterName"],
        centerCode: json["CenterCode"],
        clientId: json["ClientId"],
        bookingNumber: json["BookingNumber"],
        bookingDate: DateTime.parse(json["BookingDate"]),
        bookingExpiryDate: DateTime.parse(json["BookingExpiryDate"]),
        bookingQty: json["BookingQty"],
        bookingAmount: json["BookingAmount"],
        bookingDiscountAmount: json["BookingDiscountAmount"],
        bookingAmountAfterDiscount: json["BookingAmountAfterDiscount"],
        bookingTaxAmount: json["BookingTaxAmount"],
        bookingTotalAmount: json["BookingTotalAmount"],
        bookingTotalPaidIncTaxAmount: json["BookingTotalPaidIncTaxAmount"],
        bookingTotalPaidExcTaxAmount: json["BookingTotalPaidExcTaxAmount"],
        bookingTotalBalExcTaxAmount: json["BookingTotalBalExcTaxAmount"],
        bookingUnexecutedAmount: json["BookingUnexecutedAmount"],
        bookingExecutedAmount: json["BookingExecutedAmount"],
        renewStatus: json["RenewStatus"].toString().toLowerCase(),
        packageItemDtl: List<PackageItemDtl>.from(
            json["PackageItemDtl"].map((x) => PackageItemDtl.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "BookingId": bookingId,
        "CenterName": centerName,
        "CenterCode": centerCode,
        "ClientId": clientId,
        "BookingNumber": bookingNumber,
        "BookingDate":
            "${bookingDate!.year.toString().padLeft(4, '0')}-${bookingDate!.month.toString().padLeft(2, '0')}-${bookingDate!.day.toString().padLeft(2, '0')}",
        "BookingExpiryDate": bookingExpiryDate,
        "BookingQty": bookingQty,
        "BookingAmount": bookingAmount,
        "BookingDiscountAmount": bookingDiscountAmount,
        "BookingAmountAfterDiscount": bookingAmountAfterDiscount,
        "BookingTaxAmount": bookingTaxAmount,
        "BookingTotalAmount": bookingTotalAmount,
        "BookingTotalPaidIncTaxAmount": bookingTotalPaidIncTaxAmount,
        "BookingTotalPaidExcTaxAmount": bookingTotalPaidExcTaxAmount,
        "BookingTotalBalExcTaxAmount": bookingTotalBalExcTaxAmount,
        "BookingUnexecutedAmount": bookingUnexecutedAmount,
        "BookingExecutedAmount": bookingExecutedAmount,
        "RenewStatus": renewStatus,
        "PackageItemDtl":
            List<dynamic>.from(packageItemDtl!.map((x) => x.toJson())),
      };
}

class PackageItemDtl {
  PackageItemDtl({
    this.bookingItemId = '',
    this.serviceName = '',
    this.serviceCode = '',
    this.serviceQty = '',
    this.serviceFinalAmt = '',
    this.servicePaidQty = '',
    this.serviceLeftQty = 0,
  });

  String bookingItemId;
  String serviceName;
  String serviceCode;
  String serviceQty;
  String serviceFinalAmt;
  String servicePaidQty;
  int serviceLeftQty;

  factory PackageItemDtl.fromJson(Map<String, dynamic> json) => PackageItemDtl(
        bookingItemId: json["booking_item_id"],
        serviceName: json["ServiceName"],
        serviceCode: json["ServiceCode"],
        serviceQty: json["ServiceQty"],
        serviceFinalAmt: json["ServiceFinalAmt"],
        servicePaidQty: json["ServicePaidQty"],
        serviceLeftQty: json["ServiceLeftQty"],
      );

  Map<String, dynamic> toJson() => {
        "booking_item_id": bookingItemId,
        "ServiceName": serviceName,
        "ServiceCode": serviceCode,
        "ServiceQty": serviceQty,
        "ServiceFinalAmt": serviceFinalAmt,
        "ServicePaidQty": servicePaidQty,
        "ServiceLeftQty": serviceLeftQty,
      };
}
