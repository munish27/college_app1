import 'package:clg_app/data/entities/department_entity.dart';
import 'package:clg_app/data/entities/student_course_entity.dart';
import 'package:clg_app/data/remote/api_response.dart';
import 'package:clg_app/ui/admin/add_department_screen.dart';
import 'package:clg_app/ui/admin/provider/department_provider.dart';
import 'package:clg_app/ui/admin/semesters_admin_screen.dart';
import 'package:clg_app/ui/reusable_widgets.dart';
import 'package:clg_app/ui/students/provider/student_admin_provider.dart';
import 'package:clg_app/ui/students/student_course_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class StudentCourseListScreen extends StatefulWidget {
  late String studentId;
  StudentCourseListScreen({Key? key, required this.studentId})
      : super(key: key);

  @override
  State<StudentCourseListScreen> createState() =>
      _StudentCourseListScreenState();
}

class _StudentCourseListScreenState extends State<StudentCourseListScreen> {
  late StudentAdminProvider _provider;

  @override
  void initState() {
    _provider = StudentAdminProvider();
    _provider.getCourses(widget.studentId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _provider,
      child: Scaffold(
        backgroundColor: Colors.white,
        // appBar: AppBar(),
        body: SafeArea(child: bodyContainer()),
        appBar: appbar(context: context, title: 'Courses'),
      ),
    );
  }

  Widget bodyContainer() =>
      Consumer<StudentAdminProvider>(builder: (context, value, child) {
        if (value.status == STATUS.LOADING) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (value.courses.isNotEmpty) {
          return _bodyBuilder(value.courses);
        } else if (value.status == STATUS.ERROR) {
          return Center(
            child: Text(value.errMsg ?? 'No data found'),
          );
        } else {
          return Container();
        }
      });

  Widget _bodyBuilder(List<StudentCourseEntity> courses) => Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            //user info
            Text(
              'Select Subjects for detailed info',
              style: Theme.of(context).textTheme.bodyText2,
            ),
            SizedBox(height: 50.h),
            ListView.builder(
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (_, index) => _gridItemBuilder(
                title: courses[index].name,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          ChangeNotifierProvider.value(
                        value: _provider,
                        builder: (context, child) => StudentCourseInfoScreen(
                          courseId: courses[index].cId,
                          studentId: widget.studentId,
                          staffId: courses[index].staffId,
                        ),
                      ),
                    ),
                  );
                },
              ),
              itemCount: courses.length,
            ),
          ],
        ),
      );

  Widget _gridItemBuilder({
    required String title,
    required Function() onTap,
  }) =>
      InkWell(
        onTap: onTap,
        child: Container(
          width: 1.sw,
          margin: EdgeInsets.only(bottom: 17.h),
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 21.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.w),
            color: Color(0xffF4CCAF),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //title
              Text(
                title,
                style: Theme.of(context).textTheme.subtitle1?.copyWith(
                      // color: Color(0xff2C2C2E)÷
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Icon(
                Icons.chevron_right,
                color: Colors.white,
              ),
            ],
          ),
        ),
      );
}
