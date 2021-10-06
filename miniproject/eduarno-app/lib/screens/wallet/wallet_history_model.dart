class WalletHistoryModel {
  String id;
  String entity;
  int amount;
  int amountPaid;
  int amountDue;
  String currency;
  String receipt;
  Null offerId;
  String status;
  int attempts;
//  List<Null> notes;
  int createdAt;

  WalletHistoryModel(
      {this.id,
      this.entity,
      this.amount,
      this.amountPaid,
      this.amountDue,
      this.currency,
      this.receipt,
      this.offerId,
      this.status,
      this.attempts,
  //    this.notes,
      this.createdAt});

  WalletHistoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    entity = json['entity'];
    amount = json['amount'];
    amountPaid = json['amount_paid'];
    amountDue = json['amount_due'];
    currency = json['currency'];
    receipt = json['receipt'];
    offerId = json['offer_id'];
    status = json['status'];
    attempts = json['attempts'];
    // if (json['notes'] != null) {
    // //  notes = new List<Null>();
    //   json['notes'].forEach((v) {
    //    // notes.add(new Null.fromJson(v));
    //   });
    // }
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['entity'] = this.entity;
    data['amount'] = this.amount;
    data['amount_paid'] = this.amountPaid;
    data['amount_due'] = this.amountDue;
    data['currency'] = this.currency;
    data['receipt'] = this.receipt;
    data['offer_id'] = this.offerId;
    data['status'] = this.status;
    data['attempts'] = this.attempts;
//     if (this.notes != null) {
//  //     data['notes'] = this.notes.map((v) => v.toJson()).toList();
//     }
    data['created_at'] = this.createdAt;
    return data;
  }
}