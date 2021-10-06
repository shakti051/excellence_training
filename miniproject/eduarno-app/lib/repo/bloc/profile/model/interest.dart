class Interest {
  Interest({
    this.specialization,
    this.topic,
  });

  String specialization;
  List<String> topic;

  factory Interest.fromJson(Map<String, dynamic> json) => Interest(
        specialization: json["specialiation"],
        topic: List<String>.from(json["topic"]?.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "specialiation": specialization,
        "topic": List<dynamic>.from(topic.map((x) => x)),
      };
}
