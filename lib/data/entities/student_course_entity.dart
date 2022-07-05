class StudentCourseEntity {
  late String name;
  late String cId;
  late String staffId;

  StudentCourseEntity({required this.name, required this.cId});

  StudentCourseEntity.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    cId = json['c_id'];
    staffId = json['st_id'];
  }
}
