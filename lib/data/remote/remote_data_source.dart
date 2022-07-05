import 'package:clg_app/core/my_preference.dart';
import 'package:clg_app/data/api/api_endpoints.dart';
import 'package:clg_app/data/api/api_provider.dart';
import 'package:clg_app/data/entities/notification_entity.dart';
import 'package:clg_app/data/entities/student_detail_entity.dart';
import 'package:clg_app/data/remote/api_response.dart';
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
import 'package:dio/dio.dart';

class RemoteDataSource {
  Future<ApiResponse<LoginResponse>> loginUser(LoginRequest request) async {
    try {
      final _result = await ApiProvider().performCall(
          url: ApiEndpoints.ADMIN_LOGIN,
          requestType: RequestType.POST,
          requestFormat: RequestFormat.JSON,
          shouldRetry: false,
          isAuthorized: false,
          request: request.toJson());
      if (_result.statusCode != null && _result.statusCode! < 300) {
        final _res = LoginResponse.fromJson(_result.data);
        return ApiResponse.success(_res);
      } else {
        final _err = GeneralResponse.fromJson(_result.data);
        return ApiResponse.error(_err.message, _err.responseCode);
      }
    } on DioError catch (e) {
      if (e.response != null && e.response?.data != null) {
        final _err = GeneralResponse.fromJson(e.response!.data);
        return ApiResponse.error(_err.message, _err.responseCode);
      } else {
        return ApiResponse.error('Something went Wrong', 500);
      }
    } catch (e) {
      return ApiResponse.error('Something went Wrong', 500);
    }
  }

  Future<ApiResponse<GeneralResponse>> addDepartment(
      AddDepartmentRequest request) async {
    try {
      final _result = await ApiProvider().performCall(
        url: ApiEndpoints.ADD_DEPARTMENT,
        requestType: RequestType.POST,
        requestFormat: RequestFormat.JSON,
        shouldRetry: false,
        isAuthorized: false,
        request: request.toJson(),
      );
      if (_result.statusCode != null && _result.statusCode! < 300) {
        final _res = GeneralResponse.fromJson(_result.data);
        return ApiResponse.success(_res);
      } else {
        final _err = GeneralResponse.fromJson(_result.data);
        return ApiResponse.error(_err.message, _err.responseCode);
      }
    } on DioError catch (e) {
      if (e.response != null && e.response?.data != null) {
        final _err = GeneralResponse.fromJson(e.response!.data);
        return ApiResponse.error(_err.message, _err.responseCode);
      } else {
        return ApiResponse.error('Something went Wrong', 500);
      }
    } catch (e) {
      return ApiResponse.error('Something went Wrong', 500);
    }
  }

  Future<ApiResponse<AllDepartmentResponse>> getDepartments() async {
    try {
      final _result = await ApiProvider().performCall(
        url: ApiEndpoints.ALL_DEPARTMENTS,
        requestType: RequestType.GET,
        requestFormat: RequestFormat.JSON,
        shouldRetry: false,
        isAuthorized: false,
      );
      if (_result.statusCode != null && _result.statusCode! < 300) {
        final _res = AllDepartmentResponse.fromJson(_result.data);
        return ApiResponse.success(_res);
      } else {
        final _err = GeneralResponse.fromJson(_result.data);
        return ApiResponse.error(_err.message, _err.responseCode);
      }
    } on DioError catch (e) {
      if (e.response != null && e.response?.data != null) {
        final _err = GeneralResponse.fromJson(e.response!.data);
        return ApiResponse.error(_err.message, _err.responseCode);
      } else {
        return ApiResponse.error('Something went Wrong', 500);
      }
    } catch (e) {
      return ApiResponse.error('Something went Wrong', 500);
    }
  }

