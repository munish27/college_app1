import 'package:clg_app/data/remote/api_response.dart';
import 'package:clg_app/ui/admin/provider/teacher_provider.dart';
import 'package:clg_app/ui/staff/add_staff_screen.dart';
import 'package:clg_app/ui/staff/teachers_list_admin_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../reusable_widgets.dart';

class TeachersListScreen extends StatefulWidget {
  const TeachersListScreen({Key? key}) : super(key: key);

  @override
  State<TeachersListScreen> createState() => _TeachersListScreenState();
}

class _TeachersListScreenState extends State<TeachersListScreen> {
  late TeacherProvider _provider;

  @override
  void initState() {
    _provider = TeacherProvider();
    _provider.getAllStaff();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _provider,
      child: Scaffold(
        backgroundColor: Color(0xffF8FAFF),
        appBar: appbar(context: context, title: 'Teachers'),
        body: bodyContainer(),
        floatingActionButton: FloatingActionButton(
            onPressed: () async {
              final _result = await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) =>
                      ChangeNotifierProvider.value(
                    value: _provider,
                    builder: (context, child) => AddStaffScreen(),
                  ),
                ),
              );

              if (_result != null && _result) {
                _provider.getAllStaff();
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
        } else if (value.staff.isNotEmpty) {
          return ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 21.h),
            itemBuilder: (_, index) => _itemBuilder(
              name: value.staff[index].stName,
              semester: value.staff[index].semName ?? '',
              department: value.staff[index].dName ?? '',
              email: value.staff[index].email ?? '',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        ChangeNotifierProvider.value(
                      value: _provider,
                      builder: (context, child) => TeacherListAdminScreen(
                        staffId: value.staff[index].stId,
                      ),
                    ),
                  ),
                );
              },
            ),
            separatorBuilder: (_, __) => SizedBox(height: 10.h),
            itemCount: value.staff.length,
          );
        } else {
          return Center(
            child: Text('No Staff Found'),
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
