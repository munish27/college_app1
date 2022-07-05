import 'package:clg_app/core/my_preference.dart';
import 'package:clg_app/data/remote/api_response.dart';
import 'package:clg_app/ui/admin/provider/teacher_provider.dart';
import 'package:clg_app/ui/reusable_widgets.dart';
import 'package:clg_app/ui/staff/add_attendance_screen.dart';
import 'package:clg_app/ui/staff/teachers_list_admin_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AttendanceListScreen extends StatefulWidget {
  String? courseId;
  String? classId;
  AttendanceListScreen({Key? key, this.classId, this.courseId})
      : super(key: key);

  @override
  State<AttendanceListScreen> createState() => _AttendanceListScreenState();
}

class _AttendanceListScreenState extends State<AttendanceListScreen> {
  late TeacherProvider _provider;

  @override
  void initState() {
    _provider = TeacherProvider();
    Future.delayed(Duration(seconds: 0), () {
      _provider.getAttendance(
        classId: widget.classId,
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
        appBar: appbar(context: context, title: 'Attendance'),
        body: bodyContainer(),
        floatingActionButton:
            Consumer<TeacherProvider>(builder: (context, value, child) {
          if (value.attendance.isNotEmpty) {
            return SizedBox();
          } else {
            return FloatingActionButton(
                onPressed: () async {
                  final _result = await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          ChangeNotifierProvider.value(
                        value: _provider,
                        builder: (context, child) => AddAttendanceScreen(
                          classId: widget.classId.toString(),
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
                child: Icon(Icons.add));
          }
        }),
      ),
    );
  }

  Widget bodyContainer() =>
      Consumer<TeacherProvider>(builder: (context, value, child) {
        if (value.status == STATUS.LOADING) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (value.attendance.isNotEmpty) {
          return ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 21.h),
            itemBuilder: (_, index) => _itemBuilder(
              id: value.attendance[index].atId ?? 0,
              name: value.attendance[index].name ?? '',
              semester: value.attendance[index].semName ?? '',
              department: value.attendance[index].dName ?? '',
              attendance: value.attendance[index].attendance ?? 0,
              date: value.attendance[index].date ?? '',
              onTap: () {},
            ),
            separatorBuilder: (_, __) => SizedBox(height: 10.h),
            itemCount: value.attendance.length,
          );
        } else {
          return Center(
            child: Text('No attendance Found'),
          );
        }
      });

  Widget _itemBuilder({
    required String name,
    required int id,
    required String semester,
    required int attendance,
    required String department,
    required String date,
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
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  attendance == 0 ? 'Absent' : 'Present',
                  style: Theme.of(context).textTheme.subtitle2?.copyWith(
                        color: attendance == 0 ? Colors.red : Colors.green,
                      ),
                ),
                MyPreference().getUserType() == 0 ||
                        MyPreference().getUserType() == 1
                    ? Switch(
                        value: attendance == 1 ? true : false,
                        onChanged: (val) async {
                          final _result = await _provider.editAttendance(
                              attendanceId: id.toString(),
                              attendance: val ? 1 : 0);
                          if (_result) {
                            _provider.getAttendance(
                              classId: widget.classId,
                            );
                          }
                        })
                    : SizedBox(),
              ]),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    semester,
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  Text(
                    date,
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ],
              )
            ],
          ),
        ),
      );
}
