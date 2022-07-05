import 'package:clg_app/data/entities/department_entity.dart';
import 'package:clg_app/data/entities/exam_entity.dart';
import 'package:clg_app/data/entities/staff_detail_entity.dart';
import 'package:clg_app/data/entities/staff_entity.dart';
import 'package:clg_app/data/entities/student_entity.dart';
import 'package:clg_app/data/entities/students_attendance_entity.dart';
import 'package:clg_app/data/entities/teacher_class_entity.dart';
import 'package:flutter/foundation.dart';

import '../../../data/entities/course_entity.dart';
import '../../../data/remote/api_response.dart';
import '../../../data/repository.dart';

class AddAttendanceProvider extends ChangeNotifier {
  final Repository _repository = Repository();

  STATUS _status = STATUS.INITIAL;
  STATUS get status => _status;

  String? _errMsg;
  String? get errMsg => _errMsg;

  List<String> _absentStudents = [];
  List<String> get absentStudents => _absentStudents;

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

  Future<bool> addAttendance({
    required String classId,
  }) async {
    if (_status != STATUS.LOADING) {
      _status = STATUS.LOADING;

      notifyListeners();
      final _results = await _repository.addAttendance(
        classId: classId,
        students: _absentStudents,
      );
      if (_results.status == STATUS.ERROR) {
        _errMsg = _results.errMsg;
      }
      _status = _results.status;
      notifyListeners();
    }
    return _status == STATUS.SUCCESS ? true : false;
  }


  void addAbsentStudent(String studentId) {
    if (_absentStudents.contains(studentId)) {
      _absentStudents.remove(studentId);
    } else {
      _absentStudents.add(studentId);
    }
    notifyListeners();
  }
}
