import 'package:clg_app/data/entities/exam_entity.dart';
import 'package:clg_app/data/entities/staff_detail_entity.dart';
import 'package:clg_app/data/entities/staff_entity.dart';
import 'package:clg_app/data/entities/student_course_entity.dart';
import 'package:clg_app/data/entities/student_detail_entity.dart';
import 'package:clg_app/data/entities/student_entity.dart';
import 'package:clg_app/data/entities/student_exam_mark_entity.dart';
import 'package:clg_app/data/entities/students_attendance_entity.dart';
import 'package:clg_app/data/entities/teacher_class_entity.dart';
import 'package:flutter/foundation.dart';

import '../../../data/entities/course_entity.dart';
import '../../../data/remote/api_response.dart';
import '../../../data/repository.dart';

class StudentAdminProvider extends ChangeNotifier {
  final Repository _repository = Repository();

  STATUS _status = STATUS.INITIAL;
  STATUS get status => _status;

  String? _errMsg;
  String? get errMsg => _errMsg;

  String? _resetLink;
  String? get resetLink => _resetLink;

  List<StudentEntity> _students = [];
  List<StudentEntity> get students => _students;

  List<StudentCourseEntity> _courses = [];
  List<StudentCourseEntity> get courses => _courses;

  List<StudentExamMarkEntity> _marks = [];
  List<StudentExamMarkEntity> get marks => _marks;

  StudentDetailEntity? _studentInfo;
  StudentDetailEntity? get studentInfo => _studentInfo;

  List<StudentsAttendanceEntity> _attendance = [];
  List<StudentsAttendanceEntity> get attendance => _attendance;

  void getStudents() async {
    if (_status != STATUS.LOADING) {
      _status = STATUS.LOADING;
      _students.clear();
      notifyListeners();
      final _results = await _repository.getAllStudents();
      if (_results.status == STATUS.SUCCESS) {
        _students.addAll(_results.data!.data);
      } else {
        _errMsg = _results.errMsg;
      }

      _status = _results.status;
      notifyListeners();
    }
  }

  void getStudent(String studentId) async {
    if (_status != STATUS.LOADING) {
      _status = STATUS.LOADING;
      notifyListeners();
      final _results = await _repository.getStudentInfo(studentId: studentId);
      if (_results.status == STATUS.SUCCESS) {
        _studentInfo = _results.data!.data!.first;
      } else {
        _errMsg = _results.errMsg;
      }

      _status = _results.status;
      notifyListeners();
    }
  }

  void getCourses(String studentId) async {
    if (_status != STATUS.LOADING) {
      _status = STATUS.LOADING;
      _courses.clear();
      notifyListeners();
      final _results = await _repository.getStudentCourse(studentId);
      if (_results.status == STATUS.SUCCESS) {
        _courses.addAll(_results.data!.data);
      } else {
        _errMsg = _results.errMsg;
      }

      _status = _results.status;
      notifyListeners();
    }
  }

  void getMarks({
    required String studentId,
    required String courseid,
  }) async {
    if (_status != STATUS.LOADING) {
      _status = STATUS.LOADING;
      _marks.clear();
      notifyListeners();
      final _results = await _repository.getStudentMarks(
          courseId: courseid, studentId: studentId);
      if (_results.status == STATUS.SUCCESS) {
        _marks.addAll(_results.data!.data);
      } else {
        _errMsg = _results.errMsg;
      }

      _status = _results.status;
      notifyListeners();
    }
  }

  void getAttendance({
    required String courseId,
    required String studentId,
  }) async {
    if (_status != STATUS.LOADING) {
      _status = STATUS.LOADING;
      _attendance.clear();
      notifyListeners();
      final _results = await _repository.getStudentAttendance(
        course_id: courseId,
        studentId: studentId,
      );
      if (_results.status == STATUS.SUCCESS) {
        _attendance.addAll(_results.data!.data);
      } else {
        _errMsg = _results.errMsg;
      }

      _status = _results.status;
      notifyListeners();
    }
  }

  Future<String?> resetPassword() async {
    if (_status != STATUS.LOADING) {
      _status = STATUS.LOADING;
      _attendance.clear();
      notifyListeners();
      final _results = await _repository.resetPassword();
      if (_results.status == STATUS.SUCCESS) {
        _resetLink = _results.data!.message;
      } else if (_results.status == STATUS.ERROR) {
        _errMsg = _results.errMsg;
      }
      _status = _results.status;
      notifyListeners();
      return _resetLink;
    }
  }
}
