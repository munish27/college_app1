class AddSemesterRequest {
  late String semId;
  late String semester;

  AddSemesterRequest({required this.semId, required this.semester});

  Map<String, String> toJson() {
    final Map<String,String> _data = Map<String, String>();
    _data['semester'] = semester;
    _data['semId'] = semId;
    return _data;
  }
}
