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

class AssignCourseProvider extends ChangeNotifier {
  final Repository _repository = Repository();

  STATUS _status = STATUS.INITIAL;
  STATUS get status => _status;

  STATUS _staffStatus = STATUS.INITIAL;
  STATUS get staffStatus => _staffStatus;

  String? _errMsg;
  String? get errMsg => _errMsg;

  List<StaffEntity> _staff = [];
  List<StaffEntity> get staff => _staff;

  StaffEntity? _selectedStaff;
  StaffEntity? get selectedStaff => _selectedStaff;

  void getAllStaff(String deptId) async {
    if (_staffStatus != STATUS.LOADING) {
      _staffStatus = STATUS.LOADING;
      _staff.clear();
      notifyListeners();
      final _results = await _repository.getAllStaffList(
        deptId: deptId,
      );
      if (_results.status == STATUS.SUCCESS) {
        _staff.addAll(_results.data!.data);
      } else {
        _errMsg = _results.errMsg;
      }
      _staffStatus = _results.status;
      notifyListeners();
    }
  }

  Future<bool> addClass(String courseId) async {
    if (_status != STATUS.LOADING) {
      _status = STATUS.LOADING;
      _staff.clear();
      notifyListeners();
      final _results = await _repository.addClass(
        staffId: _selectedStaff!.stId,
        courseId: courseId,
      );
      if (_results.status == STATUS.SUCCESS) {
        _errMsg = _results.errMsg;
      }
      _status = _results.status;
      notifyListeners();
    }
            return _status == STATUS.SUCCESS ? true : false;

  }

  void selectStaff(StaffEntity _staff) {
    _selectedStaff = _staff;
    notifyListeners();
  }
}
