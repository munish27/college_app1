import 'package:clg_app/data/entities/course_entity.dart';
import 'package:clg_app/data/remote/api_response.dart';
import 'package:clg_app/ui/admin/add_semcourse_screen.dart';
import 'package:clg_app/ui/admin/assign_teacher_screen.dart';
import 'package:clg_app/ui/admin/provider/department_provider.dart';
import 'package:clg_app/ui/reusable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CoursesAdminScreen extends StatefulWidget {
  late String semId;
  late String deptId;

  CoursesAdminScreen({
    Key? key,
    required this.deptId,
    required this.semId,
  }) : super(key: key);

  @override
  State<CoursesAdminScreen> createState() => _CoursesAdminScreenState();
}

class _CoursesAdminScreenState extends State<CoursesAdminScreen> {
  late DepartmentProvider _provider;

  @override
  void initState() {
    _provider = Provider.of<DepartmentProvider>(context, listen: false);
    _provider.getAllCourses(widget.deptId, widget.semId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _provider,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: appbar(context: context, title: 'Subjects'),
        body: SafeArea(child: bodyContainer()),
        floatingActionButton: FloatingActionButton(
            onPressed: () async {
              final result = await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) =>
                      ChangeNotifierProvider.value(
                    value: _provider,
                    builder: (context, child) => AddSemCourseScreen(
                      deptId: widget.deptId,
                      semId: widget.semId,
                    ),
                  ),
                ),
              );
              if (result != null && result) {
                _provider.getAllCourses(widget.deptId, widget.semId);
              }
            },
            child: Icon(Icons.add)),
      ),
    );
  }

  Widget bodyContainer() =>
      Consumer<DepartmentProvider>(builder: (context, value, child) {
        if (value.status == STATUS.LOADING) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (value.courses.isNotEmpty) {
          return ListView(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 21.h),
            shrinkWrap: true,
            children: [
              ListView.separated(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                separatorBuilder: (_, __) => SizedBox(height: 10.h),
                itemBuilder: (_, index) => _itemBuilder(
                    title: value.courses[index].name,
                    teacher: value.courses[index].stName,
                    semester: value.courses[index].semName,
                    department: value.courses[index].dName,
                    onTap: () {},
                    onAddTap: () async {
                      final result = await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              ChangeNotifierProvider.value(
                            value: _provider,
                            builder: (context, child) => AssignTeacherScreen(
                              course: value.courses[index],
                              deptId: widget.deptId,
                            ),
                          ),
                        ),
                      );
                      if (result != null && result) {
                        _provider.getAllCourses(widget.deptId, widget.semId);
                      }
                    }),
                itemCount: value.courses.length,
              ),
            ],
          );
        } else {
          return Center(
            child: Text('No data found'),
          );
        }
      });

  Widget _itemBuilder({
    required String title,
    required String semester,
    required String department,
    String? teacher,
    required Function() onTap,
    Function()? onAddTap,
  }) =>
      Container(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 21.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.w),
            color: Colors.white,
            boxShadow: kElevationToShadow[1]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            Text(
              department,
              style: Theme.of(context).textTheme.caption,
            ),
            SizedBox(height: 40.h),
            teacher != null && teacher.isNotEmpty
                ? RichText(
                    text: TextSpan(
                    text: 'Assigned staff',
                    children: [
                      TextSpan(text: ' : '),
                      TextSpan(
                        text: teacher,
                        style: Theme.of(context).textTheme.subtitle2?.copyWith(
                              color: Colors.green,
                            ),
                      ),
                    ],
                    style: Theme.of(context).textTheme.subtitle2?.copyWith(
                          color: Colors.red,
                        ),
                  ))
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Not assigned to any staff',
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                              color: Colors.grey,
                            ),
                      ),
                      IconButton(
                          onPressed: onAddTap,
                          icon: Icon(
                            Icons.add,
                            color: Colors.green,
                          ))
                    ],
                  ),
          ],
        ),
      );
}
