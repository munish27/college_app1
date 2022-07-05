class TeacherClassEntity {
  late int classId;
  late String year;
  late String clsName;
  late String name;
  late String dName;
  late String semName;

  TeacherClassEntity({
    required this.classId,
    required this.year,
    required this.clsName,
    required this.name,
    required this.dName,
    required this.semName,
  });

  TeacherClassEntity.fromJson(Map<String, dynamic> json) {
    classId = json['class_id'];
    year = json['year'];
    clsName = json['cls_name'];
    name = json['name'];
    dName = json['d_name'];
    semName = json['sem_name'];
  }

}
