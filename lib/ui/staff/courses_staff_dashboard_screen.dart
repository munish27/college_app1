import 'package:clg_app/data/entities/teacher_class_entity.dart';
import 'package:clg_app/data/remote/api_response.dart';
import 'package:clg_app/ui/admin/provider/teacher_provider.dart';
import 'package:clg_app/ui/reusable_widgets.dart';
import 'package:clg_app/ui/staff/attendance_class_list.dart';
import 'package:clg_app/ui/staff/attendance_list_screen.dart';
import 'package:clg_app/ui/staff/exam_list_screen.dart';
import 'package:clg_app/ui/staff/staff_class_list_screen.dart';
import 'package:clg_app/ui/staff/student_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CourseStaffDashboardScreen extends StatefulWidget {
  late String courseId;
  CourseStaffDashboardScreen({Key? key, required this.courseId})
      : super(key: key);

  @override
  State<CourseStaffDashboardScreen> createState() =>
      _CourseStaffDashboardScreenState();
}

class _CourseStaffDashboardScreenState
    extends State<CourseStaffDashboardScreen> {
  late TeacherProvider _provider;

  @override
  void initState() {
    _provider = Provider.of<TeacherProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _provider,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: appbar(context: context, title: 'Course Info'),
        body: SafeArea(child: bodyContainer()),
      ),
    );
  }

  Widget bodyContainer() => _form();

  Widget _form() => ListView(
        padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 31.h),
        shrinkWrap: true,
        children: [
          GridView(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16.w,
              mainAxisSpacing: 16.h,
              childAspectRatio: 4 / 2,
            ),
            children: [
              _gridItemBuilder(
                title: 'Exams',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          ChangeNotifierProvider.value(
                        value: _provider,
                        builder: (context, child) => ExamListScreen(
                          courseId: widget.courseId,
                        ),
                      ),
                    ),
                  );
                },
              ),
              _gridItemBuilder(
                title: 'Attendance',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          ChangeNotifierProvider.value(
                        value: _provider,
                        builder: (context, child) => AttendanceClassList(
                          courseId: widget.courseId,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      );

  Widget _gridItemBuilder({
    required String title,
    required Function() onTap,
  }) =>
      InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 21.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.w),
            color: Color(0xffEF8481),
          ),
          child: Center(
            child: Text(
              title,
              style: Theme.of(context).textTheme.subtitle1?.copyWith(
                    // color: Color(0xff2C2C2E)÷
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ),
      );
}
