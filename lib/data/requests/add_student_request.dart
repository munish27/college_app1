class AddStudentRequest {
  String? email;
  String? dob;
  String? name;
  String? gender;
  String? department;
  String? address;
  String? city;
  String? postalCode;
  String? contact;
  String? classId;

  AddStudentRequest(
      {this.email,
      this.dob,
      this.name,
      this.gender,
      this.department,
      this.address,
      this.city,
      this.postalCode,
      this.contact,
      this.classId});

  AddStudentRequest.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    dob = json['dob'];
    name = json['name'];
    gender = json['gender'];
    department = json['department'];
    address = json['address'];
    city = json['city'];
    postalCode = json['postalCode'];
    contact = json['contact'];
    classId = json['class_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['dob'] = this.dob;
    data['name'] = this.name;
    data['gender'] = this.gender;
    data['department'] = this.department;
    data['address'] = this.address;
    data['city'] = this.city;
    data['postalCode'] = this.postalCode;
    data['contact'] = this.contact;
    data['class_id'] = this.classId;
    return data;
  }
}
