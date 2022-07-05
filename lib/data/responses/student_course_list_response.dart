import 'package:clg_app/data/entities/student_course_entity.dart';

class StudentCourseListResponse {
  late int responseCode;
  late List<StudentCourseEntity> data;

  StudentCourseListResponse({required this.responseCode, required this.data});

  StudentCourseListResponse.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    if (json['data'] != null) {
      data = <StudentCourseEntity>[];
      json['data'].forEach((v) {
        data.add(StudentCourseEntity.fromJson(v));
      });
    }
  }
}
