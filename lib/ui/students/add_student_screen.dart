import 'package:clg_app/data/entities/course_entity.dart';
import 'package:clg_app/data/entities/department_entity.dart';
import 'package:clg_app/data/entities/teacher_class_entity.dart';
import 'package:clg_app/data/remote/api_response.dart';
import 'package:clg_app/ui/reusable_widgets.dart';
import 'package:clg_app/ui/staff/provider/add_staff_provider.dart';
import 'package:clg_app/ui/students/provider/add_student_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AddStudentScreen extends StatefulWidget {
  const AddStudentScreen({Key? key}) : super(key: key);

  @override
  State<AddStudentScreen> createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  late TextEditingController _name;
  late TextEditingController _dob;
  late TextEditingController _email;
  late TextEditingController _address;
  late TextEditingController _city;
  late TextEditingController _zipcode;
  late TextEditingController _phone;

  late AddStudentProvider _provider;

  @override
  void initState() {
    _provider = AddStudentProvider();
    _provider.getAllDepartments();
    _name = TextEditingController();
    _dob = TextEditingController();
    _email = TextEditingController();
    _address = TextEditingController();
    _city = TextEditingController();
    _zipcode = TextEditingController();
    _phone = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _provider,
      child: Scaffold(
        body: SafeArea(child: bodyContainer()),
      ),
    );
  }

  Widget bodyContainer() => Consumer<AddStudentProvider>(
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
            title: 'Name',
            controller: _name,
          ),
          SizedBox(height: 30.h),
          myTextFeild(
            context,
            title: 'Date of Birth',
            hint: 'YYYY-MM-DD',
            controller: _dob,
          ),
          SizedBox(height: 30.h),
          myTextFeild(
            context,
            title: 'Email',
            hint: 'Enter email address',
            controller: _email,
          ),
          SizedBox(height: 30.h),
          Consumer<AddStudentProvider>(
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
          Consumer<AddStudentProvider>(
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
          Consumer<AddStudentProvider>(
              builder: (context, value, child) => DropdownButton<CourseEntity>(
                    isExpanded: true,
                    hint: Text('Select Course'),
                    items:  value.courses.isNotEmpty
                        ? value.courses
                            .map((e) => DropdownMenuItem(
                                  child: Text(e.name),
                                  value: e,
                                ))
                            .toList()
                        : null,
                    onChanged: (val) {
                      if (val != null) {
                        _provider.selectCourse(val);
                      }
                    },
                    value: value.selectedCourse,
                  )),
          SizedBox(height: 30.h),
          Consumer<AddStudentProvider>(
              builder: (context, value, child) =>
                  DropdownButton<TeacherClassEntity>(
                    isExpanded: true,
                    hint: Text('Select class'),
                    items: value.classes.isNotEmpty
                        ? value.classes
                            .map((e) => DropdownMenuItem(
                                  child: Text(e.clsName),
                                  value: e,
                                ))
                            .toList()
                        : [],
                    onChanged: (val) {
                      if (val != null) {
                        _provider.selectClass(val);
                      }
                    },
                    value: value.selectedClass,
                  )),
          SizedBox(height: 30.h),
          myTextFeild(
            context,
            title: 'Address',
            controller: _address,
          ),
          SizedBox(height: 30.h),
          myTextFeild(
            context,
            title: 'City',
            controller: _city,
          ),
          SizedBox(height: 30.h),
          myTextFeild(
            context,
            title: 'Zip code',
            controller: _zipcode,
          ),
          SizedBox(height: 30.h),
          myTextFeild(
            context,
            title: 'Phone',
            controller: _phone,
          ),
          SizedBox(height: 70.h),
          myButton(context, title: 'Add Student', onPressed: () {
            _provider.addStudent(
              email: _email.value.text,
              dob: _dob.value.text,
              name: _name.value.text,
              address: _address.value.text,
              city: _city.value.text,
              postalCode: _zipcode.value.text,
              contact: _phone.value.text,
            );
          }),
        ],
      );
}
