// To parse this JSON data, do
//
//     final assessmentResultBody = assessmentResultBodyFromJson(jsonString);

import 'dart:convert';

AssessmentResultBody assessmentResultBodyFromJson(String str) =>
    AssessmentResultBody.fromJson(json.decode(str));

String assessmentResultBodyToJson(AssessmentResultBody data) =>
    json.encode(data.toJson());

class AssessmentResultBody {
  AssessmentResultBody({
    this.assessment,
    this.sections,
  });

  List<Assessment> assessment;
  List<Section> sections;

  factory AssessmentResultBody.fromJson(Map<String, dynamic> json) =>
      AssessmentResultBody(
        assessment: List<Assessment>.from(
            json["assessment"].map((x) => Assessment.fromJson(x))),
        sections: List<Section>.from(
            json["sections"].map((x) => Section.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "assessment": List<dynamic>.from(assessment.map((x) => x.toJson())),
        "sections": List<dynamic>.from(sections.map((x) => x.toJson())),
      };
}

class Assessment {
  Assessment({
    this.id,
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
    this.isactive,
  });

  String id;
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

  factory Assessment.fromJson(Map<String, dynamic> json) => Assessment(
        id: json["_id"],
        testName: json["test_name"],
        topic: json["topic"],
        specialisation: json["specialisation"],
        level: json["level"],
        instruction: json["instruction"],
        imgUrl: json["imgUrl"],
        mode: json["mode"],
        numberOfSections: json["number_of_sections"],
        numberOfQuestions: json["number_of_questions"],
        passingPercentage: json["passing_percentage"],
        totalMarks: json["total_marks"],
        assessmentValidityFrom: json["assessment_validity_from"],
        assessmentValidityTo: json["assessment_validity_to"],
        businessLogic: json["business_logic"],
        totalTimeQuestions: json["total_time_questions"],
        isPublished: json["isPublished"],
        isCreated: json["isCreated"],
        isactive: json["isactive"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "test_name": testName,
        "topic": topic,
        "specialisation": specialisation,
        "level": level,
        "instruction": instruction,
        "imgUrl": imgUrl,
        "mode": mode,
        "number_of_sections": numberOfSections,
        "number_of_questions": numberOfQuestions,
        "passing_percentage": passingPercentage,
        "total_marks": totalMarks,
        "assessment_validity_from": assessmentValidityFrom,
        "assessment_validity_to": assessmentValidityTo,
        "business_logic": businessLogic,
        "total_time_questions": totalTimeQuestions,
        "isPublished": isPublished,
        "isCreated": isCreated,
        "isactive": isactive,
      };
}

class Section {
  Section({
    this.id,
    this.index,
    this.assessmentId,
    this.sectionTitle,
    this.sectionInstruction,
    this.noOfQuestionInSection,
    this.sectionQuestionLevel,
    this.marksPerCorrect,
    this.marksPerIncorrectAnswer,
    this.isSelected,
    this.questions,
  });

  String id;
  int index;
  String assessmentId;
  String sectionTitle;
  String sectionInstruction;
  int noOfQuestionInSection;
  String sectionQuestionLevel;
  String marksPerCorrect;
  String marksPerIncorrectAnswer;
  bool isSelected;
  List<Question> questions;

  factory Section.fromJson(Map<String, dynamic> json) => Section(
        id: json["_id"],
        index: json["index"],
        assessmentId: json["assessment_id"],
        sectionTitle: json["section_title"],
        sectionInstruction: json["section_instruction"],
        noOfQuestionInSection: json["no_of_question_in_section"],
        sectionQuestionLevel: json["section_question_level"],
        marksPerCorrect: json["marks_per_correct"],
        marksPerIncorrectAnswer: json["marks_per_incorrect_answer"],
        isSelected: json["isSelected"],
        questions: List<Question>.from(
            json["questions"].map((x) => Question.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "index": index,
        "assessment_id": assessmentId,
        "section_title": sectionTitle,
        "section_instruction": sectionInstruction,
        "no_of_question_in_section": noOfQuestionInSection,
        "section_question_level": sectionQuestionLevel,
        "marks_per_correct": marksPerCorrect,
        "marks_per_incorrect_answer": marksPerIncorrectAnswer,
        "isSelected": isSelected,
        "questions": List<dynamic>.from(questions.map((x) => x.toJson())),
      };
}

class Question {
  Question({
    this.id,
    this.assessmentId,
    this.index,
    this.questionIndex,
    this.questionId,
    this.question,
    this.questionType,
    this.topic,
    this.specialisation,
    this.mcq,
  });

  String id;
  String assessmentId;
  int index;
  int questionIndex;
  String questionId;
  String question;
  String questionType;
  String topic;
  String specialisation;
  dynamic mcq;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        id: json["_id"],
        assessmentId: json["assessment_id"],
        index: json["index"],
        questionIndex: json["question_index"],
        questionId: json["question_id"],
        question: json["question"],
        questionType: json["question_type"],
        topic: json["topic"],
        specialisation: json["specialisation"],
        mcq: json["mcq"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "assessment_id": assessmentId,
        "index": index,
        "question_index": questionIndex,
        "question_id": questionId,
        "question": question,
        "question_type": questionType,
        "topic": topic,
        "specialisation": specialisation,
        "mcq": mcq,
      };
}

class McqElement {
  McqElement({
    this.answer,
    this.isanswer,
    this.isSelected,
  });

  String answer;
  bool isanswer;
  bool isSelected;

  factory McqElement.fromJson(Map<String, dynamic> json) => McqElement(
        answer: json["answer"],
        isanswer: json["isanswer"],
        isSelected: json["isSelected"],
      );

  Map<String, dynamic> toJson() => {
        "answer": answer,
        "isanswer": isanswer,
        "isSelected": isSelected,
      };
}