  Future<ApiResponse<AllSemesterResponse>> getSemesters() async {
    try {
      final _result = await ApiProvider().performCall(
        url: ApiEndpoints.ALL_SEMESTER,
        requestType: RequestType.GET,
        requestFormat: RequestFormat.JSON,
        shouldRetry: false,
        isAuthorized: false,
      );
      if (_result.statusCode != null && _result.statusCode! < 300) {
        final _res = AllSemesterResponse.fromJson(_result.data);
        return ApiResponse.success(_res);
      } else {
        final _err = GeneralResponse.fromJson(_result.data);
        return ApiResponse.error(_err.message, _err.responseCode);
      }
    } on DioError catch (e) {
      if (e.response != null && e.response?.data != null) {
        final _err = GeneralResponse.fromJson(e.response!.data);
        return ApiResponse.error(_err.message, _err.responseCode);
      } else {
        return ApiResponse.error('Something went Wrong', 500);
      }
    } catch (e) {
      return ApiResponse.error('Something went Wrong', 500);
    }
  }

  Future<ApiResponse<GeneralResponse>> addSemester(
      AddSemesterRequest request) async {
    try {
      final _result = await ApiProvider().performCall(
        url: ApiEndpoints.ADD_SEMESTER,
        requestType: RequestType.POST,
        requestFormat: RequestFormat.JSON,
        shouldRetry: false,
        isAuthorized: false,
        request: request.toJson(),
      );
      if (_result.statusCode != null && _result.statusCode! < 300) {
        final _res = GeneralResponse.fromJson(_result.data);
        return ApiResponse.success(_res);
      } else {
        final _err = GeneralResponse.fromJson(_result.data);
        return ApiResponse.error(_err.message, _err.responseCode);
      }
    } on DioError catch (e) {
      if (e.response != null && e.response?.data != null) {
        final _err = GeneralResponse.fromJson(e.response!.data);
        return ApiResponse.error(_err.message, _err.responseCode);
      } else {
        return ApiResponse.error('Something went Wrong', 500);
      }
    } catch (e) {
      return ApiResponse.error('Something went Wrong', 500);
    }
  }

  Future<ApiResponse<GeneralResponse>> addCourse(
      AddCourseRequest request) async {
    try {
      final _result = await ApiProvider().performCall(
        url: ApiEndpoints.ADD_COURSE,
        requestType: RequestType.POST,
        requestFormat: RequestFormat.JSON,
        shouldRetry: false,
        isAuthorized: false,
        request: request.toJson(),
      );
      print(request.toJson());
      if (_result.statusCode != null && _result.statusCode! < 300) {
        final _res = GeneralResponse.fromJson(_result.data);
        return ApiResponse.success(_res);
      } else {
        final _err = GeneralResponse.fromJson(_result.data);
        return ApiResponse.error(_err.message, _err.responseCode);
      }
    } on DioError catch (e) {
      if (e.response != null && e.response?.data != null) {
        final _err = GeneralResponse.fromJson(e.response!.data);
        return ApiResponse.error(_err.message, _err.responseCode);
      } else {
        return ApiResponse.error('Something went Wrong', 500);
      }
    } catch (e) {
      return ApiResponse.error('Something went Wrong', 500);
    }
  }

  Future<ApiResponse<CourseBySemesterResponse>> getCourses(
      CourseRequest request) async {
    try {
      final _result = await ApiProvider().performCall(
        url: ApiEndpoints.COURSE,
        requestType: RequestType.GET,
        requestFormat: RequestFormat.FORMDATA,
        shouldRetry: false,
        isAuthorized: false,
        request: request.toJson(),
      );
      if (_result.statusCode != null && _result.statusCode! < 300) {
        final _res = CourseBySemesterResponse.fromJson(_result.data);
        return ApiResponse.success(_res);
      } else {
        final _err = GeneralResponse.fromJson(_result.data);
        return ApiResponse.error(_err.message, _err.responseCode);
      }
    } on DioError catch (e) {
      if (e.response != null && e.response?.data != null) {
        final _err = GeneralResponse.fromJson(e.response!.data);
        return ApiResponse.error(_err.message, _err.responseCode);
      } else {
        return ApiResponse.error('Something went Wrong', 500);
      }
    } catch (e) {
      return ApiResponse.error('Something went Wrong', 500);
    }
  }

