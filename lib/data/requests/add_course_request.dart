class AddCourseRequest {
  late String name;
  late String dept_id;
  late String sem_id;

  AddCourseRequest({required this.dept_id, required this.name,required this.sem_id});

  Map<String, String> toJson() {
    final Map<String,String> _data = Map<String, String>();
    _data['department'] = dept_id;
    _data['semester'] = sem_id;
    _data['course'] = name;
    return _data;
  }
}
