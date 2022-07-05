import 'package:clg_app/data/entities/teacher_class_entity.dart';

class ClassByStaffResponse {
  late int responseCode;
  late List<TeacherClassEntity> data;

  ClassByStaffResponse({required this.responseCode, required this.data});

  ClassByStaffResponse.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    if (json['data'] != null) {
      data = <TeacherClassEntity>[];
      json['data'].forEach((v) {
        data.add(TeacherClassEntity.fromJson(v));
      });
    }
  }
}
