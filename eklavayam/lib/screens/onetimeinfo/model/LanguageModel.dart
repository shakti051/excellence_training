class LanguageModel {
  int status;
  List<LanguageData> data;

  LanguageModel({this.status, this.data});

  LanguageModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = new List<LanguageData>();
      json['data'].forEach((v) {
        data.add(new LanguageData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LanguageData {
  int termTypeId;
  int termId;
  String termTypeSlug;
  Null description;
  int parent;
  int priority;
  String lineageText;
  int createdOn;
  int updatedOn;
  int uniqueId;
  String termText;
  String slug;
  bool isSelected;

  LanguageData(
      {this.termTypeId,
        this.termId,
        this.termTypeSlug,
        this.description,
        this.parent,
        this.priority,
        this.lineageText,
        this.createdOn,
        this.updatedOn,
        this.uniqueId,
        this.termText,
        this.slug,
        this.isSelected});

  LanguageData.fromJson(Map<String, dynamic> json) {
    termTypeId = json['termTypeId'];
    termId = json['termId'];
    termTypeSlug = json['termTypeSlug'];
    description = json['description'];
    parent = json['parent'];
    priority = json['priority'];
    lineageText = json['lineageText'];
    createdOn = json['createdOn'];
    updatedOn = json['updatedOn'];
    uniqueId = json['uniqueId'];
    termText = json['termText'];
    slug = json['slug'];
    isSelected = json['isSelected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['termTypeId'] = this.termTypeId;
    data['termId'] = this.termId;
    data['termTypeSlug'] = this.termTypeSlug;
    data['description'] = this.description;
    data['parent'] = this.parent;
    data['priority'] = this.priority;
    data['lineageText'] = this.lineageText;
    data['createdOn'] = this.createdOn;
    data['updatedOn'] = this.updatedOn;
    data['uniqueId'] = this.uniqueId;
    data['termText'] = this.termText;
    data['slug'] = this.slug;
    data['isSelected'] = this.isSelected;
    return data;
  }
}
