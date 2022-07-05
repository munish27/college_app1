import 'package:clg_app/data/entities/exam_entity.dart';

class ExamListResponse {
  int? responseCode;
  List<ExamEntity>? data;

  ExamListResponse({this.responseCode, this.data});

  ExamListResponse.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    if (json['data'] != null) {
      data = <ExamEntity>[];
      json['data'].forEach((v) {
        data!.add(ExamEntity.fromJson(v));
      });
    }
  }
}
