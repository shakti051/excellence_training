// To parse this JSON data, do
//
//     final offerBannerModel = offerBannerModelFromJson(jsonString);

import 'dart:convert';

OfferBannerModel offerBannerModelFromJson(String str) =>
    OfferBannerModel.fromJson(json.decode(str));

String offerBannerModelToJson(OfferBannerModel data) =>
    json.encode(data.toJson());

class OfferBannerModel {
  OfferBannerModel({
    this.success = 1,
    this.banner,
  });

  int success;
  List<BannerUnit>? banner;

  factory OfferBannerModel.fromJson(Map<String, dynamic> json) =>
      OfferBannerModel(
        success: json["Success"],
        banner: List<BannerUnit>.from(
            json["Banner"].map((x) => BannerUnit.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Success": success,
        "Banner": List<dynamic>.from(banner!.map((x) => x.toJson())),
      };
}

class BannerUnit {
  BannerUnit({
    this.img = '',
    this.url = '',
  });

  String img;
  String url;

  factory BannerUnit.fromJson(Map<String, dynamic> json) => BannerUnit(
        img: json["img"] ??
            'https://www.vlccwellness.com/India/media/wysiwyg/offers/ayurveda-therapy-sep-mob.jpg',
        url: json["url"] ??
            'https://www.vlccwellness.com/India/promotion-page/thermage.php?utm_source=consumer app&utm_medium=app&source=consumer app',
      );

  Map<String, dynamic> toJson() => {
        "img": img,
        "url": url,
      };
}