  Future<ApiResponse<AllStaffResponse>> getStaffList(
      AllStaffReuest request) async {
    try {
      final _result = await ApiProvider().performCall(
        url: ApiEndpoints.ALL_STAFF,
        requestType: RequestType.GET,
        requestFormat: RequestFormat.FORMDATA,
        shouldRetry: false,
        isAuthorized: false,
        request: request.toJson(),
      );
      if (_result.statusCode != null && _result.statusCode! < 300) {
        final _res = AllStaffResponse.fromJson(_result.data);
        return ApiResponse.success(_res);
      } else {
        final _err = GeneralResponse.fromJson(_result.data);
        return ApiResponse.error(_err.message, _err.responseCode);
      }
    } on DioError catch (e) {
      if (e.response != null && e.response?.data != null) {
        final _err = GeneralResponse.fromJson(e.response!.data);
        return ApiResponse.error(_err.message, _err.responseCode);
      } else {
        return ApiResponse.error('Something went Wrong', 500);
      }
    } catch (e) {
      return ApiResponse.error('Something went Wrong', 500);
    }
  }

  Future<ApiResponse<StaffDetailResponse>> getStaffDetail(
      String staffId) async {
    try {
      final _data = Map<String, String>();
      _data['staff_id'] = staffId;
      final _result = await ApiProvider().performCall(
        url: ApiEndpoints.STAFF,
        requestType: RequestType.GET,
        requestFormat: RequestFormat.FORMDATA,
        shouldRetry: false,
        isAuthorized: false,
        request: _data,
      );
      if (_result.statusCode != null && _result.statusCode! < 300) {
        final _res = StaffDetailResponse.fromJson(_result.data);
        return ApiResponse.success(_res);
      } else {
        final _err = GeneralResponse.fromJson(_result.data);
        return ApiResponse.error(_err.message, _err.responseCode);
      }
    } on DioError catch (e) {
      if (e.response != null && e.response?.data != null) {
        final _err = GeneralResponse.fromJson(e.response!.data);
        return ApiResponse.error(_err.message, _err.responseCode);
      } else {
        return ApiResponse.error('Something went Wrong', 500);
      }
    } catch (e) {
      return ApiResponse.error('Something went Wrong', 500);
    }
  }

  Future<ApiResponse<ClassByStaffResponse>> getClassByStaff(
      {String? staffId, String? courseId}) async {
    try {
      final _data = Map<String, String>();
      if (staffId != null && staffId.isNotEmpty) {
        _data['staff_id'] = staffId;
      }
      if (courseId != null && courseId.isNotEmpty) {
        _data['course_id'] = courseId;
      }

      final _result = await ApiProvider().performCall(
        url: ApiEndpoints.ALL_CLASS_STAFF,
        requestType: RequestType.GET,
        requestFormat: RequestFormat.FORMDATA,
        shouldRetry: false,
        isAuthorized: false,
        request: _data,
      );
      if (_result.statusCode != null && _result.statusCode! < 300) {
        final _res = ClassByStaffResponse.fromJson(_result.data);
        return ApiResponse.success(_res);
      } else {
        final _err = GeneralResponse.fromJson(_result.data);
        return ApiResponse.error(_err.message, _err.responseCode);
      }
    } on DioError catch (e) {
      if (e.response != null && e.response?.data != null) {
        final _err = GeneralResponse.fromJson(e.response!.data);
        return ApiResponse.error(_err.message, _err.responseCode);
      } else {
        return ApiResponse.error('Something went Wrong', 500);
      }
    } catch (e) {
      return ApiResponse.error('Something went Wrong', 500);
    }
  }

  Future<ApiResponse<StudentDetailResponse>> getStudentInfo(
      StudentRequest request) async {
    try {
      final _result = await ApiProvider().performCall(
        url: ApiEndpoints.STUDENT_INFO,
        requestType: RequestType.GET,
        requestFormat: RequestFormat.FORMDATA,
        shouldRetry: false,
        isAuthorized: false,
        request: request.toJson(),
      );
      if (_result.statusCode != null && _result.statusCode! < 300) {
        final _res = StudentDetailResponse.fromJson(_result.data);
        return ApiResponse.success(_res);
      } else {
        final _err = GeneralResponse.fromJson(_result.data);
        return ApiResponse.error(_err.message, _err.responseCode);
      }
    } on DioError catch (e) {
      if (e.response != null && e.response?.data != null) {
        final _err = GeneralResponse.fromJson(e.response!.data);
        return ApiResponse.error(_err.message, _err.responseCode);
      } else {
        return ApiResponse.error('Something went Wrong', 500);
      }
    } catch (e) {
      return ApiResponse.error('Something went Wrong', 500);
    }
  }

