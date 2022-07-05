class StudentMarkEntity {
  int? markId;
  int? score;
  String? exName;
  int? exTotal;
  String? sId;
  String? clsName;
  String? name;
  String? semName;
  String? dName;
  String? sName;

  StudentMarkEntity(
      {this.markId,
      this.score,
      this.exName,
      this.exTotal,
      this.sId,
      this.clsName,
      this.name,
      this.semName,
      this.dName,
      this.sName,
      });

  StudentMarkEntity.fromJson(Map<String, dynamic> json) {
    markId = json['mark_id'];
    score = json['score'];
    exName = json['ex_name'];
    exTotal = json['ex_total'];
    sId = json['s_id'];
    clsName = json['cls_name'];
    name = json['name'];
    semName = json['sem_name'];
    dName = json['d_name'];
    dName = json['s_name'];
  }
}
