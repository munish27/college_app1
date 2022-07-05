class StudentEntity {
  late String sId;
  late String sName;
  late String email;
  late String contact;
  late String dName;
  late String semName;
  late String clsName;

  StudentEntity(
      {required this.sId,
      required this.sName,
      required this.email,
      required this.contact,
      required this.dName,
      required this.semName,
      required this.clsName});

  StudentEntity.fromJson(Map<String, dynamic> json) {
    sId = json['s_id'];
    sName = json['s_name'];
    email = json['email'];
    contact = json['contact'];
    dName = json['d_name'];
    semName = json['sem_name'];
    clsName = json['cls_name'];
  }
}
