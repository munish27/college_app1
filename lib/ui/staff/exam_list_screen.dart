import 'package:clg_app/data/remote/api_response.dart';
import 'package:clg_app/ui/admin/provider/teacher_provider.dart';
import 'package:clg_app/ui/reusable_widgets.dart';
import 'package:clg_app/ui/staff/add_exam_screen.dart';
import 'package:clg_app/ui/staff/exam_class_list_screen.dart';
import 'package:clg_app/ui/staff/mark_list_screen.dart';
import 'package:clg_app/ui/staff/teachers_list_admin_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ExamListScreen extends StatefulWidget {
  String? courseId;
  String? classId;
  ExamListScreen({Key? key, this.classId, this.courseId}) : super(key: key);

  @override
  State<ExamListScreen> createState() => _ExamListScreenState();
}

class _ExamListScreenState extends State<ExamListScreen> {
  late TeacherProvider _provider;

  @override
  void initState() {
    _provider = TeacherProvider();
    Future.delayed(Duration(seconds: 0), () {
      _provider.getExams(
        courseId: widget.courseId,
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
        appBar: appbar(context: context, title: 'Exams'),
        body: bodyContainer(),
        floatingActionButton: FloatingActionButton(
            onPressed: () async {
              final _result = await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) =>
                      ChangeNotifierProvider.value(
                    value: _provider,
                    builder: (context, child) => AddExamScreen(
                      courseId: widget.courseId!,
                    ),
                  ),
                ),
              );

              if (_result != null && _result) {
                _provider.getExams(
                  courseId: widget.courseId,
                );
              }
            },
            child: Icon(Icons.add)),
      ),
    );
  }

  Widget bodyContainer() =>
      Consumer<TeacherProvider>(builder: (context, value, child) {
        if (value.status == STATUS.LOADING) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (value.exams.isNotEmpty) {
          return ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 21.h),
            itemBuilder: (_, index) => _itemBuilder(
              name: value.exams[index].exName ?? '',
              semester: value.exams[index].exId.toString() ?? '',
              department: '',
              email: '',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        ChangeNotifierProvider.value(
                      value: _provider,
                      builder: (context, child) => ExamClassListScreen(
                          exam: value.exams[index], courseId: widget.courseId!),
                    ),
                  ),
                );
              },
            ),
            separatorBuilder: (_, __) => SizedBox(height: 10.h),
            itemCount: value.exams.length,
          );
        } else {
          return Center(
            child: Text('No attendance Found'),
          );
        }
      });

  Widget _itemBuilder({
    required String name,
    required String semester,
    required String email,
    required String department,
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
          child: Column(
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
        ),
      );
}
