class AddMarkRequest {
  String? classId;
  int? examId;
  List<Marks>? marks;

  AddMarkRequest({this.classId, this.examId, this.marks});

  AddMarkRequest.fromJson(Map<String, dynamic> json) {
    classId = json['class_id'];
    examId = json['exam_id'];
    if (json['marks'] != null) {
      marks = <Marks>[];
      json['marks'].forEach((v) {
        marks!.add(new Marks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['class_id'] = this.classId;
    data['exam_id'] = this.examId;
    if (this.marks != null) {
      data['marks'] = this.marks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Marks {
  String? sId;
  int? marks;

  Marks({this.sId, this.marks});

  Marks.fromJson(Map<String, dynamic> json) {
    sId = json['s_id'];
    marks = json['marks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['s_id'] = this.sId;
    data['marks'] = this.marks;
    return data;
  }
}