  Future<ApiResponse<StudentListResponse>> getStudent(
      StudentRequest request) async {
    try {
      final _result = await ApiProvider().performCall(
        url: ApiEndpoints.ALL_STUDENTS,
        requestType: RequestType.GET,
        requestFormat: RequestFormat.FORMDATA,
        shouldRetry: false,
        isAuthorized: false,
        request: request.toJson(),
      );
      if (_result.statusCode != null && _result.statusCode! < 300) {
        final _res = StudentListResponse.fromJson(_result.data);
        return ApiResponse.success(_res);
      } else {
        final _err = GeneralResponse.fromJson(_result.data);
        return ApiResponse.error(_err.message, _err.responseCode);
      }
    } on DioError catch (e) {
      if (e.response != null && e.response?.data != null) {
        final _err = GeneralResponse.fromJson(e.response!.data);
        return ApiResponse.error(_err.message, _err.responseCode);
      } else {
        return ApiResponse.error('Something went Wrong', 500);
      }
    } catch (e) {
      return ApiResponse.error('Something went Wrong', 500);
    }
  }

  Future<ApiResponse<StudentsAttendanceResponse>> getAttendance(
      {String? class_id,
      String? date,
      String? course_id,
      String? studentId}) async {
    try {
      final _data = Map<String, String>();
      if (class_id != null && class_id.isNotEmpty) {
        _data['class_id'] = class_id;
      }
      if (course_id != null && course_id.isNotEmpty) {
        _data['course_id'] = course_id;
      }
      if (date != null && date.isNotEmpty) {
        _data['date'] = date;
      }
      if (studentId != null && studentId.isNotEmpty) {
        _data['student_id'] = studentId;
      }

      final _result = await ApiProvider().performCall(
        url: ApiEndpoints.STUDENT_ATTENDANCE,
        requestType: RequestType.GET,
        requestFormat: RequestFormat.FORMDATA,
        shouldRetry: false,
        isAuthorized: false,
        request: _data,
      );
      if (_result.statusCode != null && _result.statusCode! < 300) {
        final _res = StudentsAttendanceResponse.fromJson(_result.data);
        return ApiResponse.success(_res);
      } else {
        final _err = GeneralResponse.fromJson(_result.data);
        return ApiResponse.error(_err.message, _err.responseCode);
      }
    } on DioError catch (e) {
      if (e.response != null && e.response?.data != null) {
        final _err = GeneralResponse.fromJson(e.response!.data);
        return ApiResponse.error(_err.message, _err.responseCode);
      } else {
        return ApiResponse.error('Something went Wrong', 500);
      }
    } catch (e) {
      return ApiResponse.error('Something went Wrong', 500);
    }
  }

  Future<ApiResponse<GeneralResponse>> addStudentAttendance(
      AddAttendanceRequest request) async {
    try {
      final _result = await ApiProvider().performCall(
        url: ApiEndpoints.STUDENT_ADD_ATTENDANCE,
        requestType: RequestType.POST,
        requestFormat: RequestFormat.JSON,
        shouldRetry: false,
        isAuthorized: false,
        request: request.toJson(),
      );
      if (_result.statusCode != null && _result.statusCode! < 300) {
        final _res = GeneralResponse.fromJson(_result.data);
        return ApiResponse.success(_res);
      } else {
        final _err = GeneralResponse.fromJson(_result.data);
        return ApiResponse.error(_err.message, _err.responseCode);
      }
    } on DioError catch (e) {
      if (e.response != null && e.response?.data != null) {
        final _err = GeneralResponse.fromJson(e.response!.data);
        return ApiResponse.error(_err.message, _err.responseCode);
      } else {
        return ApiResponse.error('Something went Wrong', 500);
      }
    } catch (e) {
      return ApiResponse.error('Something went Wrong', 500);
    }
  }

