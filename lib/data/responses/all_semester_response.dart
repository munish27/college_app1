import 'package:clg_app/data/entities/semester_entity.dart';

class AllSemesterResponse {
  late int responseCode;
  late List<SemesterEntity> data;

  AllSemesterResponse({required this.responseCode, required this.data});

  AllSemesterResponse.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    if (json['data'] != null) {
      data = <SemesterEntity>[];
      json['data'].forEach((v) {
        data.add(SemesterEntity.fromJson(v));
      });
    }
  }
}
