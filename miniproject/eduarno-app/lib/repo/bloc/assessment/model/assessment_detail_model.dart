class AssessmentDetailModel {
  String message;
  int code;
  List<Assessment> assessment;
  List<Sections> sections;

  AssessmentDetailModel(
      {this.message, this.code, this.assessment, this.sections});

  AssessmentDetailModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    code = json['code'];
    if (json['assessment'] != null) {
      assessment = <Assessment>[];
      json['assessment'].forEach((v) {
        assessment.add(Assessment.fromJson(v));
      });
    }
    if (json['sections'] != null) {
      sections = <Sections>[];
      json['sections'].forEach((v) {
        sections.add(Sections.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['message'] = this.message;
    data['code'] = this.code;
    if (this.assessment != null) {
      data['assessment'] = this.assessment.map((v) => v.toJson()).toList();
    }
    if (this.sections != null) {
      data['sections'] = this.sections.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Assessment {
  String sId;
  String testName;
  String topic;
  String specialisation;
  String level;
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

  Assessment(
      {this.sId,
      this.testName,
      this.topic,
      this.specialisation,
      this.level,
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
      this.isactive});

  Assessment.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    testName = json['test_name'];
    topic = json['topic'];
    specialisation = json['specialisation'];
    level = json['level'];
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = this.sId;
    data['test_name'] = this.testName;
    data['topic'] = this.topic;
    data['specialisation'] = this.specialisation;
    data['level'] = this.level;
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
    return data;
  }
}

class Sections {
  String sId;
  int index;
  String assessmentId;
  String sectionTitle;
  String sectionInstruction;
  int noOfQuestionInSection;
  String sectionQuestionLevel;
  String marksPerCorrect;
  String marksPerIncorrectAnswer;
  bool isSelected;
  List<Questions> questions;

  Sections(
      {this.sId,
      this.index,
      this.assessmentId,
      this.sectionTitle,
      this.sectionInstruction,
      this.noOfQuestionInSection,
      this.sectionQuestionLevel,
      this.marksPerCorrect,
      this.marksPerIncorrectAnswer,
      this.isSelected,
      this.questions});

  Sections.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    index = json['index'];
    assessmentId = json['assessment_id'];
    sectionTitle = json['section_title'];
    sectionInstruction = json['section_instruction'];
    noOfQuestionInSection = json['no_of_question_in_section'];
    sectionQuestionLevel = json['section_question_level'];
    marksPerCorrect = json['marks_per_correct'];
    marksPerIncorrectAnswer = json['marks_per_incorrect_answer'];
    isSelected = json['isSelected'];
    if (json['questions'] != null) {
      questions = <Questions>[];
      json['questions'].forEach((v) {
        questions.add(Questions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = this.sId;
    data['index'] = this.index;
    data['assessment_id'] = this.assessmentId;
    data['section_title'] = this.sectionTitle;
    data['section_instruction'] = this.sectionInstruction;
    data['no_of_question_in_section'] = this.noOfQuestionInSection;
    data['section_question_level'] = this.sectionQuestionLevel;
    data['marks_per_correct'] = this.marksPerCorrect;
    data['marks_per_incorrect_answer'] = this.marksPerIncorrectAnswer;
    data['isSelected'] = this.isSelected;
    if (this.questions != null) {
      data['questions'] = this.questions.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Questions {
  String sId;
  String assessmentId;
  int index;
  int questionIndex;
  String questionId;
  String question;
  String questionType;
  String topic;
  String specialisation;
  List<Mcq> mcq;

  Questions(
      {this.sId,
      this.assessmentId,
      this.index,
      this.questionIndex,
      this.questionId,
      this.question,
      this.questionType,
      this.topic,
      this.specialisation,
      this.mcq});

  Questions.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    assessmentId = json['assessment_id'];
    index = json['index'];
    questionIndex = json['question_index'];
    questionId = json['question_id'];
    question = json['question'];
    questionType = json['question_type'];
    topic = json['topic'];
    specialisation = json['specialisation'];
    if (json['mcq'] != null) {
      mcq = <Mcq>[];
      json['mcq'].forEach((v) {
        mcq.add(Mcq.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = this.sId;
    data['assessment_id'] = this.assessmentId;
    data['index'] = this.index;
    data['question_index'] = this.questionIndex;
    data['question_id'] = this.questionId;
    data['question'] = this.question;
    data['question_type'] = this.questionType;
    data['topic'] = this.topic;
    data['specialisation'] = this.specialisation;
    if (this.mcq != null) {
      data['mcq'] = this.mcq.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Mcq {
  String answer;
  bool isanswer;
  bool isSelected;

  Mcq({this.answer, this.isanswer, this.isSelected});

  Mcq.fromJson(Map<String, dynamic> json) {
    answer = json['answer'];
    isanswer = json['isanswer'];
    isSelected = json['isSelected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['answer'] = this.answer;
    data['isanswer'] = this.isanswer;
    data['isSelected'] = this.isSelected;
    return data;
  }
}
