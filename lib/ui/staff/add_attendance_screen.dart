import 'package:clg_app/data/remote/api_response.dart';
import 'package:clg_app/ui/reusable_widgets.dart';
import 'package:clg_app/ui/staff/provider/add_attendace_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddAttendanceScreen extends StatefulWidget {
  late String classId;
  AddAttendanceScreen({Key? key, required this.classId}) : super(key: key);

  @override
  State<AddAttendanceScreen> createState() => _AddAttendanceScreenState();
}

class _AddAttendanceScreenState extends State<AddAttendanceScreen> {
  late AddAttendanceProvider _provider;

  Future<bool> _navigate(bool? val) async {
    Navigator.of(context).pop(val ?? false);
    return true;
  }

  @override
  void initState() {
    _provider = AddAttendanceProvider();
    Future.delayed(Duration(seconds: 0), () {
      _provider.getStudents(widget.classId);
    });

    // _provider.addListener(() {
    //   if (_provider.status == STATUS.SUCCESS) {
    //     _navigate(true);
    //   } else if (_provider.status == STATUS.ERROR) {
    //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //         content: Text(_provider.errMsg ??
    //             'Something went wrong, Please try again later.')));
    //   }
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (() => _navigate(null)),
      child: ChangeNotifierProvider(
        create: (context) => _provider,
        child: Scaffold(
          backgroundColor: Color(0xffF8FAFF),
          appBar: appbar(context: context, title: 'Add Attendance', actions: [
            IconButton(
                onPressed: () async {
                  final _result =
                      await _provider.addAttendance(classId: widget.classId);
                  if (_result) {
                    _navigate(true);
                  }
                },
                icon: Icon(
                  Icons.add_task_sharp,
                  color: Colors.green,
                ))
          ]),
          body: bodyContainer(),
        ),
      ),
    );
  }

  Widget bodyContainer() =>
      Consumer<AddAttendanceProvider>(builder: (context, value, child) {
        if (value.status == STATUS.LOADING) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (value.students.isNotEmpty) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 21.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tick Absent Student Only',
                  style: Theme.of(context).textTheme.subtitle2?.copyWith(
                        color: Colors.red,
                      ),
                ),
                SizedBox(height: 10.h),
                //
                ListView.separated(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (_, index) => _itemBuilder(
                    name: value.students[index].sName ?? '',
                    email: value.students[index].email ?? '',
                    contact: value.students[index].contact ?? '',
                    id: value.students[index].sId ?? '',
                    onTap: () {
                      _provider.addAbsentStudent(value.students[index].sId);
                    },
                  ),
                  separatorBuilder: (_, __) => SizedBox(height: 10.h),
                  itemCount: value.students.length,
                )
              ],
            ),
          );
        } else {
          return Center(
            child: Text('No Students Found'),
          );
        }
      });

  Widget _itemBuilder({
    required String name,
    required String id,
    required String contact,
    required String email,
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
              //info
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
                    email,
                    style: Theme.of(context).textTheme.caption?.copyWith(
                          color: Colors.grey.shade500,
                        ),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    contact,
                    style: Theme.of(context).textTheme.caption?.copyWith(
                          color: Colors.grey.shade500,
                        ),
                  ),
                ],
              ),
              Consumer<AddAttendanceProvider>(
                  builder: (context, value, child) => Checkbox(
                      activeColor: Colors.red,
                      value: value.absentStudents.contains(id) ? true : false,
                      onChanged: (val) {
                        _provider.addAbsentStudent(id);
                      })),
            ],
          ),
        ),
      );
}
