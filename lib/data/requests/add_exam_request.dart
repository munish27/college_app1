class AddExamRequest {
  String? courseId;
  String? name;
  int? total;

  AddExamRequest({this.courseId, this.name, this.total});

  AddExamRequest.fromJson(Map<String, dynamic> json) {
    courseId = json['course_id'];
    name = json['name'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['course_id'] = this.courseId;
    data['name'] = this.name;
    data['total'] = this.total;
    return data;
  }
}
