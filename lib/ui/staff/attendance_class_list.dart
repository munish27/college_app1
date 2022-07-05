import 'package:clg_app/data/entities/teacher_class_entity.dart';
import 'package:clg_app/data/remote/api_response.dart';
import 'package:clg_app/ui/admin/provider/department_provider.dart';
import 'package:clg_app/ui/admin/provider/teacher_provider.dart';
import 'package:clg_app/ui/reusable_widgets.dart';
import 'package:clg_app/ui/staff/attendance_list_screen.dart';
import 'package:clg_app/ui/staff/student_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AttendanceClassList extends StatefulWidget {
  String? courseId;
  AttendanceClassList({Key? key, this.courseId}) : super(key: key);

  @override
  State<AttendanceClassList> createState() => _AttendanceClassListState();
}

class _AttendanceClassListState extends State<AttendanceClassList> {
  late TeacherProvider _provider;

  @override
  void initState() {
    _provider = Provider.of<TeacherProvider>(context, listen: false);
    _provider.getClasses(courseId: widget.courseId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _provider,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: appbar(context: context, title: 'Class'),
        body: SafeArea(child: bodyContainer()),
            ),
    );
  }

  Widget bodyContainer() =>
      Consumer<TeacherProvider>(builder: (context, value, child) {
        if (value.classes.isNotEmpty) {
          return _form(value.classes);
        } else if (value.status == STATUS.LOADING) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Center(
            child: Text('No Classes found'),
          );
        }
      });

  Widget _form(List<TeacherClassEntity> classes) => ListView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        shrinkWrap: true,
        children: [
          SizedBox(height: 20.h),
          //user info
          Text(
            'Select Class for Attendance',
            style: Theme.of(context).textTheme.bodyText2,
          ),
          SizedBox(height: 50.h),

          GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16.w,
              mainAxisSpacing: 16.h,
              childAspectRatio: 4 / 2,
            ),
            itemBuilder: (_, index) => _gridItemBuilder(
              title: classes[index].clsName,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        ChangeNotifierProvider.value(
                      value: _provider,
                      builder: (context, child) => AttendanceListScreen(
                        classId: classes[index].classId.toString(),
                        courseId: widget.courseId,
                      ),
                    ),
                  ),
                );
              },
            ),
            itemCount: classes.length,
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
