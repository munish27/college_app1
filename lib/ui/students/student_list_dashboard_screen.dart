import 'package:clg_app/data/entities/student_entity.dart';
import 'package:clg_app/data/remote/api_response.dart';
import 'package:clg_app/ui/admin/provider/teacher_provider.dart';
import 'package:clg_app/ui/students/add_student_screen.dart';
import 'package:clg_app/ui/students/provider/student_admin_provider.dart';
import 'package:clg_app/ui/students/student_dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class StudentListDashboardScreen extends StatefulWidget {
  StudentListDashboardScreen({Key? key}) : super(key: key);

  @override
  State<StudentListDashboardScreen> createState() =>
      _StudentListDashboardScreenState();
}

class _StudentListDashboardScreenState
    extends State<StudentListDashboardScreen> {
  late StudentAdminProvider _provider;

  @override
  void initState() {
    _provider = StudentAdminProvider();
    _provider.getStudents();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _provider,
      child: Scaffold(
        backgroundColor: Color(0xffF8FAFF),
        appBar: AppBar(),
        body: bodyContainer(),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) =>
                      ChangeNotifierProvider.value(
                    value: _provider,
                    builder: (context, child) => AddStudentScreen(),
                  ),
                ),
              );
            },
            child: Icon(Icons.add)),
      ),
    );
  }

  Widget bodyContainer() =>
      Consumer<StudentAdminProvider>(builder: (context, value, child) {
        if (value.students.isNotEmpty) {
          return _listBuilder(value.students);
        } else if (value.status == STATUS.LOADING) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return const SizedBox();
        }
      });

  Widget _listBuilder(List<StudentEntity> students) => ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 21.h),
        itemBuilder: (_, index) => _itemBuilder(
          name: students[index].sName,
          semester: students[index].semName,
          department: students[index].dName,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => ChangeNotifierProvider.value(
                  value: _provider,
                  builder: (context, child) =>
                      StudentDashboardScreen(studentId: students[index].sId),
                ),
              ),
            );
          },
        ),
        separatorBuilder: (_, __) => SizedBox(height: 10.h),
        itemCount: students.length,
      );

  Widget _itemBuilder({
    required String name,
    required String semester,
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
