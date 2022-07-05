import 'package:clg_app/data/remote/api_response.dart';
import 'package:clg_app/data/requests/add_mark_request.dart';
import 'package:clg_app/ui/reusable_widgets.dart';
import 'package:clg_app/ui/staff/provider/add_attendace_provider.dart';
import 'package:clg_app/ui/staff/provider/add_marks_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddMarksscreen extends StatefulWidget {
  late String classId;
  late String examId;
  AddMarksscreen({Key? key, required this.classId, required this.examId})
      : super(key: key);

  @override
  State<AddMarksscreen> createState() => _AddMarksscreenState();
}

class _AddMarksscreenState extends State<AddMarksscreen> {
  late AddMarksProvider _provider;

  Future<bool> _navigate(bool? val) async {
    Navigator.of(context).pop(val ?? false);
    return true;
  }

  @override
  void initState() {
    _provider = AddMarksProvider();
    Future.delayed(Duration(seconds: 0), () {
      _provider.getStudents(widget.classId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _provider,
      child: Scaffold(
        backgroundColor: Color(0xffF8FAFF),
        appBar: appbar(context: context, title: 'Add Marks', actions: [
          IconButton(
              onPressed: () async {
                if (_provider.marks.length != _provider.students.length) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Enter every students scores')));
                } else {
                  final _result = await _provider.uploadMarks(
                      classId: widget.classId, examId: widget.examId);
                  if (_result) {
                    _navigate(true);
                  }
                }
              },
              icon: Icon(
                Icons.add_task_sharp,
                color: Colors.green,
              ))
        ]),
        body: bodyContainer(),
      ),
    );
  }

  Widget bodyContainer() =>
      Consumer<AddMarksProvider>(builder: (context, value, child) {
        if (value.status == STATUS.LOADING) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (value.students.isNotEmpty) {
          return ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 21.h),
            physics: ClampingScrollPhysics(),
            itemBuilder: (_, index) => _itemBuilder(
              name: value.students[index].sName ?? '',
              email: value.students[index].email ?? '',
              contact: value.students[index].contact ?? '',
              id: value.students[index].sId ?? '',
              onTap: () {
                // _provider.addAbsentStudent(value.students[index].sId);
              },
            ),
            separatorBuilder: (_, __) => SizedBox(height: 10.h),
            itemCount: value.students.length,
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
              Consumer<AddMarksProvider>(
                builder: (context, value, child) => TextFormField(
                  keyboardType: TextInputType.number,
                  onChanged: (val) {
                    final _mark = Marks(sId: id, marks: int.parse(val));
                    print(val);
                    _provider.addStudentMarks(_mark);
                  },
                  style: Theme.of(context).textTheme.bodyText2,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.w),
                      borderSide: BorderSide(
                        color: const Color(0xff1C375A).withOpacity(.2),
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.w),
                      borderSide: BorderSide(
                        color: const Color(0xff1C375A).withOpacity(.2),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.w),
                      borderSide: BorderSide(
                        color: const Color(0xff1C375A).withOpacity(.2),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.w),
                      borderSide: BorderSide(
                        color: const Color(0xff1C375A).withOpacity(.2),
                      ),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.w),
                      borderSide: BorderSide(
                        color: const Color(0xff1C375A).withOpacity(.2),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
