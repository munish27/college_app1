import 'package:clg_app/data/entities/staff_entity.dart';

class AllStaffResponse {
  late int responseCode;
  late List<StaffEntity> data;

  AllStaffResponse({required this.responseCode, required this.data});

  AllStaffResponse.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    if (json['data'] != null) {
      data = <StaffEntity>[];
      json['data'].forEach((v) {
        data.add(StaffEntity.fromJson(v));
      });
    }
  }
}
