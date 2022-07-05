import 'package:clg_app/data/entities/department_entity.dart';
import 'package:clg_app/data/remote/api_response.dart';
import 'package:clg_app/ui/reusable_widgets.dart';
import 'package:clg_app/ui/staff/provider/add_staff_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AddStaffScreen extends StatefulWidget {
  const AddStaffScreen({Key? key}) : super(key: key);

  @override
  State<AddStaffScreen> createState() => _AddStaffScreenState();
}

class _AddStaffScreenState extends State<AddStaffScreen> {
  late TextEditingController _name;
  late TextEditingController _dob;
  late TextEditingController _email;
  late TextEditingController _address;
  late TextEditingController _city;
  late TextEditingController _zipcode;
  late TextEditingController _phone;

  late AddStaffProvider _provider;

  final _key = GlobalKey<FormState>();

  Future<bool> _navigate(bool? val) async {
    Navigator.of(context).pop(val ?? false);
    return true;
  }

  @override
  void initState() {
    _provider = AddStaffProvider();
    _provider.getAllDepartments();
    _name = TextEditingController();
    _dob = TextEditingController();
    _email = TextEditingController();
    _address = TextEditingController();
    _city = TextEditingController();
    _zipcode = TextEditingController();
    _phone = TextEditingController();
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
      child: ChangeNotifierProvider(
        create: (_) => _provider,
        child: Scaffold(
          appBar: appbar(context: context, title: 'Add Teacher'),
          body: SafeArea(child: bodyContainer()),
        ),
      ),
    );
  }

  Widget bodyContainer() => Consumer<AddStaffProvider>(
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
              title: 'Teacher Name',
              controller: _name,
              hint: 'Enter name',
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
              title: 'Date of Birth',
              hint: 'YYYY-MM-DD',
              controller: _dob,
              validator: (val) {
                if (val != null && val.isNotEmpty) {
                  return null;
                } else {
                  return 'Enter valid Date of Birth';
                }
              },
            ),
            SizedBox(height: 30.h),
            myTextFeild(
              context,
              title: 'Email',
              hint: 'Enter email address',
              controller: _email,
              keyboardType: TextInputType.emailAddress,
              validator: (val) {
                if (val != null && val.isNotEmpty) {
                  return null;
                } else {
                  return 'Enter valid email';
                }
              },
            ),
            SizedBox(height: 30.h),
            Consumer<AddStaffProvider>(
                builder: (context, value, child) =>
                    DropdownButton<DepartmentEnity>(
                      isExpanded: true,
                      hint: Text('Select Department'),
                      items: value.departments.isNotEmpty
                          ? value.departments
                              .map((e) => DropdownMenuItem(
                                    child: Text(e.dept_name),
                                    value: e,
                                  ))
                              .toList()
                          : [],
                      onChanged: (val) {
                        if (val != null) {
                          _provider.selectedDepartment(val);
                        }
                      },
                      value: value.selectedDept,
                    )),
            SizedBox(height: 30.h),
            Consumer<AddStaffProvider>(
                builder: (context, value, child) => DropdownButton<String>(
                      isExpanded: true,
                      hint: Text('Select gender'),
                      items: value.genders.isNotEmpty
                          ? value.genders
                              .map((e) => DropdownMenuItem(
                                    child: Text(e),
                                    value: e,
                                  ))
                              .toList()
                          : [],
                      onChanged: (val) {
                        if (val != null) {
                          _provider.selectGender(val);
                        }
                      },
                      value: value.selectedGender,
                    )),
            SizedBox(height: 30.h),
            myTextFeild(
              context,
              title: 'Address',
              controller: _address,
              hint: 'Enter Address',
              validator: (val) {
                if (val != null && val.isNotEmpty) {
                  return null;
                } else {
                  return 'Enter valid Address';
                }
              },
            ),
            SizedBox(height: 30.h),
            myTextFeild(
              context,
              title: 'City',
              controller: _city,
              hint: 'Enter City',
              validator: (val) {
                if (val != null && val.isNotEmpty) {
                  return null;
                } else {
                  return 'Enter valid city';
                }
              },
            ),
            SizedBox(height: 30.h),
            myTextFeild(
              context,
              title: 'Zip code',
              controller: _zipcode,
              hint: 'Enter Zip Code',
              keyboardType: TextInputType.number,
              validator: (val) {
                if (val != null && val.isNotEmpty) {
                  return null;
                } else {
                  return 'Enter valid Zip code';
                }
              },
            ),
            SizedBox(height: 30.h),
            myTextFeild(
              context,
              title: 'Phone',
              controller: _phone,
              hint: 'Enter Phone',
              keyboardType: TextInputType.number,
              validator: (val) {
                if (val != null && val.isNotEmpty) {
                  return null;
                } else {
                  return 'Enter valid Phone';
                }
              },
            ),
            SizedBox(height: 70.h),
            myButton(context, title: 'Add Staff', onPressed: () async {
              if (_key.currentState != null && _key.currentState!.validate()) {
                if (_provider.selectedDept == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Select Department')));
                } else if (_provider.selectedGender == null) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('Select Gender')));
                } else {
                  final _result = await _provider.addStaff(
                    email: _email.value.text,
                    dob: _dob.value.text,
                    name: _name.value.text,
                    address: _address.value.text,
                    city: _city.value.text,
                    postalCode: _zipcode.value.text,
                    contact: _phone.value.text,
                  );

                  if (_result) {
                    _navigate(true);
                  }
                }
              }
            }),
          ],
        ),
      );
}
