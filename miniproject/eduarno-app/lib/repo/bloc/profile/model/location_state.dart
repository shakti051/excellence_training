class LocationState {
  LocationState({
    this.id,
    this.stateId,
    this.countryId,
    this.state,
    this.createdAt,
    this.isActive,
    this.updatedAt,
  });

  String id;
  String stateId;
  String countryId;
  String state;
  int createdAt;
  bool isActive;
  int updatedAt;

  factory LocationState.fromJson(Map<String, dynamic> json) => LocationState(
        id: json["_id"],
        stateId: json["state_id"],
        countryId: json["country_id"],
        state: json["state"],
        createdAt: json["created_at"],
        isActive: json["is_active"],
        updatedAt: json["updated_at"] == null ? null : json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "state_id": stateId,
        "country_id": countryId,
        "state": state,
        "created_at": createdAt,
        "is_active": isActive,
        "updated_at": updatedAt == null ? null : updatedAt,
      };
}
