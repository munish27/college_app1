import 'package:clg_app/data/entities/exam_entity.dart';
import 'package:clg_app/data/entities/staff_detail_entity.dart';
import 'package:clg_app/data/entities/staff_entity.dart';
import 'package:clg_app/data/entities/student_entity.dart';
import 'package:clg_app/data/entities/student_mark_entity.dart';
import 'package:clg_app/data/entities/students_attendance_entity.dart';
import 'package:clg_app/data/entities/teacher_class_entity.dart';
import 'package:flutter/foundation.dart';

import '../../../data/entities/course_entity.dart';
import '../../../data/remote/api_response.dart';
import '../../../data/repository.dart';

class TeacherProvider extends ChangeNotifier {
  final Repository _repository = Repository();

  STATUS _status = STATUS.INITIAL;
  STATUS get status => _status;

  String? _errMsg;
  String? get errMsg => _errMsg;

  String? _resetLink;
  String? get resetLink => _resetLink;

  List<StaffEntity> _staff = [];
  List<StaffEntity> get staff => _staff;

  StaffDetailEntity? _staffInfo;
  StaffDetailEntity? get staffInfo => _staffInfo;

  List<CourseEntity> _courses = [];
  List<CourseEntity> get courses => _courses;

  List<TeacherClassEntity> _classes = [];
  List<TeacherClassEntity> get classes => _classes;

  List<StudentEntity> _students = [];
  List<StudentEntity> get students => _students;

  List<StudentsAttendanceEntity> _attendance = [];
  List<StudentsAttendanceEntity> get attendance => _attendance;

  List<ExamEntity> _exams = [];
  List<ExamEntity> get exams => _exams;

  List<StudentMarkEntity> _marks = [];
  List<StudentMarkEntity> get marks => _marks;

  void getAllStaff() async {
    if (_status != STATUS.LOADING) {
      _status = STATUS.LOADING;
      _staff.clear();
      notifyListeners();
      final _results = await _repository.getAllStaffList();
      if (_results.status == STATUS.SUCCESS) {
        _staff.addAll(_results.data!.data);
      } else {
        _errMsg = _results.errMsg;
      }
      _status = _results.status;
      notifyListeners();
    }
  }

  void getStaffInfo(String staffId) async {
    if (_status != STATUS.LOADING) {
      _status = STATUS.LOADING;
      _staffInfo = null;
      notifyListeners();
      final _results = await _repository.getStaffInfo(staffId);
      if (_results.status == STATUS.SUCCESS) {
        _staffInfo = _results.data!.data;
      } else {
        _errMsg = _results.errMsg;
      }
      _status = _results.status;
      notifyListeners();
    }
  }

  void getStaffCourses(String staffId) async {
    if (_status != STATUS.LOADING) {
      _status = STATUS.LOADING;
      _courses.clear();
      notifyListeners();
      final _results = await _repository.getAllCourse('', '', staffId);
      if (_results.status == STATUS.SUCCESS) {
        _courses = _results.data!.data;
      } else {
        _errMsg = _results.errMsg;
      }
      _status = _results.status;
      notifyListeners();
    }
  }

  void getClasses({String? staffId, String? courseId}) async {
    if (_status != STATUS.LOADING) {
      _status = STATUS.LOADING;
      _classes.clear();
      notifyListeners();
      final _results = await _repository.getClassListByStaff(
        staffId: staffId,
        courseId: courseId,
      );
      if (_results.status == STATUS.SUCCESS) {
        _classes.addAll(_results.data!.data);
      } else {
        _errMsg = _results.errMsg;
      }
      _status = _results.status;
      notifyListeners();
    }
  }

  void getStudents({
    String? deptId,
    String? semId,
    String? staffIf,
    String? classId,
  }) async {
    if (_status != STATUS.LOADING) {
      _status = STATUS.LOADING;
      _students.clear();
      notifyListeners();
      final _results = await _repository.getAllStudents(
        deptId: deptId,
        semId: semId,
        staffIf: staffIf,
        classId: classId,
      );
      if (_results.status == STATUS.SUCCESS) {
        _students.addAll(_results.data!.data);
      } else {
        _errMsg = _results.errMsg;
      }

      _status = _results.status;
      notifyListeners();
    }
  }

  void getAttendance({
    String? date,
    String? classId,
    String? courseId,
  }) async {
    if (_status != STATUS.LOADING) {
      _status = STATUS.LOADING;
      _attendance.clear();
      notifyListeners();
      final _results = await _repository.getStudentAttendance(
        class_id: classId,
        course_id: courseId,
        date: date,
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

  void getExams({
    String? courseId,
  }) async {
    if (_status != STATUS.LOADING) {
      _status = STATUS.LOADING;
      _exams.clear();
      notifyListeners();
      final _results = await _repository.getExamByStaff(
        course_id: courseId,
      );
      if (_results.status == STATUS.SUCCESS) {
        _exams.addAll(_results.data!.data!);
      } else {
        _errMsg = _results.errMsg;
      }

      _status = _results.status;
      notifyListeners();
    }
  }

  Future<bool> addExam({
    required String courseId,
    required String examName,
    required int total,
  }) async {
    if (_status != STATUS.LOADING) {
      _status = STATUS.LOADING;

      notifyListeners();
      final _results = await _repository.addExam(
          courseId: courseId, examName: examName, total: total);
      if (_results.status == STATUS.ERROR) {
        _errMsg = _results.errMsg;
      }

      _status = _results.status;
      notifyListeners();
    }
    return _status == STATUS.SUCCESS ? true : false;
  }

  void getMarks({
    required String classId,
    required String examId,
  }) async {
    if (_status != STATUS.LOADING) {
      _status = STATUS.LOADING;
      _marks.clear();
      notifyListeners();
      final _results = await _repository.getMarks(
        class_id: classId,
        exam_id: examId,
      );
      if (_results.status == STATUS.SUCCESS) {
        _marks.addAll(_results.data!.data);
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

  Future<bool> editMark({
    required String markId,
    required String mark,
  }) async {
    if (_status != STATUS.LOADING) {
      _status = STATUS.LOADING;
      notifyListeners();
      final _results =
          await _repository.updateMark(markId: markId, marks: mark);
      if (_results.status == STATUS.ERROR) {
        _errMsg = _results.errMsg;
      }
      _status = _results.status;
      notifyListeners();
    }
    return _status == STATUS.SUCCESS ? true : false;
  }

  Future<bool> editAttendance({
    required String attendanceId,
    required int attendance,
  }) async {
    if (_status != STATUS.LOADING) {
      _status = STATUS.LOADING;

      notifyListeners();
      final _results = await _repository.updateAttendance(
          attendanceId: attendanceId, attendance: attendance);
      if (_results.status == STATUS.ERROR) {
        _errMsg = _results.errMsg;
      }
      _status = _results.status;
      notifyListeners();
    }
    return _status == STATUS.SUCCESS ? true : false;
  }
}
