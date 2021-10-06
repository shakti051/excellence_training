class WalletTrasanctionModel {
  String message;
  Data data;
  int code;

  WalletTrasanctionModel({this.message, this.data, this.code});

  WalletTrasanctionModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['code'] = this.code;
    return data;
  }
}

class Data {
  String sId;
  String userId;
  String transactionAmount;
  String transactionType;
  String paymentStatus;
  int createdAt;

  Data(
      {this.sId,
      this.userId,
      this.transactionAmount,
      this.transactionType,
      this.paymentStatus,
      this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['user_id'];
    transactionAmount = json['transaction_amount'];
    transactionType = json['transaction_type'];
    paymentStatus = json['payment_status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['user_id'] = this.userId;
    data['transaction_amount'] = this.transactionAmount;
    data['transaction_type'] = this.transactionType;
    data['payment_status'] = this.paymentStatus;
    data['created_at'] = this.createdAt;
    return data;
  }
}