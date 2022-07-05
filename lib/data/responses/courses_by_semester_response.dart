import 'package:clg_app/data/entities/course_entity.dart';

class CourseBySemesterResponse {
  late int responseCode;
  late List<CourseEntity> data;

  CourseBySemesterResponse({required this.responseCode, required this.data});

  CourseBySemesterResponse.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    if (json['data'] != null) {
      data = <CourseEntity>[];
      json['data'].forEach((v) {
        data.add(CourseEntity.fromJson(v));
      });
    }
  }
}
