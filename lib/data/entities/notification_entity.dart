class NotificationEntity {
  late String title;
  late String description;
  late String link;

  NotificationEntity({required this.title, required this.description, required this.link});

  NotificationEntity.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['link'] = this.link;
    return data;
  }
}