  Future<ApiResponse<GeneralResponse>> addExam(AddExamRequest request) async {
    try {
      final _result = await ApiProvider().performCall(
        url: ApiEndpoints.ADD_EXAM,
        requestType: RequestType.POST,
        requestFormat: RequestFormat.JSON,
        shouldRetry: false,
        isAuthorized: false,
        request: request.toJson(),
      );
      if (_result.statusCode != null && _result.statusCode! < 300) {
        final _res = GeneralResponse.fromJson(_result.data);
        return ApiResponse.success(_res);
      } else {
        final _err = GeneralResponse.fromJson(_result.data);
        return ApiResponse.error(_err.message, _err.responseCode);
      }
    } on DioError catch (e) {
      if (e.response != null && e.response?.data != null) {
        final _err = GeneralResponse.fromJson(e.response!.data);
        return ApiResponse.error(_err.message, _err.responseCode);
      } else {
        return ApiResponse.error('Something went Wrong', 500);
      }
    } catch (e) {
      return ApiResponse.error('Something went Wrong', 500);
    }
  }

  Future<ApiResponse<ExamListResponse>> getExam({String? courseId}) async {
    try {
      final _data = Map<String, String>();
      if (courseId != null && courseId.isNotEmpty) {
        _data['course_id'] = courseId;
      }
      final _result = await ApiProvider().performCall(
        url: ApiEndpoints.COURSE_EXAM,
        requestType: RequestType.GET,
        requestFormat: RequestFormat.FORMDATA,
        shouldRetry: false,
        isAuthorized: false,
        request: _data,
      );
      if (_result.statusCode != null && _result.statusCode! < 300) {
        final _res = ExamListResponse.fromJson(_result.data);
        return ApiResponse.success(_res);
      } else {
        final _err = GeneralResponse.fromJson(_result.data);
        return ApiResponse.error(_err.message, _err.responseCode);
      }
    } on DioError catch (e) {
      if (e.response != null && e.response?.data != null) {
        final _err = GeneralResponse.fromJson(e.response!.data);
        return ApiResponse.error(_err.message, _err.responseCode);
      } else {
        return ApiResponse.error('Something went Wrong', 500);
      }
    } catch (e) {
      return ApiResponse.error('Something went Wrong', 500);
    }
  }

  Future<ApiResponse<GeneralResponse>> addMarks(AddMarkRequest request) async {
    try {
      final _result = await ApiProvider().performCall(
        url: ApiEndpoints.ADD_MARKS,
        requestType: RequestType.POST,
        requestFormat: RequestFormat.JSON,
        shouldRetry: false,
        isAuthorized: false,
        request: request.toJson(),
      );
      if (_result.statusCode != null && _result.statusCode! < 300) {
        final _res = GeneralResponse.fromJson(_result.data);
        return ApiResponse.success(_res);
      } else {
        final _err = GeneralResponse.fromJson(_result.data);
        return ApiResponse.error(_err.message, _err.responseCode);
      }
    } on DioError catch (e) {
      if (e.response != null && e.response?.data != null) {
        final _err = GeneralResponse.fromJson(e.response!.data);
        return ApiResponse.error(_err.message, _err.responseCode);
      } else {
        return ApiResponse.error('Something went Wrong', 500);
      }
    } catch (e) {
      return ApiResponse.error('Something went Wrong', 500);
    }
  }

  Future<ApiResponse<StudentMarkListResponse>> getMarks(
      {String? courseId, String? class_id, String? examId}) async {
    try {
      final _data = Map<String, String>();
      if (courseId != null && courseId.isNotEmpty) {
        _data['course_id'] = courseId;
      }
      if (class_id != null && class_id.isNotEmpty) {
        _data['class_id'] = class_id;
      }
      if (examId != null && examId.isNotEmpty) {
        _data['exam_id'] = examId;
      }
      final _result = await ApiProvider().performCall(
        url: ApiEndpoints.COURSE_MARKS,
        requestType: RequestType.GET,
        requestFormat: RequestFormat.FORMDATA,
        shouldRetry: false,
        isAuthorized: false,
        request: _data,
      );
      if (_result.statusCode != null && _result.statusCode! < 300) {
        final _res = StudentMarkListResponse.fromJson(_result.data);
        return ApiResponse.success(_res);
      } else {
        final _err = GeneralResponse.fromJson(_result.data);
        return ApiResponse.error(_err.message, _err.responseCode);
      }
    } on DioError catch (e) {
      if (e.response != null && e.response?.data != null) {
        final _err = GeneralResponse.fromJson(e.response!.data);
        return ApiResponse.error(_err.message, _err.responseCode);
      } else {
        return ApiResponse.error('Something went Wrong', 500);
      }
    } catch (e) {
      return ApiResponse.error('Something went Wrong', 500);
    }
  }

