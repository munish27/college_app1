class StudentExamMarkEntity {
  int? markId;
  int? score;
  String? exName;
  int? exTotal;
  String? clsName;
  String? dName;
  String? semName;
  String? name;

  StudentExamMarkEntity(
      {this.markId,
      this.score,
      this.exName,
      this.exTotal,
      this.clsName,
      this.dName,
      this.semName,
      this.name});

  StudentExamMarkEntity.fromJson(Map<String, dynamic> json) {
    markId = json['mark_id'];
    score = json['score'];
    exName = json['ex_name'];
    exTotal = json['ex_total'];
    clsName = json['cls_name'];
    dName = json['d_name'];
    semName = json['sem_name'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mark_id'] = this.markId;
    data['score'] = this.score;
    data['ex_name'] = this.exName;
    data['ex_total'] = this.exTotal;
    data['cls_name'] = this.clsName;
    data['d_name'] = this.dName;
    data['sem_name'] = this.semName;
    data['name'] = this.name;
    return data;
  }
}
