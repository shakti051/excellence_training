class Specialization {
  Specialization({
    this.id,
    this.specialisationId,
    this.specialisation,
    this.createdAt,
    this.isActive,
    this.updatedAt,
  });

  String id;
  String specialisationId;
  String specialisation;
  int createdAt;
  bool isActive;
  int updatedAt;

  factory Specialization.fromJson(Map<String, dynamic> json) => Specialization(
        id: json["_id"],
        specialisationId: json["specialisation_id"],
        specialisation: json["specialisation"],
        createdAt: json["created_at"],
        isActive: json["is_active"],
        updatedAt: json["updated_at"] == null ? null : json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "specialisation_id": specialisationId,
        "specialisation": specialisation,
        "created_at": createdAt,
        "is_active": isActive,
        "updated_at": updatedAt == null ? null : updatedAt,
      };
}
