class CategoryModel {
  int status;
  List<CategoryData> data;

  CategoryModel({this.status, this.data});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = new List<CategoryData>();
      json['data'].forEach((v) {
        data.add(new CategoryData.fromJson(v));
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

class CategoryData {
  String termText;
  int termTypeId;
  bool value;
  List<SubInterest> subInterest;

  CategoryData({this.termText, this.termTypeId, this.value, this.subInterest});

  CategoryData.fromJson(Map<String, dynamic> json) {
    termText = json['termText'];
    termTypeId = json['termTypeId'];
    value = json['value'];
    if (json['subInterest'] != null) {
      subInterest = new List<SubInterest>();
      json['subInterest'].forEach((v) {
        subInterest.add(new SubInterest.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['termText'] = this.termText;
    data['termTypeId'] = this.termTypeId;
    data['value'] = this.value;
    if (this.subInterest != null) {
      data['subInterest'] = this.subInterest.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubInterest {
  String termText;
  int termTypeId;
  String backgroundimg;
  String groupimg;
  bool value;
  List<Interest> interest;

  SubInterest(
      {this.termText,
        this.termTypeId,
        this.backgroundimg,
        this.groupimg,
        this.value,
        this.interest});

  SubInterest.fromJson(Map<String, dynamic> json) {
    termText = json['termText'];
    termTypeId = json['termTypeId'];
    backgroundimg = json['backgroundimg'];
    groupimg = json['groupimg'];
    value = json['value'];
    if (json['interest'] != null) {
      interest = new List<Interest>();
      json['interest'].forEach((v) {
        interest.add(new Interest.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['termText'] = this.termText;
    data['termTypeId'] = this.termTypeId;
    data['backgroundimg'] = this.backgroundimg;
    data['groupimg'] = this.groupimg;
    data['value'] = this.value;
    if (this.interest != null) {
      data['interest'] = this.interest.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Interest {
  String termText;
  int termTypeId;
  int mainCategory;
  bool value;

  Interest({this.termText, this.termTypeId, this.mainCategory, this.value});

  Interest.fromJson(Map<String, dynamic> json) {
    termText = json['termText'];
    termTypeId = json['termTypeId'];
    mainCategory = json['mainCategory'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['termText'] = this.termText;
    data['termTypeId'] = this.termTypeId;
    data['mainCategory'] = this.mainCategory;
    data['value'] = this.value;
    return data;
  }
}
