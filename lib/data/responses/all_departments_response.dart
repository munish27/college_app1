import 'package:clg_app/data/entities/department_entity.dart';

class AllDepartmentResponse {
  late int responseCode;
  late List<DepartmentEnity> data;

  AllDepartmentResponse({required this.responseCode, required this.data});

  AllDepartmentResponse.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    if (json['data'] != null) {
      data = <DepartmentEnity>[];
      json['data'].forEach((v) {
        data.add(DepartmentEnity.fromJson(v));
      });
    }
  }
}
