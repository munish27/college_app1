class ExamEntity {
  int? exId;
  String? cId;
  String? exName;
  int? exTotal;

  ExamEntity({this.exId, this.cId, this.exName, this.exTotal});

  ExamEntity.fromJson(Map<String, dynamic> json) {
    exId = json['ex_id'];
    cId = json['c_id'];
    exName = json['ex_name'];
    exTotal = json['ex_total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ex_id'] = this.exId;
    data['c_id'] = this.cId;
    data['ex_name'] = this.exName;
    data['ex_total'] = this.exTotal;
    return data;
  }
}