// To parse this JSON data, do
//
//     final packageInvoiceListing = packageInvoiceListingFromJson(jsonString);

import 'dart:convert';

PackageInvoiceListing packageInvoiceListingFromJson(String str) =>
    PackageInvoiceListing.fromJson(json.decode(str));

String packageInvoiceListingToJson(PackageInvoiceListing data) =>
    json.encode(data.toJson());

class PackageInvoiceListing {
  PackageInvoiceListing({
    this.status = 200,
    this.message = '',
    this.invoiceDetails,
  });

  int status;
  String message;
  List<InvoiceDetail>? invoiceDetails;

  factory PackageInvoiceListing.fromJson(Map<String, dynamic> json) =>
      PackageInvoiceListing(
        status: json["Status"],
        message: json["Message"],
        invoiceDetails: List<InvoiceDetail>.from(
            json["InvoiceDetails"].map((x) => InvoiceDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "InvoiceDetails":
            List<dynamic>.from(invoiceDetails!.map((x) => x.toJson())),
      };
}

class InvoiceDetail {
  InvoiceDetail({
    this.invoiceId = '',
    this.centerName = '',
    this.centerCode = '',
    this.clientId = '',
    this.clientName = '',
    this.invoiceNumber = '',
    this.invoiceDate,
    this.invoiceCashbackDiscount = '',
    this.invoiceLoyaltyDiscount = '',
    this.invoiceVoucherDiscount = '',
    this.invoiceFpCardNumber = '',
    this.invoiceFpcDiscount = '',
    this.invoiceTotalDiscount = '',
    this.invoiceTotalAmountAfterDiscount = '',
    this.invoiceTotalPaidIncTaxAmount = '',
    this.invoicePackageBooingId = '',
    this.invoicePackageBooingNumber = '',
    this.invoiceUrl = '',
    this.invoicePModeDtl,
  });

  String invoiceId;
  String centerName;
  String centerCode;
  String clientId;
  String clientName;
  String invoiceNumber;
  DateTime? invoiceDate;
  String invoiceCashbackDiscount;
  String invoiceLoyaltyDiscount;
  String invoiceVoucherDiscount;
  String invoiceFpCardNumber;
  String invoiceFpcDiscount;
  String invoiceTotalDiscount;
  String invoiceTotalAmountAfterDiscount;
  String invoiceTotalPaidIncTaxAmount;
  String invoicePackageBooingId;
  String invoicePackageBooingNumber;
  String invoiceUrl;
  List<InvoicePModeDtl>? invoicePModeDtl;

  factory InvoiceDetail.fromJson(Map<String, dynamic> json) => InvoiceDetail(
        invoiceId: json["InvoiceId"] ?? '',
        centerName: json["CenterName"] ?? '',
        centerCode: json["CenterCode"] ?? '',
        clientId: json["ClientId"] ?? '',
        clientName: json["ClientName"] ?? '',
        invoiceNumber: json["InvoiceNumber"] ?? '',
        invoiceDate: DateTime.parse(json["InvoiceDate"]),
        invoiceCashbackDiscount: json["InvoiceCashbackDiscount"] ?? '',
        invoiceLoyaltyDiscount: json["InvoiceLoyaltyDiscount"] ?? '',
        invoiceVoucherDiscount: json["InvoiceVoucherDiscount"] ?? '',
        invoiceFpCardNumber: json["InvoiceFPCardNumber"] ?? '',
        invoiceFpcDiscount: json["InvoiceFPCDiscount"] ?? '',
        invoiceTotalDiscount: json["InvoiceTotalDiscount"] ?? '',
        invoiceTotalAmountAfterDiscount:
            json["InvoiceTotalAmountAfterDiscount"] ?? '',
        invoiceTotalPaidIncTaxAmount:
            json["InvoiceTotalPaidIncTaxAmount"] ?? '',
        invoicePackageBooingId: json["InvoicePackageBooingID"],
        invoicePackageBooingNumber: json["InvoicePackageBooingNumber"],
        invoiceUrl: json["InvoiceURL"],
        invoicePModeDtl: List<InvoicePModeDtl>.from(
            json["InvoicePModeDtl"].map((x) => InvoicePModeDtl.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "InvoiceId": invoiceId,
        "CenterName": centerName,
        "CenterCode": centerCode,
        "ClientId": clientId,
        "ClientName": clientName,
        "InvoiceNumber": invoiceNumber,
        "InvoiceDate":
            "${invoiceDate!.year.toString().padLeft(4, '0')}-${invoiceDate!.month.toString().padLeft(2, '0')}-${invoiceDate!.day.toString().padLeft(2, '0')}",
        "InvoiceCashbackDiscount": invoiceCashbackDiscount,
        "InvoiceLoyaltyDiscount": invoiceLoyaltyDiscount,
        "InvoiceVoucherDiscount": invoiceVoucherDiscount,
        "InvoiceFPCardNumber": invoiceFpCardNumber,
        "InvoiceFPCDiscount": invoiceFpcDiscount,
        "InvoiceTotalDiscount": invoiceTotalDiscount,
        "InvoiceTotalAmountAfterDiscount": invoiceTotalAmountAfterDiscount,
        "InvoiceTotalPaidIncTaxAmount": invoiceTotalPaidIncTaxAmount,
        "InvoicePackageBooingID": invoicePackageBooingId,
        "InvoicePackageBooingNumber": invoicePackageBooingNumber,
        "InvoiceURL": invoiceUrl,
        "InvoicePModeDtl":
            List<dynamic>.from(invoicePModeDtl!.map((x) => x.toJson())),
      };
}

class InvoicePModeDtl {
  InvoicePModeDtl({
    this.invoicePackagePaymentId = '',
    this.invoicePackagePaymentRefNo = '',
    this.invoicePackagePaymentDate = '',
    this.invoicePackagePaymentBank = '',
    this.invoicePackagePaymentBankBranch = '',
    this.invoicePackagePaymentAmount = '',
    this.invoicePackagePaymentStatus = '',
  });

  String invoicePackagePaymentId;
  String invoicePackagePaymentRefNo;
  String invoicePackagePaymentDate;
  String invoicePackagePaymentBank;
  String invoicePackagePaymentBankBranch;
  String invoicePackagePaymentAmount;
  String invoicePackagePaymentStatus;

  factory InvoicePModeDtl.fromJson(Map<String, dynamic> json) =>
      InvoicePModeDtl(
        invoicePackagePaymentId: json["InvoicePackagePaymentId"],
        invoicePackagePaymentRefNo: json["InvoicePackagePaymentRefNo"],
        invoicePackagePaymentDate: json["InvoicePackagePaymentDate"],
        invoicePackagePaymentBank: json["InvoicePackagePaymentBank"],
        invoicePackagePaymentBankBranch:
            json["InvoicePackagePaymentBankBranch"] ?? '',
        invoicePackagePaymentAmount: json["InvoicePackagePaymentAmount"] ?? '',
        invoicePackagePaymentStatus: json["InvoicePackagePaymentStatus"],
      );

  Map<String, dynamic> toJson() => {
        "InvoicePackagePaymentId": invoicePackagePaymentId,
        "InvoicePackagePaymentRefNo": invoicePackagePaymentRefNo,
        "InvoicePackagePaymentDate": invoicePackagePaymentDate,
        "InvoicePackagePaymentBank": invoicePackagePaymentBank,
        "InvoicePackagePaymentBankBranch": invoicePackagePaymentBankBranch,
        "InvoicePackagePaymentAmount": invoicePackagePaymentAmount,
        "InvoicePackagePaymentStatus": invoicePackagePaymentStatus,
      };
}
