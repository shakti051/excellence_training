// To parse this JSON data, do
//
//     final uniqueServiceModel = uniqueServiceModelFromJson(jsonString);

import 'dart:convert';

UniqueServiceModel uniqueServiceModelFromJson(String str) =>
    UniqueServiceModel.fromJson(json.decode(str));

String uniqueServiceModelToJson(UniqueServiceModel data) =>
    json.encode(data.toJson());

class UniqueServiceModel {
  UniqueServiceModel({
    this.count = 1,
    this.serviceCategory = '',
  });

  int count;
  String serviceCategory;

  factory UniqueServiceModel.fromJson(Map<String, dynamic> json) =>
      UniqueServiceModel(
        count: json["COUNT"],
        serviceCategory: json["service_category"],
      );

  Map<String, dynamic> toJson() => {
        "COUNT": count,
        "service_category": serviceCategory,
      };
}
