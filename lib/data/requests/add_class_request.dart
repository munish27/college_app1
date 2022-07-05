class AddClassRequest {
  String? courseId;
  String? staffId;

  AddClassRequest({this.courseId, this.staffId});

  AddClassRequest.fromJson(Map<String, dynamic> json) {
    courseId = json['course_id'];
    staffId = json['staff_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['course_id'] = this.courseId;
    data['staff_id'] = this.staffId;
    return data;
  }
}
