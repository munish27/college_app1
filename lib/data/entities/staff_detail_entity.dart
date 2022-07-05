class StaffDetailEntity {
  late String stId;
  late String stName;
  late String email;
  late String contact;
  late String dName;
   String? semName;
  late String stAddress;
  late String dob;
  late String gender;

  StaffDetailEntity({
    required this.stId,
    required this.stName,
    required this.email,
    required this.contact,
    required this.dName,
     this.semName,
    required this.stAddress,
    required this.dob,
    required this.gender,
  });

  StaffDetailEntity.fromJson(Map<String, dynamic> json) {
    stId = json['st_id'];
    stName = json['st_name'];
    email = json['email'];
    contact = json['contact'];
    dName = json['d_name'];
    semName = json['sem_name'];
    stAddress = json['st_address'];
    dob = json['dob'];
    gender = json['gender'];
  }
}