  Future<ApiResponse<GeneralResponse>> addStaff(AddStaffRequest request) async {
    try {
      final _result = await ApiProvider().performCall(
        url: ApiEndpoints.ADD_STAFF,
        requestType: RequestType.POST,
        requestFormat: RequestFormat.JSON,
        shouldRetry: false,
        isAuthorized: false,
        request: request.toJson(),
      );
      if (_result.statusCode != null && _result.statusCode! < 300) {
        final _res = GeneralResponse.fromJson(_result.data);
        return ApiResponse.success(_res);
      } else {
        final _err = GeneralResponse.fromJson(_result.data);
        return ApiResponse.error(_err.message, _err.responseCode);
      }
    } on DioError catch (e) {
      if (e.response != null && e.response?.data != null) {
        final _err = GeneralResponse.fromJson(e.response!.data);
        return ApiResponse.error(_err.message, _err.responseCode);
      } else {
        return ApiResponse.error('Something went Wrong', 500);
      }
    } catch (e) {
      return ApiResponse.error('Something went Wrong', 500);
    }
  }

  Future<ApiResponse<GeneralResponse>> addStudent(
      AddStudentRequest request) async {
    try {
      final _result = await ApiProvider().performCall(
        url: ApiEndpoints.ADD_STUDENT,
        requestType: RequestType.POST,
        requestFormat: RequestFormat.JSON,
        shouldRetry: false,
        isAuthorized: false,
        request: request.toJson(),
      );
      if (_result.statusCode != null && _result.statusCode! < 300) {
        final _res = GeneralResponse.fromJson(_result.data);
        return ApiResponse.success(_res);
      } else {
        final _err = GeneralResponse.fromJson(_result.data);
        return ApiResponse.error(_err.message, _err.responseCode);
      }
    } on DioError catch (e) {
      if (e.response != null && e.response?.data != null) {
        final _err = GeneralResponse.fromJson(e.response!.data);
        return ApiResponse.error(_err.message, _err.responseCode);
      } else {
        return ApiResponse.error('Something went Wrong', 500);
      }
    } catch (e) {
      return ApiResponse.error('Something went Wrong', 500);
    }
  }

  Future<ApiResponse<StudentCourseListResponse>> getStudentCourse(
      String studentId) async {
    try {
      final _data = Map<String, String>();
      if (studentId != null && studentId.isNotEmpty) {
        _data['student_id'] = studentId;
      }
      final _result = await ApiProvider().performCall(
        url: ApiEndpoints.COURSE,
        requestType: RequestType.GET,
        requestFormat: RequestFormat.FORMDATA,
        shouldRetry: false,
        isAuthorized: false,
        request: _data,
      );
      if (_result.statusCode != null && _result.statusCode! < 300) {
        final _res = StudentCourseListResponse.fromJson(_result.data);
        return ApiResponse.success(_res);
      } else {
        final _err = GeneralResponse.fromJson(_result.data);
        return ApiResponse.error(_err.message, _err.responseCode);
      }
    } on DioError catch (e) {
      if (e.response != null && e.response?.data != null) {
        final _err = GeneralResponse.fromJson(e.response!.data);
        return ApiResponse.error(_err.message, _err.responseCode);
      } else {
        return ApiResponse.error('Something went Wrong', 500);
      }
    } catch (e) {
      return ApiResponse.error('Something went Wrong', 500);
    }
  }

