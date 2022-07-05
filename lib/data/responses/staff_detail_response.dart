import 'package:clg_app/data/entities/staff_detail_entity.dart';

class StaffDetailResponse {
  late int responseCode;
  late StaffDetailEntity data;

  StaffDetailResponse({required this.responseCode, required this.data});

  StaffDetailResponse.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    if (json['data'] != null) {
      data = StaffDetailEntity.fromJson(json['data']);
    }
  }
}
