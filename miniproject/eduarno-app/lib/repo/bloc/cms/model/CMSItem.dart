
class CMSItem {
  CMSItem({
    this.id,
    this.pageId,
    this.page,
    this.description,
    this.isActive,
    this.createdAt,
    this.metaData,
    this.shortDescription,
  });

  String id;
  String pageId;
  String page;
  String description;
  bool isActive;
  int createdAt;
  String metaData;
  String shortDescription;

  factory CMSItem.fromJson(Map<String, dynamic> json) => CMSItem(
    id: json["_id"],
    pageId: json["page_id"],
    page: json["page"],
    description: json["description"],
    isActive: json["is_active"],
    createdAt: json["created_at"],
    metaData: json["meta_data"] == null ? null : json["meta_data"],
    shortDescription: json["short_description"] == null ? null : json["short_description"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "page_id": pageId,
    "page": page,
    "description": description,
    "is_active": isActive,
    "created_at": createdAt,
    "meta_data": metaData == null ? null : metaData,
    "short_description": shortDescription == null ? null : shortDescription,
  };
}
