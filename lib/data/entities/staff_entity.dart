class StaffEntity {
  late String stId;
  late String stName;
  String? email;
  String? contact;
  String? dName;
  String? semName;

  StaffEntity(
      {required this.stId,
      required this.stName,
      this.email,
      this.contact,
      this.dName,
      this.semName});

  StaffEntity.fromJson(Map<String, dynamic> json) {
    stId = json['st_id'];
    stName = json['st_name'];
    email = json['email'];
    contact = json['contact'];
    dName = json['d_name'];
    semName = json['sem_name'];
  }
}
