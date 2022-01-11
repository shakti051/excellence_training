// To parse this JSON data, do
//
//     final cashBookinInvoiceModel = cashBookinInvoiceModelFromJson(jsonString);

import 'dart:convert';

CashBookingInvoiceModel cashBookinInvoiceModelFromJson(String str) =>
    CashBookingInvoiceModel.fromJson(json.decode(str));

String cashBookinInvoiceModelToJson(CashBookingInvoiceModel data) =>
    json.encode(data.toJson());

class CashBookingInvoiceModel {
  CashBookingInvoiceModel({
    this.status = 2000,
    this.message = '',
    this.invoiceDetails,
  });

  int status;
  String message;
  List<CashInvoiceDetail>? invoiceDetails;

  factory CashBookingInvoiceModel.fromJson(Map<String, dynamic> json) =>
      CashBookingInvoiceModel(
        status: json["Status"],
        message: json["Message"],
        invoiceDetails: List<CashInvoiceDetail>.from(
            json["InvoiceDetails"].map((x) => CashInvoiceDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "InvoiceDetails":
            List<dynamic>.from(invoiceDetails!.map((x) => x.toJson())),
      };
}

class CashInvoiceDetail {
  CashInvoiceDetail({
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
    this.invoiceUrl = '',
    this.invoiceAppointmentId = '',
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
  String invoiceUrl;
  String invoiceAppointmentId;
  List<InvoicePModeDtl>? invoicePModeDtl;

  factory CashInvoiceDetail.fromJson(Map<String, dynamic> json) =>
      CashInvoiceDetail(
        invoiceId: json["InvoiceId"] ?? '',
        centerName: json["CenterName"] ?? '',
        centerCode: json["CenterCode"] ?? '',
        clientId: json["ClientId"] ?? '',
        clientName: json["ClientName"] ?? '',
        invoiceNumber: json["InvoiceNumber"] ?? '',
        invoiceDate: DateTime.parse(json["InvoiceDate"] ?? DateTime.now()),
        invoiceCashbackDiscount: json["InvoiceCashbackDiscount"] ?? '',
        invoiceLoyaltyDiscount: json["InvoiceLoyaltyDiscount"] ?? '',
        invoiceVoucherDiscount: json["InvoiceVoucherDiscount"] ?? '',
        invoiceFpCardNumber: json["InvoiceFPCardNumber"] ?? '',
        invoiceFpcDiscount: json["InvoiceFPCDiscount"] ?? '',
        invoiceTotalDiscount: json["InvoiceTotalDiscount"] ?? '',
        invoiceTotalAmountAfterDiscount:
            json["InvoiceTotalAmountAfterDiscount"],
        invoiceTotalPaidIncTaxAmount: json["InvoiceTotalPaidIncTaxAmount"],
        invoiceUrl: json["InvoiceURL"],
        invoiceAppointmentId: json["InvoiceAppointmentId"],
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
        "InvoiceURL": invoiceUrl,
        "InvoiceAppointmentId": invoiceAppointmentId,
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
        invoicePackagePaymentAmount: json["InvoicePackagePaymentAmount"],
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
