class StudentsAttendanceEntity {
  int? attendance;
  int? atId;
  String? date;
  String? sName;
  String? clsName;
  String? name;
  String? dName;
  String? semName;

  StudentsAttendanceEntity(
      {this.attendance,
      this.atId,
      this.date,
      this.sName,
      this.clsName,
      this.name,
      this.dName,
      this.semName});

  StudentsAttendanceEntity.fromJson(Map<String, dynamic> json) {
    attendance = json['attendance'];
    atId = json['at_id'];
    date = json['date'];
    sName = json['s_name'];
    clsName = json['cls_name'];
    name = json['name'];
    dName = json['d_name'];
    semName = json['sem_name'];
  }

}