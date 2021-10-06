class WalletListingModel {
  String message;
  List<Data> data;
  int code;

  WalletListingModel({this.message, this.data, this.code});

  WalletListingModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['code'] = this.code;
    return data;
  }
}

class Data {
  String sId;
  String userId;
  int walletAmount;
  String transactionType;
  dynamic transactionAmount;
  int createdAt;

  Data(
      {this.sId,
      this.userId,
      this.walletAmount,
      this.transactionType,
      this.transactionAmount,
      this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['user_id'];
    walletAmount = json['wallet_amount'];
    transactionType = json['transaction_type'];
    transactionAmount = json['transaction_amount'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['user_id'] = this.userId;
    data['wallet_amount'] = this.walletAmount;
    data['transaction_type'] = this.transactionType;
    data['transaction_amount'] = this.transactionAmount;
    data['created_at'] = this.createdAt;
    return data;
  }
}