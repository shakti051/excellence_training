class MyTicketModel {
  int status;
  List<MyTicketData> data;
  String message;

  MyTicketModel({this.status, this.data, this.message});

  MyTicketModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = new List<MyTicketData>();
      json['data'].forEach((v) {
        data.add(new MyTicketData.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class MyTicketData {
  int uniqueId;
  int eventId;
  int userId;
  String firstName;
  String lastName;
  String mobile;
  String email;
  int totalTicketPrice;
  var totalPrice;
  var totalTax;
  int ticketCount;
  int createdOn;
  String promotionId;
  String seatPrefix;
  int isTrashed;
  String paymentMode;
  String paymentID;
  String transactionID;
  String transactionOn;
  int eventType;
  int eventCategory;
  String description;
  String eventName;
  String eventImages;
  int startDate;
  int endDate;
  String paidType;
  String eventTypes;
  String offers;
  String startDay;
  String startMonthName;
  String ticketTime;
  String ticketTimeAMPM;

  MyTicketData(
      {this.uniqueId,
        this.eventId,
        this.userId,
        this.firstName,
        this.lastName,
        this.mobile,
        this.email,
        this.totalTicketPrice,
        this.totalPrice,
        this.totalTax,
        this.ticketCount,
        this.createdOn,
        this.promotionId,
        this.seatPrefix,
        this.isTrashed,
        this.paymentMode,
        this.paymentID,
        this.transactionID,
        this.transactionOn,
        this.eventType,
        this.eventCategory,
        this.description,
        this.eventName,
        this.eventImages,
        this.startDate,
        this.endDate,
        this.paidType,
        this.eventTypes,
        this.offers,
        this.startDay,
        this.startMonthName,
        this.ticketTime,
        this.ticketTimeAMPM});

  MyTicketData.fromJson(Map<String, dynamic> json) {
    uniqueId = json['uniqueId'];
    eventId = json['eventId'];
    userId = json['userId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    mobile = json['mobile'];
    email = json['email'];
    totalTicketPrice = json['totalTicketPrice'];
    totalPrice = json['totalPrice'];
    totalTax = json['totalTax'];
    ticketCount = json['ticketCount'];
    createdOn = json['createdOn'];
    promotionId = json['promotionId'];
    seatPrefix = json['seatPrefix'];
    isTrashed = json['isTrashed'];
    paymentMode = json['paymentMode'];
    paymentID = json['paymentID'];
    transactionID = json['transactionID'];
    transactionOn = json['transactionOn'];
    eventType = json['eventType'];
    eventCategory = json['eventCategory'];
    description = json['description'];
    eventName = json['eventName'];
    eventImages = json['eventImages'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    paidType = json['paidType'];
    eventTypes = json['eventTypes'];
    offers = json['offers'];
    startDay = json['startDay'];
    startMonthName = json['startMonthName'];
    ticketTime = json['ticketTime'];
    ticketTimeAMPM = json['ticketTimeAMPM'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uniqueId'] = this.uniqueId;
    data['eventId'] = this.eventId;
    data['userId'] = this.userId;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['totalTicketPrice'] = this.totalTicketPrice;
    data['totalPrice'] = this.totalPrice;
    data['totalTax'] = this.totalTax;
    data['ticketCount'] = this.ticketCount;
    data['createdOn'] = this.createdOn;
    data['promotionId'] = this.promotionId;
    data['seatPrefix'] = this.seatPrefix;
    data['isTrashed'] = this.isTrashed;
    data['paymentMode'] = this.paymentMode;
    data['paymentID'] = this.paymentID;
    data['transactionID'] = this.transactionID;
    data['transactionOn'] = this.transactionOn;
    data['eventType'] = this.eventType;
    data['eventCategory'] = this.eventCategory;
    data['description'] = this.description;
    data['eventName'] = this.eventName;
    data['eventImages'] = this.eventImages;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['paidType'] = this.paidType;
    data['eventTypes'] = this.eventTypes;
    data['offers'] = this.offers;
    data['startDay'] = this.startDay;
    data['startMonthName'] = this.startMonthName;
    data['ticketTime'] = this.ticketTime;
    data['ticketTimeAMPM'] = this.ticketTimeAMPM;
    return data;
  }
}





// class MyTicketModel {
//   int status;
//   List<MyTicketData> data;
//   String message;
//
//   MyTicketModel({this.status, this.data, this.message});
//
//   MyTicketModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     if (json['data'] != null) {
//       data = new List<MyTicketData>();
//       json['data'].forEach((v) {
//         data.add(new MyTicketData.fromJson(v));
//       });
//     }
//     message = json['message'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     if (this.data != null) {
//       data['data'] = this.data.map((v) => v.toJson()).toList();
//     }
//     data['message'] = this.message;
//     return data;
//   }
// }
//
// class MyTicketData {
//   int uniqueId;
//   int eventId;
//   int userId;
//   String firstName;
//   String lastName;
//   String mobile;
//   String email;
//   int totalTicketPrice;
//   var totalPrice;
//   var totalTax;
//   int ticketCount;
//   int createdOn;
//   Null promotionId;
//   Null seatPrefix;
//   int isTrashed;
//   int paymentMode;
//   String paymentID;
//   String transactionID;
//   int transactionOn;
//   int eventType;
//   int eventCategory;
//   String description;
//   String eventName;
//   String eventImages;
//   String paidType;
//   String eventTypes;
//   String offers;
//   String startDay;
//   String startMonthName;
//   String ticketTime;
//   String ticketTimeAMPM;
//
//   MyTicketData(
//       {this.uniqueId,
//         this.eventId,
//         this.userId,
//         this.firstName,
//         this.lastName,
//         this.mobile,
//         this.email,
//         this.totalTicketPrice,
//         this.totalPrice,
//         this.totalTax,
//         this.ticketCount,
//         this.createdOn,
//         this.promotionId,
//         this.seatPrefix,
//         this.isTrashed,
//         this.paymentMode,
//         this.paymentID,
//         this.transactionID,
//         this.transactionOn,
//         this.eventType,
//         this.eventCategory,
//         this.description,
//         this.eventName,
//         this.eventImages,
//         this.paidType,
//         this.eventTypes,
//         this.offers,
//         this.startDay,
//         this.startMonthName,
//         this.ticketTime,
//         this.ticketTimeAMPM});
//
//   MyTicketData.fromJson(Map<String, dynamic> json) {
//     uniqueId = json['uniqueId'];
//     eventId = json['eventId'];
//     userId = json['userId'];
//     firstName = json['firstName'];
//     lastName = json['lastName'];
//     mobile = json['mobile'];
//     email = json['email'];
//     totalTicketPrice = json['totalTicketPrice'];
//     totalPrice = json['totalPrice'];
//     totalTax = json['totalTax'];
//     ticketCount = json['ticketCount'];
//     createdOn = json['createdOn'];
//     promotionId = json['promotionId'];
//     seatPrefix = json['seatPrefix'];
//     isTrashed = json['isTrashed'];
//     paymentMode = json['paymentMode'];
//     paymentID = json['paymentID'];
//     transactionID = json['transactionID'];
//     transactionOn = json['transactionOn'];
//     eventType = json['eventType'];
//     eventCategory = json['eventCategory'];
//     description = json['description'];
//     eventName = json['eventName'];
//     eventImages = json['eventImages'];
//     paidType = json['paidType'];
//     eventTypes = json['eventTypes'];
//     offers = json['offers'];
//     startDay = json['startDay'];
//     startMonthName = json['startMonthName'];
//     ticketTime = json['ticketTime'];
//     ticketTimeAMPM = json['ticketTimeAMPM'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['uniqueId'] = this.uniqueId;
//     data['eventId'] = this.eventId;
//     data['userId'] = this.userId;
//     data['firstName'] = this.firstName;
//     data['lastName'] = this.lastName;
//     data['mobile'] = this.mobile;
//     data['email'] = this.email;
//     data['totalTicketPrice'] = this.totalTicketPrice;
//     data['totalPrice'] = this.totalPrice;
//     data['totalTax'] = this.totalTax;
//     data['ticketCount'] = this.ticketCount;
//     data['createdOn'] = this.createdOn;
//     data['promotionId'] = this.promotionId;
//     data['seatPrefix'] = this.seatPrefix;
//     data['isTrashed'] = this.isTrashed;
//     data['paymentMode'] = this.paymentMode;
//     data['paymentID'] = this.paymentID;
//     data['transactionID'] = this.transactionID;
//     data['transactionOn'] = this.transactionOn;
//     data['eventType'] = this.eventType;
//     data['eventCategory'] = this.eventCategory;
//     data['description'] = this.description;
//     data['eventName'] = this.eventName;
//     data['eventImages'] = this.eventImages;
//     data['paidType'] = this.paidType;
//     data['eventTypes'] = this.eventTypes;
//     data['offers'] = this.offers;
//     data['startDay'] = this.startDay;
//     data['startMonthName'] = this.startMonthName;
//     data['ticketTime'] = this.ticketTime;
//     data['ticketTimeAMPM'] = this.ticketTimeAMPM;
//     return data;
//   }
// }
