class AddDepartmentRequest {
  late String dept_id;
  late String dept_name;

  AddDepartmentRequest({required this.dept_id, required this.dept_name});

  Map<String, String> toJson() {
    final Map<String,String> _data = Map<String, String>();
    _data['department'] = dept_name;
    _data['deptId'] = dept_id;
    return _data;
  }
}
