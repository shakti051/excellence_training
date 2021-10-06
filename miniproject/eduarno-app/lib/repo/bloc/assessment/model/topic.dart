class Topic {
  Topic({
    this.id,
    this.topicId,
    this.specialisationId,
    this.topic,
    this.createdAt,
    this.isActive,
    this.updatedAt,
  });

  String id;
  String topicId;
  String specialisationId;
  String topic;
  int createdAt;
  bool isActive;
  int updatedAt;

  factory Topic.fromJson(Map<String, dynamic> json) => Topic(
        id: json["_id"],
        topicId: json["topic_id"],
        specialisationId: json["specialisation_id"],
        topic: json["topic"],
        createdAt: json["created_at"],
        isActive: json["is_active"],
        updatedAt: json["updated_at"] == null ? null : json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "topic_id": topicId,
        "specialisation_id": specialisationId,
        "topic": topic,
        "created_at": createdAt,
        "is_active": isActive,
        "updated_at": updatedAt == null ? null : updatedAt,
      };
}
