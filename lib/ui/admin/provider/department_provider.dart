import 'package:clg_app/data/entities/course_entity.dart';
import 'package:clg_app/data/entities/department_entity.dart';
import 'package:clg_app/data/entities/semester_entity.dart';
import 'package:clg_app/data/remote/api_response.dart';
import 'package:clg_app/data/repository.dart';
import 'package:flutter/foundation.dart';

class DepartmentProvider extends ChangeNotifier {
  final Repository _repository = Repository();

  STATUS _status = STATUS.INITIAL;
  STATUS get status => _status;

  String? _errMsg;
  String? get errMsg => _errMsg;

  List<DepartmentEnity> _departments = [];
  List<DepartmentEnity> get departments => _departments;

  List<SemesterEntity> _semesters = [];
  List<SemesterEntity> get semesters => _semesters;

  List<CourseEntity> _courses = [];
  List<CourseEntity> get courses => _courses;

  void getAllDepartments() async {
    if (_status != STATUS.LOADING) {
      _status = STATUS.LOADING;
      _departments.clear();
      notifyListeners();
      final _results = await _repository.getAllDepartments();
      if (_results.status == STATUS.SUCCESS) {
        _departments.addAll(_results.data!.data);
      } else {
        _errMsg = _results.errMsg;
      }
      _status = _results.status;
      notifyListeners();
    }
  }

  Future<bool> addDepartment(String dept_name, String dept_id) async {
    if (_status != STATUS.LOADING) {
      _status = STATUS.LOADING;
      notifyListeners();
      final _results = await _repository.addDepartment(dept_name, dept_id);
      if (_results.status == STATUS.ERROR) {
        _errMsg = _results.errMsg;
      }
      _status = _results.status;
      notifyListeners();
    }
        return _status == STATUS.SUCCESS ? true : false;

  }

  void getAllSemesters() async {
    if (_status != STATUS.LOADING) {
      _status = STATUS.LOADING;
      _semesters.clear();
      notifyListeners();
      final _results = await _repository.getAllSemesters();
      if (_results.status == STATUS.SUCCESS) {
        _semesters.addAll(_results.data!.data);
      } else {
        _errMsg = _results.errMsg;
      }
      _status = _results.status;
      notifyListeners();
    }
  }

  Future<bool> addSemester(int sem) async {
    if (_status != STATUS.LOADING) {
      _status = STATUS.LOADING;
      notifyListeners();
      final _results = await _repository.addSemester(sem);
      if (_results.status == STATUS.ERROR) {
        _errMsg = _results.errMsg;
      }
      _status = _results.status;
      notifyListeners();
    }
        return _status == STATUS.SUCCESS ? true : false;

  }

  void getAllCourses(String deptId, String semId) async {
    if (_status != STATUS.LOADING) {
      _status = STATUS.LOADING;
      _courses.clear();
      notifyListeners();
      final _results = await _repository.getAllCourse(deptId, semId, '');
      if (_results.status == STATUS.SUCCESS) {
        _courses.addAll(_results.data!.data);
      } else {
        _errMsg = _results.errMsg;
      }
      _status = _results.status;
      notifyListeners();
    }
  }

  Future<bool> addCourse({
    required String name,
    required String deptId,
    required String semId,
  }) async {
    if (_status != STATUS.LOADING) {
      _status = STATUS.LOADING;
      notifyListeners();
      final _results =
          await _repository.addCourse(name: name, deptId: deptId, semId: semId);
      if (_results.status == STATUS.ERROR) {
        _errMsg = _results.errMsg;
      }
      _status = _results.status;
      notifyListeners();
    }
    return _status == STATUS.SUCCESS ? true : false;
  }
}
