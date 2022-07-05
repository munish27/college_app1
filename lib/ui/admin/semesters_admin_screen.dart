import 'package:clg_app/data/entities/semester_entity.dart';
import 'package:clg_app/data/remote/api_response.dart';
import 'package:clg_app/ui/admin/courses_admin_screen.dart';
import 'package:clg_app/ui/admin/provider/department_provider.dart';
import 'package:clg_app/ui/reusable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SemestersAdminScreen extends StatefulWidget {
  late String deptId;
  SemestersAdminScreen({Key? key, required this.deptId}) : super(key: key);

  @override
  State<SemestersAdminScreen> createState() => _SemestersAdminScreenState();
}

class _SemestersAdminScreenState extends State<SemestersAdminScreen> {
  late TextEditingController _semesterController;
  late DepartmentProvider _provider;

  final _key = GlobalKey<FormState>();

  @override
  void initState() {
    _semesterController = TextEditingController();
    _provider = Provider.of<DepartmentProvider>(context, listen: false);
    _provider.getAllSemesters();
    _provider.addListener(() {
      if (_provider.status == STATUS.SUCCESS) {
        if (_key.currentState != null && _key.currentState!.validate()) {
          _key.currentState?.reset();
          _semesterController.clear();
          _provider.getAllSemesters();
        }
      } else if (_provider.status == STATUS.ERROR &&
          _key.currentState != null &&
          _semesterController.value.text.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(_provider.errMsg ??
                'Something went wrong, Please try again later.')));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _provider,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: appbar(context: context, title: 'Semester'),
        body: SafeArea(child: bodyContainer()),
      ),
    );
  }

  Widget bodyContainer() =>
      Consumer<DepartmentProvider>(builder: (context, value, child) {
        if (value.semesters.isNotEmpty) {
          return Stack(
            children: [
              _form(value.semesters),
              value.status == STATUS.LOADING
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : SizedBox(),
            ],
          );
        } else if (value.semesters.isEmpty && value.status == STATUS.ERROR) {
          return _addForm();
        } else if (value.status == STATUS.LOADING) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return const SizedBox();
        }
      });

  Widget _form(List<SemesterEntity> semesters) => ListView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        shrinkWrap: true,
        children: [
          SizedBox(height: 20.h),

          //user info
          Text(
            'Select Semester for courses info',
            style: Theme.of(context).textTheme.bodyText2,
          ),
          SizedBox(height: 50.h),

          GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16.w,
              mainAxisSpacing: 16.h,
              childAspectRatio: 4 / 2,
            ),
            itemBuilder: (_, index) => _gridItemBuilder(
              title: semesters[index].sem_name,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        ChangeNotifierProvider.value(
                      value: _provider,
                      builder: (context, child) => CoursesAdminScreen(
                        deptId: widget.deptId,
                        semId: semesters[index].sem_id,
                      ),
                    ),
                  ),
                );
              },
            ),
            itemCount: semesters.length,
          ),
          SizedBox(height: 35.h),
          _addForm(),
        ],
      );

  Widget _addForm() => Form(
        key: _key,
        child: ListView(
          shrinkWrap: true,
          children: [
            Text(
              'Add Semester',
              style: Theme.of(context).textTheme.subtitle2,
            ),
            SizedBox(height: 10.h),
            myTextFeild(
              context,
              title: 'Semester',
              controller: _semesterController,
              keyboardType: TextInputType.number,
              validator: (val) {
                if (val != null && val.isNotEmpty) {
                  return null;
                } else {
                  return 'Enter valid Semester';
                }
              },
            ),
            SizedBox(height: 15.h),
            myButton(context, title: 'Add Semester', onPressed: () {
              if (_key.currentState != null && _key.currentState!.validate()) {
                _provider
                    .addSemester(int.parse(_semesterController.value.text));
              }
            }),
          ],
        ),
      );

  Widget _gridItemBuilder({
    required String title,
    required Function() onTap,
  }) =>
      InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 21.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.w),
            color: Color(0xffEF8481),
          ),
          child: Center(
            child: Text(
              title,
              style: Theme.of(context).textTheme.subtitle1?.copyWith(
                    // color: Color(0xff2C2C2E)÷
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ),
      );
}
