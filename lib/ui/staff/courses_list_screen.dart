import 'package:clg_app/data/entities/course_entity.dart';
import 'package:clg_app/data/remote/api_response.dart';
import 'package:clg_app/ui/admin/add_semcourse_screen.dart';
import 'package:clg_app/ui/admin/provider/department_provider.dart';
import 'package:clg_app/ui/admin/provider/teacher_provider.dart';
import 'package:clg_app/ui/reusable_widgets.dart';
import 'package:clg_app/ui/staff/course_class_list_screen.dart';
import 'package:clg_app/ui/staff/courses_staff_dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CoursesListScreen extends StatefulWidget {
  late String staffId;

  CoursesListScreen({
    Key? key,
    required this.staffId,
  }) : super(key: key);

  @override
  State<CoursesListScreen> createState() => _CoursesListScreenState();
}

class _CoursesListScreenState extends State<CoursesListScreen> {
  late TeacherProvider _provider;

  @override
  void initState() {
    _provider = Provider.of<TeacherProvider>(context, listen: false);
    Future.delayed(Duration(seconds: 0), () {
      _provider.getStaffCourses(widget.staffId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _provider,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: appbar(context: context, title: 'Courses'),
        body: SafeArea(child: bodyContainer()),
      ),
    );
  }

  Widget bodyContainer() =>
      Consumer<TeacherProvider>(builder: (context, value, child) {
        if (value.status == STATUS.LOADING) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (value.courses.isNotEmpty) {
          return ListView(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 21.h),
            shrinkWrap: true,
            children: [
              ListView.separated(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                separatorBuilder: (_, __) => SizedBox(height: 10.h),
                itemBuilder: (_, index) => _itemBuilder(
                  title: value.courses[index].name,
                  teacher: value.courses[index].stName,
                  semester: value.courses[index].semName,
                  department: value.courses[index].dName,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            ChangeNotifierProvider.value(
                          value: _provider,
                          builder: (context, child) =>
                              CourseStaffDashboardScreen(
                            courseId: value.courses[index].cId,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                itemCount: value.courses.length,
              ),
            ],
          );
        } else {
          return Center(
            child: Text('No courses found'),
          );
        }
      });

  Widget _itemBuilder({
    required String title,
    required String semester,
    required String department,
    String? teacher,
    required Function() onTap,
  }) =>
      GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 21.h),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.w),
              color: Colors.white,
              boxShadow: kElevationToShadow[1]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Text(
                department,
                style: Theme.of(context).textTheme.caption,
              ),
              SizedBox(height: 40.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  teacher != null && teacher.isNotEmpty
                      ? RichText(
                          text: TextSpan(
                          text: 'Assigned staff',
                          children: [
                            TextSpan(text: ' : '),
                            TextSpan(
                              text: teacher,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  ?.copyWith(
                                    color: Colors.green,
                                  ),
                            ),
                          ],
                          style:
                              Theme.of(context).textTheme.subtitle2?.copyWith(
                                    color: Colors.red,
                                  ),
                        ))
                      : Text(
                          'Not assigned to any staff',
                          style:
                              Theme.of(context).textTheme.bodyText1?.copyWith(
                                    color: Colors.grey,
                                  ),
                        )
                ],
              ),
            ],
          ),
        ),
      );
}
