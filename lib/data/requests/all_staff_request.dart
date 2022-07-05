class AllStaffReuest {
  String? dept_id;
  String? sem_id;

  AllStaffReuest({this.dept_id, this.sem_id});

  Map<String, String> toJson() {
    final Map<String, String> _data = Map<String, String>();
    if (dept_id != null && dept_id!.isNotEmpty) {
      _data['dept_id'] = dept_id!;
    }
    if (sem_id != null && sem_id!.isNotEmpty) {
      _data['sem_id'] = sem_id!;
    }
    return _data;
  }
}
