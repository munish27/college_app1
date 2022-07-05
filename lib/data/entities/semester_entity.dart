class SemesterEntity {
  late String sem_id;
  late String sem_name;

  SemesterEntity({required this.sem_id, required this.sem_name});

  SemesterEntity.fromJson(Map<String, dynamic> json) {
    sem_id = json['sem_id'];
    sem_name = json['sem_name'];
  }
}
