class AddAttendanceRequest {
  String? classId;
  List<String>? students;

  AddAttendanceRequest({this.classId, this.students});

  AddAttendanceRequest.fromJson(Map<String, dynamic> json) {
    classId = json['class_id'];
    students = json['students'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['class_id'] = this.classId;
    data['students'] = this.students;
    return data;
  }
}