  Future<ApiResponse<StudentExamMarkResponses>> getStudentMarks({
    required String courseId,
    required String studentId,
  }) async {
    try {
      final _data = Map<String, String>();
      if (courseId != null && courseId.isNotEmpty) {
        _data['course_id'] = courseId;
      }
      if (studentId != null && studentId.isNotEmpty) {
        _data['student_id'] = studentId;
      }

      final _result = await ApiProvider().performCall(
        url: ApiEndpoints.COURSE_MARKS,
        requestType: RequestType.GET,
        requestFormat: RequestFormat.FORMDATA,
        shouldRetry: false,
        isAuthorized: false,
        request: _data,
      );
      if (_result.statusCode != null && _result.statusCode! < 300) {
        final _res = StudentExamMarkResponses.fromJson(_result.data);
        return ApiResponse.success(_res);
      } else {
        final _err = GeneralResponse.fromJson(_result.data);
        return ApiResponse.error(_err.message, _err.responseCode);
      }
    } on DioError catch (e) {
      if (e.response != null && e.response?.data != null) {
        final _err = GeneralResponse.fromJson(e.response!.data);
        return ApiResponse.error(_err.message, _err.responseCode);
      } else {
        return ApiResponse.error('Something went Wrong', 500);
      }
    } catch (e) {
      return ApiResponse.error('Something went Wrong', 500);
    }
  }

  Future<ApiResponse<GeneralResponse>> AddClass(
      {String? staffId, String? courseId}) async {
    try {
      final _data = Map<String, String>();
      if (staffId != null && staffId.isNotEmpty) {
        _data['staff_id'] = staffId;
      }
      if (courseId != null && courseId.isNotEmpty) {
        _data['course_id'] = courseId;
      }

      final _result = await ApiProvider().performCall(
        url: ApiEndpoints.ADD_CLASS,
        requestType: RequestType.POST,
        requestFormat: RequestFormat.JSON,
        shouldRetry: false,
        isAuthorized: false,
        request: _data,
      );
      if (_result.statusCode != null && _result.statusCode! < 300) {
        final _res = GeneralResponse.fromJson(_result.data);
        return ApiResponse.success(_res);
      } else {
        final _err = GeneralResponse.fromJson(_result.data);
        return ApiResponse.error(_err.message, _err.responseCode);
      }
    } on DioError catch (e) {
      if (e.response != null && e.response?.data != null) {
        final _err = GeneralResponse.fromJson(e.response!.data);
        return ApiResponse.error(_err.message, _err.responseCode);
      } else {
        return ApiResponse.error('Something went Wrong', 500);
      }
    } catch (e) {
      return ApiResponse.error('Something went Wrong', 500);
    }
  }

  Future<ApiResponse<AllNotificationResponse>> getNotifications() async {
    try {
      final _result = await ApiProvider().performCall(
        url: ApiEndpoints.NOTIFICATIONS,
        requestType: RequestType.GET,
        requestFormat: RequestFormat.JSON,
        shouldRetry: false,
        isAuthorized: false,
      );
      if (_result.statusCode != null && _result.statusCode! < 300) {
        final _res = AllNotificationResponse.fromJson(_result.data);
        return ApiResponse.success(_res);
      } else {
        final _err = GeneralResponse.fromJson(_result.data);
        return ApiResponse.error(_err.message, _err.responseCode);
      }
    } on DioError catch (e) {
      if (e.response != null && e.response?.data != null) {
        final _err = GeneralResponse.fromJson(e.response!.data);
        return ApiResponse.error(_err.message, _err.responseCode);
      } else {
        return ApiResponse.error('Something went Wrong', 500);
      }
    } catch (e) {
      return ApiResponse.error('Something went Wrong', 500);
    }
  }

  Future<ApiResponse<GeneralResponse>> AddNotifications(
      NotificationEntity request) async {
    try {
      final _result = await ApiProvider().performCall(
        url: ApiEndpoints.ADD_NOTIFICATIONS,
        requestType: RequestType.POST,
        requestFormat: RequestFormat.JSON,
        shouldRetry: false,
        isAuthorized: false,
        request: request.toJson(),
      );
      if (_result.statusCode != null && _result.statusCode! < 300) {
        final _res = GeneralResponse.fromJson(_result.data);
        return ApiResponse.success(_res);
      } else {
        final _err = GeneralResponse.fromJson(_result.data);
        return ApiResponse.error(_err.message, _err.responseCode);
      }
    } on DioError catch (e) {
      if (e.response != null && e.response?.data != null) {
        final _err = GeneralResponse.fromJson(e.response!.data);
        return ApiResponse.error(_err.message, _err.responseCode);
      } else {
        return ApiResponse.error('Something went Wrong', 500);
      }
    } catch (e) {
      return ApiResponse.error('Something went Wrong', 500);
    }
  }

