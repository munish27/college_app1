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

class AddStaffProvider extends ChangeNotifier {
  final Repository _repository = Repository();

  STATUS _status = STATUS.INITIAL;
  STATUS get status => _status;

  String? _errMsg;
  String? get errMsg => _errMsg;

  List<DepartmentEnity> _departments = [];
  List<DepartmentEnity> get departments => _departments;

  List<String> _genders = ['Male', 'Female'];
  List<String> get genders => _genders;

  DepartmentEnity? _selectedDept;
  DepartmentEnity? get selectedDept => _selectedDept;

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

  Future<bool> addStaff(
      {required String email,
      required String dob,
      required String name,
      required String address,
      required String city,
      required String postalCode,
      required String contact}) async {
    if (_status != STATUS.LOADING) {
      _status = STATUS.LOADING;
      _departments.clear();
      notifyListeners();
      final _results = await _repository.addStaff(
          email: email,
          dob: dob,
          name: name,
          gender: _selectedGender??'Male',
          department: _selectedDept!.dept_id,
          address: address,
          city: city,
          postalCode: postalCode,
          contact: contact);
      if (_results.status == STATUS.ERROR) {
        _errMsg = _results.errMsg;
      }
      _status = _results.status;
      notifyListeners();
    }
            return _status == STATUS.SUCCESS ? true : false;

  }

  void selectedDepartment(DepartmentEnity _dept) {
    _selectedDept = _dept;
    notifyListeners();
  }

  void selectGender(String _gender) {
    _selectedGender = _gender;
    notifyListeners();
  }
}
