class StudentRequest {
  String? dept_id;
  String? sem_id;
  String? class_id;
  String? staff_id;
  String? studentId;

  StudentRequest({this.dept_id, this.sem_id,this.staff_id,this.class_id,this.studentId});

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
    if (class_id != null && class_id!.isNotEmpty) {
      _data['class_id'] = class_id!;
    }
    if (studentId != null && studentId!.isNotEmpty) {
      _data['student_id'] = studentId!;
    }
    return _data;
  }
}