  Future<ApiResponse<GeneralResponse>> resetPassword() async {
    try {
      final _data = Map<String, String>();
      _data['uuid'] = MyPreference().getMyId();
      final _result = await ApiProvider().performCall(
        url: ApiEndpoints.PSWD_RESET,
        requestType: RequestType.POST,
        requestFormat: RequestFormat.JSON,
        shouldRetry: false,
        isAuthorized: false,
        request: _data,
      );
      if (_result.statusCode != null && _result.statusCode! < 300) {
        final _res = GeneralResponse.fromJson(_result.data);
        return ApiResponse.success(_res);
      } else {
        final _err = GeneralResponse.fromJson(_result.data);
        return ApiResponse.error(_err.message, _err.responseCode);
      }
    } on DioError catch (e) {
      print(e);
      if (e.response != null && e.response?.data != null) {
        final _err = GeneralResponse.fromJson(e.response!.data);
        return ApiResponse.error(_err.message, _err.responseCode);
      } else {
        return ApiResponse.error('Something went Wrong', 500);
      }
    } catch (e) {
            print(e);
      return ApiResponse.error('Something went Wrong', 500);
    }
  }

  Future<ApiResponse<GeneralResponse>> updateMark(
      {required String markId, required String marks}) async {
    try {
      final _data = Map<String, String>();
      _data['mark_id'] = markId;
      _data['marks'] = marks;
      final _result = await ApiProvider().performCall(
        url: ApiEndpoints.UPDATE_MARK,
        requestType: RequestType.PUT,
        requestFormat: RequestFormat.JSON,
        shouldRetry: false,
        isAuthorized: false,
        request: _data,
      );
      if (_result.statusCode != null && _result.statusCode! < 300) {
        final _res = GeneralResponse.fromJson(_result.data);
        return ApiResponse.success(_res);
      } else {
        final _err = GeneralResponse.fromJson(_result.data);
        return ApiResponse.error(_err.message, _err.responseCode);
      }
    } on DioError catch (e) {
            print(e);

      if (e.response != null && e.response?.data != null) {
        final _err = GeneralResponse.fromJson(e.response!.data);
        return ApiResponse.error(_err.message, _err.responseCode);
      } else {
        return ApiResponse.error('Something went Wrong', 500);
      }
    } catch (e) {
            print(e);

      return ApiResponse.error('Something went Wrong', 500);
    }
  }

  Future<ApiResponse<GeneralResponse>> updateAttendance({
    required String attendanceId,
    required int attendance,
  }) async {
    try {
      final _data = Map<String, dynamic>();
      _data['attendance_id'] = attendanceId;
      _data['attendance'] = attendance;
      final _result = await ApiProvider().performCall(
        url: ApiEndpoints.UPDATE_ATTENDANCE,
        requestType: RequestType.PUT,
        requestFormat: RequestFormat.JSON,
        shouldRetry: false,
        isAuthorized: false,
        request: _data,
      );
      if (_result.statusCode != null && _result.statusCode! < 300) {
        final _res = GeneralResponse.fromJson(_result.data);
        return ApiResponse.success(_res);
      } else {
        final _err = GeneralResponse.fromJson(_result.data);
        return ApiResponse.error(_err.message, _err.responseCode);
      }
    } on DioError catch (e) {
      if (e.response != null && e.response?.data != null) {
        final _err = GeneralResponse.fromJson(e.response!.data);
        return ApiResponse.error(_err.message, _err.responseCode);
      } else {
        return ApiResponse.error('Something went Wrong', 500);
      }
    } catch (e) {
      return ApiResponse.error('Something went Wrong', 500);
    }
  }
}
