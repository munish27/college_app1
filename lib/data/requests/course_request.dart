class CourseRequest {
  String? dept_id;
  String? sem_id;
  String? staff_id;

  CourseRequest({this.dept_id, this.sem_id,this.staff_id});

  Map<String, String> toJson() {
    final Map<String, String> _data = Map<String, String>();
    if (dept_id != null && dept_id!.isNotEmpty) {
      _data['dept_id'] = dept_id!;
    }
    if (sem_id != null && sem_id!.isNotEmpty) {
      _data['sem_id'] = sem_id!;
    }
    if (staff_id != null && staff_id!.isNotEmpty) {
      _data['staff_id'] = staff_id!;
    }
    return _data;
  }
}
