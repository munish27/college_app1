import 'package:clg_app/data/remote/api_response.dart';
import 'package:clg_app/ui/admin/provider/department_provider.dart';
import 'package:clg_app/ui/reusable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AddDepartmentScreen extends StatefulWidget {
  const AddDepartmentScreen({Key? key}) : super(key: key);

  @override
  State<AddDepartmentScreen> createState() => _AddDepartmentScreenState();
}

class _AddDepartmentScreenState extends State<AddDepartmentScreen> {
  late TextEditingController _deptName_controller;
  late TextEditingController _deptId_controller;

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
    _deptId_controller = TextEditingController();
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
  void dispose() {
    _provider.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _provider,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: appbar(context: context, title: 'Add Department'),
        body: SafeArea(child: bodyContainer()),
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
              title: 'Department name',
              controller: _deptName_controller,
              hint: 'Enter Department name',
              validator: (val) {
                if (val != null && val.isNotEmpty) {
                  return null;
                } else {
                  return 'Enter valid Name';
                }
              },
            ),
            SizedBox(height: 30.h),
            myTextFeild(
              context,
              title: 'Department Id',
              controller: _deptId_controller,
              hint: 'Enter Department Id',
              validator: (val) {
                if (val != null && val.isNotEmpty) {
                  return null;
                } else {
                  return 'Enter valid Id';
                }
              },
            ),
            SizedBox(height: 70.h),
            myButton(
              context,
              title: 'Add Department',
              onPressed: () async {
                if (_key.currentState != null &&
                    _key.currentState!.validate()) {
                  final _result = await _provider.addDepartment(
                      _deptName_controller.value.text,
                      _deptId_controller.value.text);

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
