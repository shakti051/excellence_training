// To parse this JSON data, do
//
//     final serviceMasterMainModel = serviceMasterMainModelFromJson(jsonString);

import 'dart:convert';

ServiceMasterMainModel serviceMasterMainModelFromJson(String str) =>
    ServiceMasterMainModel.fromJson(json.decode(str));

String serviceMasterMainModelToJson(ServiceMasterMainModel data) =>
    json.encode(data.toJson());

class ServiceMasterMainModel {
  ServiceMasterMainModel({
    this.status,
    this.message = 'unavailable',
    this.serviceMaster,
  });

  int? status;
  String message;
  List<ServiceMasterDatabase>? serviceMaster;

  factory ServiceMasterMainModel.fromJson(Map<String, dynamic> json) =>
      ServiceMasterMainModel(
        status: json["Status"],
        message: json["Message"],
        serviceMaster: List<ServiceMasterDatabase>.from(json["ServiceMaster"]
            .map((x) => ServiceMasterDatabase.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "ServiceMaster":
            List<dynamic>.from(serviceMaster!.map((x) => x.toJson())),
      };
}

class ServiceMasterDatabase {
  ServiceMasterDatabase({
    this.id,
    this.serviceCode = '',
    this.serviceName = '',
    this.serviceCategory = '',
    this.serviceSubCategory1 = '',
    this.serviceSubCategory2 = '',
    this.serviceType = '',
    this.serviceAppFor = '',
    this.serviceStatus = '',
    this.popularService = 'no',
  });

  int? id;
  String serviceCode;
  String serviceName;
  String serviceCategory;
  String serviceSubCategory1;
  String serviceSubCategory2;
  String serviceType;
  String serviceAppFor;
  String serviceStatus;
  String popularService;

  factory ServiceMasterDatabase.fromJson(Map<String, dynamic> json) =>
      ServiceMasterDatabase(
        id: json["id"],
        serviceCode: json["service_code"],
        serviceName: json["service_name"],
        serviceCategory: json["service_category"] ?? '',
        serviceSubCategory1: json["service_sub_category1"],
        serviceSubCategory2: json["service_sub_category2"],
        serviceType: json["service_type"],
        serviceAppFor: json["service_app_for"] ?? '',
        serviceStatus: json["service_status"],
        popularService: json["popular_center"] ?? 'no',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "service_code": serviceCode,
        "service_name": serviceName,
        "service_category": serviceCategory,
        "service_sub_category1": serviceSubCategory1,
        "service_sub_category2": serviceSubCategory2,
        "service_type": serviceType,
        "service_app_for": serviceAppFor,
        "service_status": serviceStatus,
        "popular_center": popularService,
      };
}
