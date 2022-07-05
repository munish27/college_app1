import 'package:clg_app/data/entities/course_entity.dart';
import 'package:clg_app/data/entities/department_entity.dart';
import 'package:clg_app/data/entities/semester_entity.dart';
import 'package:clg_app/data/entities/teacher_class_entity.dart';
import 'package:clg_app/data/remote/api_response.dart';
import 'package:clg_app/data/repository.dart';
import 'package:flutter/foundation.dart';

class AddStudentProvider extends ChangeNotifier {
  final Repository _repository = Repository();

  STATUS _status = STATUS.INITIAL;
  STATUS get status => _status;

  String? _errMsg;
  String? get errMsg => _errMsg;

  List<DepartmentEnity> _departments = [];
  List<DepartmentEnity> get departments => _departments;

  List<CourseEntity> _courses = [];
  List<CourseEntity> get courses => _courses;

  List<TeacherClassEntity> _classes = [];
  List<TeacherClassEntity> get classes => _classes;

  List<String> _genders = ['Male', 'Female'];
  List<String> get genders => _genders;

  DepartmentEnity? _selectedDept;
  DepartmentEnity? get selectedDept => _selectedDept;

  CourseEntity? _selectedCourse;
  CourseEntity? get selectedCourse => _selectedCourse;

  TeacherClassEntity? _selectedClass;
  TeacherClassEntity? get selectedClass => _selectedClass;

  String? _selectedGender;
  String? get selectedGender => _selectedGender;

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

  void getAllCourses(String deptId) async {
    if (_status != STATUS.LOADING) {
      _status = STATUS.LOADING;
      _courses.clear();
      _selectedCourse = null;
      _selectedClass = null;
      notifyListeners();
      final _results = await _repository.getAllCourse(deptId, '', '');
      if (_results.status == STATUS.SUCCESS) {
        _courses.addAll(_results.data!.data);
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

  void selectedDepartment(DepartmentEnity _dept) {
    _selectedDept = _dept;
    notifyListeners();
    getAllCourses(_selectedDept!.dept_id);
  }

  void selectGender(String _gender) {
    _selectedGender = _gender;
    notifyListeners();
  }

  void selectCourse(CourseEntity _course) {
    _selectedCourse = _course;
    notifyListeners();
    getClasses(courseId: _course.cId);
  }

  void selectClass(TeacherClassEntity _class) {
    _selectedClass = _class;
    notifyListeners();
  }

  void addStudent({
    required String email,
    required String dob,
    required String name,
    required String address,
    required String city,
    required String postalCode,
    required String contact,
  }) async {
    if (_status != STATUS.LOADING) {
      _status = STATUS.LOADING;
      notifyListeners();
      final _results = await _repository.addStudent(
        email: email,
        dob: dob,
        name: name,
        gender: _selectedGender ?? 'Male',
        department: _selectedDept!.dept_id,
        address: address,
        city: city,
        postalCode: postalCode,
        contact: contact,
        classId: _selectedClass!.classId.toString(),
      );
      if (_results.status == STATUS.ERROR) {
        _errMsg = _results.errMsg;
      }
      _status = _results.status;
      notifyListeners();
    }
  }
}
