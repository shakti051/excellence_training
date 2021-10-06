class AssessmentItem {
  String message;
  int code;
  List<Data> data;

  AssessmentItem({this.message, this.code, this.data});

  AssessmentItem.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    code = json['code'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String sId;
  String testName;
  String topic;
  String specialisation;
  String instruction;
  String imgUrl;
  String mode;
  String numberOfSections;
  String numberOfQuestions;
  String passingPercentage;
  int totalMarks;
  String assessmentValidityFrom;
  String assessmentValidityTo;
  String businessLogic;
  String totalTimeQuestions;
  bool isPublished;
  int isCreated;
  bool isactive;
  String level;

  Data(
      {this.sId,
      this.testName,
      this.topic,
      this.specialisation,
      this.instruction,
      this.imgUrl,
      this.mode,
      this.numberOfSections,
      this.numberOfQuestions,
      this.passingPercentage,
      this.totalMarks,
      this.assessmentValidityFrom,
      this.assessmentValidityTo,
      this.businessLogic,
      this.totalTimeQuestions,
      this.isPublished,
      this.isCreated,
      this.isactive,
      this.level});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    testName = json['test_name'];
    topic = json['topic'];
    specialisation = json['specialisation'];
    instruction = json['instruction'];
    imgUrl = json['imgUrl'];
    mode = json['mode'];
    numberOfSections = json['number_of_sections'];
    numberOfQuestions = json['number_of_questions'];
    passingPercentage = json['passing_percentage'];
    totalMarks = json['total_marks'];
    assessmentValidityFrom = json['assessment_validity_from'];
    assessmentValidityTo = json['assessment_validity_to'];
    businessLogic = json['business_logic'];
    totalTimeQuestions = json['total_time_questions'];
    isPublished = json['isPublished'];
    isCreated = json['isCreated'];
    isactive = json['isactive'];
    level = json['level'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['test_name'] = this.testName;
    data['topic'] = this.topic;
    data['specialisation'] = this.specialisation;
    data['instruction'] = this.instruction;
    data['imgUrl'] = this.imgUrl;
    data['mode'] = this.mode;
    data['number_of_sections'] = this.numberOfSections;
    data['number_of_questions'] = this.numberOfQuestions;
    data['passing_percentage'] = this.passingPercentage;
    data['total_marks'] = this.totalMarks;
    data['assessment_validity_from'] = this.assessmentValidityFrom;
    data['assessment_validity_to'] = this.assessmentValidityTo;
    data['business_logic'] = this.businessLogic;
    data['total_time_questions'] = this.totalTimeQuestions;
    data['isPublished'] = this.isPublished;
    data['isCreated'] = this.isCreated;
    data['isactive'] = this.isactive;
    data['level'] = this.level;
    return data;
  }
}