import 'package:clg_app/data/entities/department_entity.dart';
import 'package:clg_app/data/entities/exam_entity.dart';
import 'package:clg_app/data/entities/staff_detail_entity.dart';
import 'package:clg_app/data/entities/staff_entity.dart';
import 'package:clg_app/data/entities/student_entity.dart';
import 'package:clg_app/data/entities/students_attendance_entity.dart';
import 'package:clg_app/data/entities/teacher_class_entity.dart';
import 'package:clg_app/data/requests/add_mark_request.dart';
import 'package:flutter/foundation.dart';

import '../../../data/entities/course_entity.dart';
import '../../../data/remote/api_response.dart';
import '../../../data/repository.dart';

class AddMarksProvider extends ChangeNotifier {
  final Repository _repository = Repository();

  STATUS _status = STATUS.INITIAL;
  STATUS get status => _status;

  String? _errMsg;
  String? get errMsg => _errMsg;

  List<Marks> _marks = [];
  List<Marks> get marks => _marks;

  List<StudentEntity> _students = [];
  List<StudentEntity> get students => _students;

  void getStudents(String classId) async {
    if (_status != STATUS.LOADING) {
      _status = STATUS.LOADING;
      students.clear();
      notifyListeners();
      final _results = await _repository.getAllStudents(classId: classId);
      if (_results.status == STATUS.SUCCESS) {
        _students.addAll(_results.data!.data);
      } else {
        _errMsg = _results.errMsg;
      }
      _status = _results.status;
      notifyListeners();
    }
  }

  Future<bool> uploadMarks({
    required String classId,
    required String examId,
  }) async {
    if (_status != STATUS.LOADING) {
      _status = STATUS.LOADING;

      notifyListeners();
      final _results = await _repository.addExamMark(
        classId: classId,
        examId: int.parse(examId),
        marks: _marks,
      );
      if (_results.status == STATUS.ERROR) {
        _errMsg = _results.errMsg;
      }
      _status = _results.status;
      notifyListeners();
    }
    return _status == STATUS.SUCCESS ? true : false;
  }

  void addStudentMarks(Marks _mark) {
    if (_marks.isEmpty ||
        _marks.firstWhere((element) => element.sId == _mark.sId) == null) {
      _marks.add(_mark);
      notifyListeners();
    } else {
      if (_marks.remove(_mark)) {
        _marks.add(_mark);
        notifyListeners();
      }
    }
  }
}
