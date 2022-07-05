class ApiEndpoints {
  //Admin
  static const String ADMIN_BASE_URL = 'http://192.168.43.38:3000/admin/';
  static const String ADMIN_LOGIN = 'login';
  static const String ALL_DEPARTMENTS = 'getDept';
  static const String ADD_DEPARTMENT = 'addDept';
  static const String ALL_SEMESTER = 'getSem';
  static const String ADD_SEMESTER = 'addSem';
  static const String COURSE = 'getCourse';
  static const String ADD_COURSE = 'addCourse';
  static const String ALL_COURSE = 'getAllCourses';
  static const String ALL_STAFF = 'getAllStaffs';
  static const String STAFF = 'getStaff';
  static const String ADD_STAFF = 'addStaff';
  static const String ALL_CLASS_STAFF = 'getClass';
  static const String ALL_STUDENTS = 'getAllStudents';
  static const String STUDENT_INFO = 'getStudent';
  static const String STUDENT_ATTENDANCE = 'getAttendance';
  static const String STUDENT_ADD_ATTENDANCE = 'addAttendance';
  static const String ADD_EXAM = 'addExam';
  static const String COURSE_EXAM = 'getExam';
  static const String COURSE_MARKS = 'getmarks';
  static const String ADD_MARKS = 'addMarks';
  static const String ADD_STUDENT = 'addStudent';
  static const String ADD_CLASS = 'addClass';
  static const String ADD_NOTIFICATIONS = 'addNotification';
  static const String NOTIFICATIONS = 'getNotifications';
  static const String UPDATE_ATTENDANCE = 'updateAttendance';
  static const String UPDATE_MARK = 'updateMarks';
  static const String PSWD_RESET = 'reset';

  //Staff
  static const String STAFF_BASE_URL = 'http://192.168.43.38:3000/staff/';

  //Student
  // ignore: constant_identifier_names
  static const String STUDENT_BASE_URL = 'http://192.168.43.38:3000/student/';
}
