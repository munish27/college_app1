import 'dart:io';
import 'package:path/path.dart';

import 'package:clg_app/core/my_preference.dart';
import 'package:clg_app/data/entities/notification_entity.dart';
import 'package:clg_app/data/remote/api_response.dart';
import 'package:clg_app/data/remote/remote_data_source.dart';
import 'package:clg_app/data/requests/add_attendance_request.dart';
import 'package:clg_app/data/requests/add_course_request.dart';
import 'package:clg_app/data/requests/add_department_request.dart';
import 'package:clg_app/data/requests/add_exam_request.dart';
import 'package:clg_app/data/requests/add_mark_request.dart';
import 'package:clg_app/data/requests/add_semester_request.dart';
import 'package:clg_app/data/requests/add_staff_request.dart';
import 'package:clg_app/data/requests/add_student_request.dart';
import 'package:clg_app/data/requests/all_staff_request.dart';
import 'package:clg_app/data/requests/course_request.dart';
import 'package:clg_app/data/requests/login_request.dart';
import 'package:clg_app/data/requests/student_request.dart';
import 'package:clg_app/data/responses/all_departments_response.dart';
import 'package:clg_app/data/responses/all_notification_response.dart';
import 'package:clg_app/data/responses/all_semester_response.dart';
import 'package:clg_app/data/responses/all_staff_response.dart';
import 'package:clg_app/data/responses/class_by_staff_response.dart';
import 'package:clg_app/data/responses/courses_by_semester_response.dart';
import 'package:clg_app/data/responses/exam_list_response.dart';
import 'package:clg_app/data/responses/general_response.dart';
import 'package:clg_app/data/responses/login_response.dart';
import 'package:clg_app/data/responses/staff_detail_response.dart';
import 'package:clg_app/data/responses/student_course_list_response.dart';
import 'package:clg_app/data/responses/student_detail_response.dart';
import 'package:clg_app/data/responses/student_exam_mark_response.dart';
import 'package:clg_app/data/responses/student_list_response.dart';
import 'package:clg_app/data/responses/student_mark_list_response.dart';
import 'package:clg_app/data/responses/students_attendance_response.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Repository {
  Future<ApiResponse<LoginResponse>> loginAdmin(
      String email, String uuid) async {
    final _remoteDataSource = RemoteDataSource();
    final _request = LoginRequest(email: email, uuid: uuid);
    final _result = await _remoteDataSource.loginUser(_request);
    if (_result.status == STATUS.SUCCESS) {
      await MyPreference().setName(_result.data!.data.name);
      await MyPreference().setMyId(_result.data!.data.adminId);
      await MyPreference().setEmail(_result.data!.data.email);
      await MyPreference().setToken(_result.data!.data.token);
    }
    return _result;
  }

  Future<ApiResponse<AllDepartmentResponse>> getAllDepartments() async {
    final _remoteDataSource = RemoteDataSource();
    final _result = await _remoteDataSource.getDepartments();
    return _result;
  }

  Future<ApiResponse<GeneralResponse>> addDepartment(
      String dpName, String dpId) async {
    final _remoteDataSource = RemoteDataSource();
    final _request = AddDepartmentRequest(dept_id: dpId, dept_name: dpName);
    final _result = await _remoteDataSource.addDepartment(_request);
    return _result;
  }

  Future<ApiResponse<AllSemesterResponse>> getAllSemesters() async {
    final _remoteDataSource = RemoteDataSource();
    final _result = await _remoteDataSource.getSemesters();
    return _result;
  }

  Future<ApiResponse<GeneralResponse>> addSemester(int sem) async {
    final _remoteDataSource = RemoteDataSource();
    final _request = AddSemesterRequest(
        semId: 'SEM-${sem < 9 ? '0$sem' : sem}', semester: 'Semester $sem');
    final _result = await _remoteDataSource.addSemester(_request);
    return _result;
  }

  Future<ApiResponse<CourseBySemesterResponse>> getAllCourse(
      String deptId, String semId, String staffIf) async {
    final _remoteDataSource = RemoteDataSource();
    final _request =
        CourseRequest(dept_id: deptId, sem_id: semId, staff_id: staffIf);
    final _result = await _remoteDataSource.getCourses(_request);
    return _result;
  }

  Future<ApiResponse<GeneralResponse>> addCourse({
    required String name,
    required String deptId,
    required String semId,
  }) async {
    final _remoteDataSource = RemoteDataSource();
    final _request =
        AddCourseRequest(dept_id: deptId, name: name, sem_id: semId);
    final _result = await _remoteDataSource.addCourse(_request);
    return _result;
  }

  Future<ApiResponse<AllStaffResponse>> getAllStaffList({
    String? semId,
    String? deptId,
  }) async {
    final _remoteDataSource = RemoteDataSource();
    final _request = AllStaffReuest(dept_id: deptId, sem_id: semId);
    final _result = await _remoteDataSource.getStaffList(_request);
    return _result;
  }

  Future<ApiResponse<StaffDetailResponse>> getStaffInfo(String staffId) async {
    final _remoteDataSource = RemoteDataSource();
    final _result = await _remoteDataSource.getStaffDetail(staffId);
    return _result;
  }

  Future<ApiResponse<ClassByStaffResponse>> getClassListByStaff(
      {String? staffId, String? courseId}) async {
    final _remoteDataSource = RemoteDataSource();
    final _result = await _remoteDataSource.getClassByStaff(
      staffId: staffId,
      courseId: courseId,
    );
    return _result;
  }

  Future<ApiResponse<StudentListResponse>> getAllStudents(
      {String? deptId, String? semId, String? staffIf, String? classId}) async {
    final _remoteDataSource = RemoteDataSource();
    final _request = StudentRequest(
      dept_id: deptId,
      sem_id: semId,
      staff_id: staffIf,
      class_id: classId,
    );
    final _result = await _remoteDataSource.getStudent(_request);
    return _result;
  }

  Future<ApiResponse<StudentsAttendanceResponse>> getStudentAttendance(
      {String? class_id,
      String? date,
      String? course_id,
      String? studentId}) async {
    final _remoteDataSource = RemoteDataSource();

    final _result = await _remoteDataSource.getAttendance(
      class_id: class_id,
      date: date,
      course_id: course_id,
      studentId: studentId,
    );
    return _result;
  }

  Future<ApiResponse<ExamListResponse>> getExamByStaff(
      {String? course_id}) async {
    final _remoteDataSource = RemoteDataSource();

    final _result = await _remoteDataSource.getExam(courseId: course_id);
    return _result;
  }

  Future<ApiResponse<StudentMarkListResponse>> getMarks({
    String? courseId,
    String? class_id,
    String? exam_id,
  }) async {
    final _remoteDataSource = RemoteDataSource();

    final _result = await _remoteDataSource.getMarks(
      courseId: courseId,
      class_id: class_id,
      examId: exam_id,
    );
    return _result;
  }

  Future<ApiResponse<GeneralResponse>> addExam({
    required String courseId,
    required String examName,
    required int total,
  }) async {
    final _remoteDataSource = RemoteDataSource();
    final request = AddExamRequest(
      courseId: courseId,
      name: examName,
      total: total,
    );
    final _result = await _remoteDataSource.addExam(request);
    return _result;
  }

  Future<ApiResponse<GeneralResponse>> addStaff(
      {required String email,
      required String dob,
      required String name,
      required String gender,
      required String department,
      required String address,
      required String city,
      required String postalCode,
      required String contact}) async {
    final _remoteDataSource = RemoteDataSource();
    final request = AddStaffRequest(
      email: email,
      dob: dob,
      name: name,
      gender: gender,
      department: department,
      address: address,
      city: city,
      postalCode: postalCode,
      contact: contact,
    );
    final _result = await _remoteDataSource.addStaff(request);
    return _result;
  }

  Future<ApiResponse<GeneralResponse>> addStudent({
    required String email,
    required String dob,
    required String name,
    required String gender,
    required String department,
    required String address,
    required String city,
    required String postalCode,
    required String contact,
    required String classId,
  }) async {
    final _remoteDataSource = RemoteDataSource();
    final request = AddStudentRequest(
      address: address,
      city: city,
      classId: classId,
      contact: contact,
      department: department,
      dob: dob,
      email: email,
      gender: gender,
      name: name,
      postalCode: postalCode,
    );
    final _result = await _remoteDataSource.addStudent(request);
    return _result;
  }

  Future<ApiResponse<GeneralResponse>> addAttendance({
    required String classId,
    required List<String> students,
  }) async {
    final _remoteDataSource = RemoteDataSource();
    final request = AddAttendanceRequest(classId: classId, students: students);
    final _result = await _remoteDataSource.addStudentAttendance(request);
    return _result;
  }

  Future<ApiResponse<GeneralResponse>> addExamMark({
    required String classId,
    required int examId,
    required List<Marks> marks,
  }) async {
    final _remoteDataSource = RemoteDataSource();
    final request = AddMarkRequest(
      classId: classId,
      examId: examId,
      marks: marks,
    );
    final _result = await _remoteDataSource.addMarks(request);
    return _result;
  }

  Future<ApiResponse<StudentDetailResponse>> getStudentInfo(
      {required String studentId}) async {
    final _remoteDataSource = RemoteDataSource();
    final _request = StudentRequest(studentId: studentId);
    final _result = await _remoteDataSource.getStudentInfo(_request);
    return _result;
  }

  Future<ApiResponse<StudentCourseListResponse>> getStudentCourse(
      String studentId) async {
    final _remoteDataSource = RemoteDataSource();
    final _result = await _remoteDataSource.getStudentCourse(studentId);
    return _result;
  }

  Future<ApiResponse<StudentExamMarkResponses>> getStudentMarks({
    required String courseId,
    required String studentId,
  }) async {
    final _remoteDataSource = RemoteDataSource();
    final _result = await _remoteDataSource.getStudentMarks(
        courseId: courseId, studentId: studentId);
    return _result;
  }

  Future<ApiResponse<GeneralResponse>> addClass(
      {String? staffId, String? courseId}) async {
    final _remoteDataSource = RemoteDataSource();
    final _result = await _remoteDataSource.AddClass(
      staffId: staffId,
      courseId: courseId,
    );
    return _result;
  }

  Future<ApiResponse<AllNotificationResponse>> getNotifications() async {
    final _remoteDataSource = RemoteDataSource();
    final _result = await _remoteDataSource.getNotifications();
    return _result;
  }

  Future<ApiResponse<GeneralResponse>> resetPassword() async {
    final _remoteDataSource = RemoteDataSource();
    final _result = await _remoteDataSource.resetPassword();
    return _result;
  }

  Future<ApiResponse<GeneralResponse>> updateAttendance({
    required String attendanceId,
    required int attendance,
  }) async {
    final _remoteDataSource = RemoteDataSource();
    final _result = await _remoteDataSource.updateAttendance(
        attendanceId: attendanceId, attendance: attendance);
    return _result;
  }

  Future<ApiResponse<GeneralResponse>> updateMark(
      {required String markId, required String marks}) async {
    final _remoteDataSource = RemoteDataSource();
    final _result =
        await _remoteDataSource.updateMark(markId: markId, marks: marks);
    return _result;
  }

  Future<ApiResponse<GeneralResponse>> uploadNotification({
    required String title,
    required String description,
    required File file,
  }) async {
    final _remoteDataSource = RemoteDataSource();
    final _firebaseStorage = FirebaseStorage.instance;
    var snapshot = await _firebaseStorage
        .ref()
        .child('notifications/${basename(file.path)}')
        .putFile(file);
    var downloadUrl = await snapshot.ref.getDownloadURL();

    final request = NotificationEntity(
        title: title, description: description, link: downloadUrl);
    final _result = await _remoteDataSource.AddNotifications(request);
    return _result;
  }
}
