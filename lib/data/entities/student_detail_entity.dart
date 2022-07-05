class StudentDetailEntity {
  String? sId;
  String? sName;
  String? gender;
  String? dob;
  String? email;
  String? sAddress;
  String? contact;
  String? deptId;
  int? classId;
  String? dName;
  String? semName;
  String? name;
  String? clsName;

  StudentDetailEntity(
      {this.sId,
      this.sName,
      this.gender,
      this.dob,
      this.email,
      this.sAddress,
      this.contact,
      this.deptId,
      this.classId,
      this.dName,
      this.semName,
      this.name,
      this.clsName});

  StudentDetailEntity.fromJson(Map<String, dynamic> json) {
    sId = json['s_id'];
    sName = json['s_name'];
    gender = json['gender'];
    dob = json['dob'];
    email = json['email'];
    sAddress = json['s_address'];
    contact = json['contact'];
    deptId = json['dept_id'];
    classId = json['class_id'];
    dName = json['d_name'];
    semName = json['sem_name'];
    name = json['name'];
    clsName = json['cls_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['s_id'] = this.sId;
    data['s_name'] = this.sName;
    data['gender'] = this.gender;
    data['dob'] = this.dob;
    data['email'] = this.email;
    data['s_address'] = this.sAddress;
    data['contact'] = this.contact;
    data['dept_id'] = this.deptId;
    data['class_id'] = this.classId;
    data['d_name'] = this.dName;
    data['sem_name'] = this.semName;
    data['name'] = this.name;
    data['cls_name'] = this.clsName;
    return data;
  }
}
