import 'package:clg_app/data/entities/student_entity.dart';

class StudentListResponse {
  late int responseCode;
  late List<StudentEntity> data;

  StudentListResponse({required this.responseCode, required this.data});

  StudentListResponse.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    if (json['data'] != null) {
      data = <StudentEntity>[];
      json['data'].forEach((v) {
        data.add(StudentEntity.fromJson(v));
      });
    }
  }
}
