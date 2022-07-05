import 'package:clg_app/data/entities/student_mark_entity.dart';

class StudentMarkListResponse {
  late int responseCode;
  late List<StudentMarkEntity> data;

  StudentMarkListResponse({required this.responseCode, required this.data});

  StudentMarkListResponse.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    if (json['data'] != null) {
      data = <StudentMarkEntity>[];
      json['data'].forEach((v) {
        data.add( StudentMarkEntity.fromJson(v));
      });
    }
  }
}

