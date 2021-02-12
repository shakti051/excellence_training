class CompetitionModel {
  int status;
  List<CompetitionData> data;
  String message;

  CompetitionModel({this.status, this.data, this.message});

  CompetitionModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = new List<CompetitionData>();
      json['data'].forEach((v) {
        data.add(new CompetitionData.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class CompetitionData {
  String competitionName;
  int startDate;
  int endDate;
  int competitionDate;
  int totalNumEntries;
  int status;
  String banner;
  List<Winner> winner;

  CompetitionData(
      {this.competitionName,
        this.startDate,
        this.endDate,
        this.competitionDate,
        this.totalNumEntries,
        this.status,
        this.banner,
        this.winner});

  CompetitionData.fromJson(Map<String, dynamic> json) {
    competitionName = json['competitionName'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    competitionDate = json['competitionDate'];
    totalNumEntries = json['totalNumEntries'];
    status = json['status'];
    banner = json['banner'];
    if (json['winner'] != null) {
      winner = new List<Winner>();
      json['winner'].forEach((v) {
        winner.add(new Winner.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['competitionName'] = this.competitionName;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['competitionDate'] = this.competitionDate;
    data['totalNumEntries'] = this.totalNumEntries;
    data['status'] = this.status;
    data['banner'] = this.banner;
    if (this.winner != null) {
      data['winner'] = this.winner.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Winner {
  String name;
  String title;
  String photo;

  Winner({this.name, this.title, this.photo});

  Winner.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    title = json['title'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['title'] = this.title;
    data['photo'] = this.photo;
    return data;
  }
}
