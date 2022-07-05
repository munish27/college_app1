import 'package:clg_app/data/entities/student_detail_entity.dart';

class StudentDetailResponse {
  int? responseCode;
  List<StudentDetailEntity>? data;

  StudentDetailResponse({this.responseCode, this.data});

  StudentDetailResponse.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    if (json['data'] != null) {
      data = <StudentDetailEntity>[];
      json['data'].forEach((v) {
        data!.add(StudentDetailEntity.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response_code'] = this.responseCode;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
