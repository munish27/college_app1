class CourseEntity {
  late String name;
  late String cId;
  late String semName;
  late String dName;
   String? stName;

  CourseEntity({required this.name, required this.cId, required this.semName, required this.dName, required this.stName});

  CourseEntity.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    cId = json['c_id'];
    semName = json['sem_name'];
    dName = json['d_name'];
    stName = json['st_name'];
  }
}