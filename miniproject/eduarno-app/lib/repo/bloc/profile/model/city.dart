class City {
  City({
    this.id,
    this.cityId,
    this.countryId,
    this.stateId,
    this.city,
    this.createdAt,
    this.isActive,
    this.updatedAt,
  });

  String id;
  String cityId;
  String countryId;
  String stateId;
  String city;
  int createdAt;
  bool isActive;
  int updatedAt;

  factory City.fromJson(Map<String, dynamic> json) => City(
    id: json["_id"],
    cityId: json["city_id"],
    countryId: json["country_id"],
    stateId: json["state_id"],
    city: json["city"],
    createdAt: json["created_at"],
    isActive: json["is_active"],
    updatedAt: json["updated_at"] == null ? null : json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "city_id": cityId,
    "country_id": countryId,
    "state_id": stateId,
    "city": city,
    "created_at": createdAt,
    "is_active": isActive,
    "updated_at": updatedAt == null ? null : updatedAt,
  };
}
