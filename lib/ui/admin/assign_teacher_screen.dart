import 'package:clg_app/data/entities/course_entity.dart';
import 'package:clg_app/data/entities/department_entity.dart';
import 'package:clg_app/data/entities/staff_entity.dart';
import 'package:clg_app/data/remote/api_response.dart';
import 'package:clg_app/ui/admin/provider/assign_course_provider.dart';
import 'package:clg_app/ui/reusable_widgets.dart';
import 'package:clg_app/ui/staff/provider/add_staff_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AssignTeacherScreen extends StatefulWidget {
  late String deptId;
  late CourseEntity course;
  AssignTeacherScreen({
    Key? key,
    required this.deptId,
    required this.course,
  }) : super(key: key);

  @override
  State<AssignTeacherScreen> createState() => _AssignTeacherScreenState();
}

class _AssignTeacherScreenState extends State<AssignTeacherScreen> {
  late AssignCourseProvider _provider;
  late TextEditingController _courseName;

  Future<bool> _navigate(bool? val) async {
    Navigator.of(context).pop(val ?? false);
    return true;
  }

  @override
  void initState() {
    _courseName = TextEditingController(text: widget.course.name);
    _provider = AssignCourseProvider();
    _provider.getAllStaff(widget.deptId);

    _provider.addListener(() {
      if (_provider.status == STATUS.SUCCESS) {
        _navigate(true);
      } else if (_provider.status == STATUS.ERROR) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(_provider.errMsg ??
                'Something went wrong, Please try again later.')));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return _navigate(null);
      },
      child: ChangeNotifierProvider(
        create: (_) => _provider,
        child: Scaffold(
          appBar: appbar(context: context, title: 'Assign Staff'),
          body: SafeArea(child: bodyContainer()),
        ),
      ),
    );
  }

  Widget bodyContainer() => Consumer<AssignCourseProvider>(
      builder: (context, value, child) => Stack(
            children: [
              _form(),
              value.status == STATUS.LOADING
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : const SizedBox(),
            ],
          ));

  Widget _form() => ListView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 21.h),
        shrinkWrap: true,
        children: [
          myTextFeild(
            context,
            title: 'Teacher Name',
            controller: _courseName,
            hint: 'Enter name',
            enabled: false,
            validator: (val) {
              if (val != null && val.isNotEmpty) {
                return null;
              } else {
                return 'Enter valid Name';
              }
            },
          ),
          SizedBox(height: 30.h),
          Consumer<AssignCourseProvider>(
              builder: (context, value, child) => DropdownButton<StaffEntity>(
                    isExpanded: true,
                    hint: Text('Select Department'),
                    items: value.staff.isNotEmpty
                        ? value.staff
                            .map((e) => DropdownMenuItem(
                                  child: Text(e.stName),
                                  value: e,
                                ))
                            .toList()
                        : [],
                    onChanged: (val) {
                      if (val != null) {
                        _provider.selectStaff(val);
                      }
                    },
                    value: value.selectedStaff,
                  )),
          myButton(context, title: 'Add Staff', onPressed: () {
            _provider.addClass(widget.course.cId);
          }),
        ],
      );
}
