class EventDetailModel {
  int status;
  EventDetailData data;
  String message;

  EventDetailModel({this.status, this.data, this.message});

  EventDetailModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new EventDetailData.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class EventDetailData {
  int uniqueId;
  int eventType;
  int eventCategory;
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
  var ticketDescription;
  String emailTemplate;
  int organisorId;
  String attendeesType;
  int remainingTicket;

  EventDetailData(
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
        this.remainingTicket});

  EventDetailData.fromJson(Map<String, dynamic> json) {
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
    remainingTicket = json['remainingTicket'];
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
    data['remainingTicket'] = this.remainingTicket;
    return data;
  }
}












// class EventDetailModel {
//   int status;
//   EventDetailData data;
//   String message;
//
//   EventDetailModel({this.status, this.data, this.message});
//
//   EventDetailModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     data = json['data'] != null ? new EventDetailData.fromJson(json['data']) : null;
//     message = json['message'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     if (this.data != null) {
//       data['data'] = this.data.toJson();
//     }
//     data['message'] = this.message;
//     return data;
//   }
// }
//
// class EventDetailData {
//   int uniqueId;
//   int eventType;
//   int eventCategory;
//   String eventName;
//   String description;
//   int startDate;
//   int endDate;
//   List<String> eventImages;
//   int paidType;
//   int numberOfTickets;
//   int ticketPerBooking;
//   int ticketPrice;
//   double basePrice;
//   double tax;
//   String baseCurrency;
//   var ticketDescription;
//   String emailTemplate;
//   int organisorId;
//   int attendeesType;
//
//   EventDetailData(
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
//   EventDetailData.fromJson(Map<String, dynamic> json) {
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










