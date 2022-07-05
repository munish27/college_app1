import 'package:clg_app/data/remote/api_response.dart';
import 'package:clg_app/ui/admin/provider/teacher_provider.dart';
import 'package:clg_app/ui/reusable_widgets.dart';
import 'package:clg_app/ui/staff/add_marks_screen.dart';
import 'package:clg_app/ui/staff/teachers_list_admin_screen.dart';
import 'package:clg_app/ui/students/provider/student_admin_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

class StudentMarkListScreen extends StatefulWidget {
  late String courseId;
  late String studentId;
  StudentMarkListScreen({
    Key? key,
    required this.courseId,
    required this.studentId,
  }) : super(key: key);

  @override
  State<StudentMarkListScreen> createState() => _StudentMarkListScreenState();
}

class _StudentMarkListScreenState extends State<StudentMarkListScreen> {
  late StudentAdminProvider _provider;

  @override
  void initState() {
    _provider = StudentAdminProvider();
    Future.delayed(Duration(seconds: 0), () {
      _provider.getMarks(
        studentId: widget.studentId,
        courseid: widget.courseId,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _provider,
      child: Scaffold(
        backgroundColor: Color(0xffF8FAFF),
        appBar: appbar(context: context, title: 'Marks'),
        body: bodyContainer(),
      ),
    );
  }

  Widget bodyContainer() =>
      Consumer<StudentAdminProvider>(builder: (context, value, child) {
        if (value.status == STATUS.LOADING) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (value.marks.isNotEmpty) {
          return ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 21.h),
            itemBuilder: (_, index) => _itemBuilder(
              name: value.marks[index].exName ?? '',
              className: value.marks[index].clsName ?? '',
              semester: value.marks[index].semName ?? '',
              mark: value.marks[index].score ?? 0,
              total: value.marks[index].exTotal ?? 0,
              department: value.marks[index].dName ?? '',
              email: value.marks[index].exName.toString(),
              onTap: () {},
            ),
            separatorBuilder: (_, __) => SizedBox(height: 10.h),
            itemCount: value.marks.length,
          );
        } else {
          return Center(
            child: Text('No Exams Found'),
          );
        }
      });

  Widget _itemBuilder({
    required String name,
    required int mark,
    required int total,
    required String email,
    required String department,
    required String semester,
    required String className,
    required Function() onTap,
  }) =>
      InkWell(
        onTap: onTap,
        child: Container(
          // height: 94.h,
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.w),
            color: Colors.white,
            // color: Color(0xffFFF2E4),
            // boxShadow: kElevationToShadow[1]
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    name,
                    style: Theme.of(context).textTheme.subtitle1?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    department,
                    style: Theme.of(context).textTheme.caption?.copyWith(
                          color: Colors.grey.shade500,
                        ),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    email,
                    style: Theme.of(context).textTheme.caption?.copyWith(
                          color: Colors.grey.shade500,
                        ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    semester,
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  
                ],
              ),

              ///
              CircularPercentIndicator(
                radius: 100.0.w,
                lineWidth: 13.0,
                animation: true,
                percent: mark / total,
                center: Text(
                  '$mark / $total',
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: Colors.purple,
              )
            ],
          ),
        ),
      );
}
