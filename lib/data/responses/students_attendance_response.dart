import 'package:clg_app/data/entities/students_attendance_entity.dart';

class StudentsAttendanceResponse {
  late int responseCode;
  late List<StudentsAttendanceEntity> data;

  StudentsAttendanceResponse({
    required this.responseCode,
    required this.data,
  });

  StudentsAttendanceResponse.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    if (json['data'] != null) {
      data = <StudentsAttendanceEntity>[];
      json['data'].forEach((v) {
        data!.add(StudentsAttendanceEntity.fromJson(v));
      });
    }
  }
}
