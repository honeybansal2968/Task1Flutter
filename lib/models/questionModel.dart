class QuestionModel {
  String? id;
  String? categoryid;
  String? questiontitle;
  String? ansertype;
  String? optionlist;
  String? status;
  String? compulsory;
  String? displayid;
  String? createdAt;
  String? updatedAt;
  String? remark;

  QuestionModel(
      {this.id,
      this.categoryid,
      this.questiontitle,
      this.ansertype,
      this.optionlist,
      this.status,
      this.compulsory,
      this.displayid,
      this.createdAt,
      this.updatedAt,
      this.remark});

  QuestionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryid = json['categoryid'];
    questiontitle = json['questiontitle'];
    ansertype = json['ansertype'];
    optionlist = json['optionlist'];
    status = json['status'];
    compulsory = json['compulsory'];
    displayid = json['displayid'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    remark = json['remark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['categoryid'] = this.categoryid;
    data['questiontitle'] = this.questiontitle;
    data['ansertype'] = this.ansertype;
    data['optionlist'] = this.optionlist;
    data['status'] = this.status;
    data['compulsory'] = this.compulsory;
    data['displayid'] = this.displayid;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['remark'] = this.remark;
    return data;
  }
}
