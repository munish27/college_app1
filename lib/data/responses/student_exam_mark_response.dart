import 'package:clg_app/data/entities/student_exam_mark_entity.dart';

class StudentExamMarkResponses {
  late int responseCode;
  late List<StudentExamMarkEntity> data;

  StudentExamMarkResponses({required this.responseCode, required this.data});

  StudentExamMarkResponses.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    if (json['data'] != null) {
      data = <StudentExamMarkEntity>[];
      json['data'].forEach((v) {
        data.add(StudentExamMarkEntity.fromJson(v));
      });
    }
  }
}
