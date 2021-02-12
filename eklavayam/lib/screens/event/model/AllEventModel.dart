class AllEventModel {
  int status;
  List<AllEventData> data;
  String message;

  AllEventModel({this.status, this.data, this.message});

  AllEventModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = new List<AllEventData>();
      json['data'].forEach((v) {
        data.add(new AllEventData.fromJson(v));
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

class AllEventData {
  int uniqueId;
  int eventType;
  String eventCategory;
  String eventName;
  String description;
  int startDate;
  int endDate;
  List<String> eventImages;
  String paidType;
  int numberOfTickets;
  int ticketPerBooking;
  int ticketPrice;
  var basePrice;
  double tax;
  String baseCurrency;
  String ticketDescription;
  String emailTemplate;
  int organisorId;
  int attendeesType;
  String fullName;
  String profileImg;
  int termTypeId;
  String eventTypes;
  int eventTypeId;
  String offers;
  int star;

  AllEventData(
      {this.uniqueId,
        this.eventType,
        this.eventCategory,
        this.eventName,
        this.description,
        this.startDate,
        this.endDate,
        this.eventImages,
        this.paidType,
        this.numberOfTickets,
        this.ticketPerBooking,
        this.ticketPrice,
        this.basePrice,
        this.tax,
        this.baseCurrency,
        this.ticketDescription,
        this.emailTemplate,
        this.organisorId,
        this.attendeesType,
        this.fullName,
        this.profileImg,
        this.termTypeId,
        this.eventTypes,
        this.eventTypeId,
        this.offers,
        this.star});

  AllEventData.fromJson(Map<String, dynamic> json) {
    uniqueId = json['uniqueId'];
    eventType = json['eventType'];
    eventCategory = json['eventCategory'];
    eventName = json['eventName'];
    description = json['description'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    eventImages = json['eventImages'].cast<String>();
    paidType = json['paidType'];
    numberOfTickets = json['numberOfTickets'];
    ticketPerBooking = json['ticketPerBooking'];
    ticketPrice = json['ticketPrice'];
    basePrice = json['basePrice'];
    tax = json['tax'];
    baseCurrency = json['baseCurrency'];
    ticketDescription = json['ticketDescription'];
    emailTemplate = json['emailTemplate'];
    organisorId = json['organisorId'];
    attendeesType = json['attendeesType'];
    fullName = json['fullName'];
    profileImg = json['profileImg'];
    termTypeId = json['termTypeId'];
    eventTypes = json['eventTypes'];
    eventTypeId = json['eventTypeId'];
    offers = json['offers'];
    star = json['star'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uniqueId'] = this.uniqueId;
    data['eventType'] = this.eventType;
    data['eventCategory'] = this.eventCategory;
    data['eventName'] = this.eventName;
    data['description'] = this.description;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['eventImages'] = this.eventImages;
    data['paidType'] = this.paidType;
    data['numberOfTickets'] = this.numberOfTickets;
    data['ticketPerBooking'] = this.ticketPerBooking;
    data['ticketPrice'] = this.ticketPrice;
    data['basePrice'] = this.basePrice;
    data['tax'] = this.tax;
    data['baseCurrency'] = this.baseCurrency;
    data['ticketDescription'] = this.ticketDescription;
    data['emailTemplate'] = this.emailTemplate;
    data['organisorId'] = this.organisorId;
    data['attendeesType'] = this.attendeesType;
    data['fullName'] = this.fullName;
    data['profileImg'] = this.profileImg;
    data['termTypeId'] = this.termTypeId;
    data['eventTypes'] = this.eventTypes;
    data['eventTypeId'] = this.eventTypeId;
    data['offers'] = this.offers;
    data['star'] = this.star;
    return data;
  }
}








// class AllEventModel {
//   int status;
//   List<AllEventData> data;
//   String message;
//
//   AllEventModel({this.status, this.data, this.message});
//
//   AllEventModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     if (json['data'] != null) {
//       data = new List<AllEventData>();
//       json['data'].forEach((v) {
//         data.add(new AllEventData.fromJson(v));
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
// class AllEventData {
//   int uniqueId;
//   int eventType;
//   var eventCategory;
//   String eventName;
//   String description;
//   int startDate;
//   int endDate;
//   List<String> eventImages;
//   var paidType;
//   int numberOfTickets;
//   int ticketPerBooking;
//   int ticketPrice;
//   var basePrice;
//   double tax;
//   String baseCurrency;
//   String ticketDescription;
//   String emailTemplate;
//   int organisorId;
//   int attendeesType;
//
//   AllEventData(
//       {this.uniqueId,
//         this.eventType,
//         this.eventCategory,
//         this.eventName,
//         this.description,
//         this.startDate,
//         this.endDate,
//         this.eventImages,
//         this.paidType,
//         this.numberOfTickets,
//         this.ticketPerBooking,
//         this.ticketPrice,
//         this.basePrice,
//         this.tax,
//         this.baseCurrency,
//         this.ticketDescription,
//         this.emailTemplate,
//         this.organisorId,
//         this.attendeesType});
//
//   AllEventData.fromJson(Map<String, dynamic> json) {
//     uniqueId = json['uniqueId'];
//     eventType = json['eventType'];
//     eventCategory = json['eventCategory'];
//     eventName = json['eventName'];
//     description = json['description'];
//     startDate = json['startDate'];
//     endDate = json['endDate'];
//     eventImages = json['eventImages'].cast<String>();
//     paidType = json['paidType'];
//     numberOfTickets = json['numberOfTickets'];
//     ticketPerBooking = json['ticketPerBooking'];
//     ticketPrice = json['ticketPrice'];
//     basePrice = json['basePrice'];
//     tax = json['tax'];
//     baseCurrency = json['baseCurrency'];
//     ticketDescription = json['ticketDescription'];
//     emailTemplate = json['emailTemplate'];
//     organisorId = json['organisorId'];
//     attendeesType = json['attendeesType'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['uniqueId'] = this.uniqueId;
//     data['eventType'] = this.eventType;
//     data['eventCategory'] = this.eventCategory;
//     data['eventName'] = this.eventName;
//     data['description'] = this.description;
//     data['startDate'] = this.startDate;
//     data['endDate'] = this.endDate;
//     data['eventImages'] = this.eventImages;
//     data['paidType'] = this.paidType;
//     data['numberOfTickets'] = this.numberOfTickets;
//     data['ticketPerBooking'] = this.ticketPerBooking;
//     data['ticketPrice'] = this.ticketPrice;
//     data['basePrice'] = this.basePrice;
//     data['tax'] = this.tax;
//     data['baseCurrency'] = this.baseCurrency;
//     data['ticketDescription'] = this.ticketDescription;
//     data['emailTemplate'] = this.emailTemplate;
//     data['organisorId'] = this.organisorId;
//     data['attendeesType'] = this.attendeesType;
//     return data;
//   }
// }
//






