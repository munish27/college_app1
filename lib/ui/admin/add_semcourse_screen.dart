import 'package:clg_app/data/remote/api_response.dart';
import 'package:clg_app/ui/admin/provider/department_provider.dart';
import 'package:clg_app/ui/reusable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AddSemCourseScreen extends StatefulWidget {
  late String semId;
  late String deptId;
  AddSemCourseScreen({Key? key, required this.deptId, required this.semId})
      : super(key: key);

  @override
  State<AddSemCourseScreen> createState() => _AddSemCourseScreenState();
}

class _AddSemCourseScreenState extends State<AddSemCourseScreen> {
  late TextEditingController _deptName_controller;

  late DepartmentProvider _provider;

  final _key = GlobalKey<FormState>();

  Future<bool> _navigate(bool? val) async {
    Navigator.of(context).pop(val ?? false);
    return true;
  }

  @override
  void initState() {
    _provider = Provider.of<DepartmentProvider>(context, listen: false);
    _deptName_controller = TextEditingController();
    _provider.addListener(() {
     if (_provider.status == STATUS.ERROR) {
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
      child: ChangeNotifierProvider.value(
        value: _provider,
        child: Scaffold(
          appBar: appbar(context: context, title: 'Add Subjects'),
          body: SafeArea(child: bodyContainer()),
        ),
      ),
    );
  }

  Widget bodyContainer() => Consumer<DepartmentProvider>(
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

  Widget _form() => Form(
        key: _key,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 21.h),
          shrinkWrap: true,
          children: [
            myTextFeild(
              context,
              title: 'Subject',
              hint: 'Enter subject',
              controller: _deptName_controller,
              validator: (val) {
                if (val != null && val.isNotEmpty) {
                  return null;
                } else {
                  return 'Enter valid subject';
                }
              },
            ),
            SizedBox(height: 70.h),
            myButton(
              context,
              title: 'Add Subject',
              onPressed: () async {
                if (_key.currentState != null &&
                    _key.currentState!.validate()) {
                  final _result = await _provider.addCourse(
                      name: _deptName_controller.value.text,
                      deptId: widget.deptId,
                      semId: widget.semId);

                  if (_result) {
                    _navigate(true);
                  }
                }
              },
            ),
          ],
        ),
      );
}
