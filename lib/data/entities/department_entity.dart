class DepartmentEnity {
  late String dept_id;
  late String dept_name;

  DepartmentEnity({required this.dept_id, required this.dept_name});

  DepartmentEnity.fromJson(Map<String, dynamic> json) {
    dept_id = json['dept_id'];
    dept_name = json['d_name'];
  }
}
