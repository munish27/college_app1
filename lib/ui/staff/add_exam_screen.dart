import 'package:clg_app/data/remote/api_response.dart';
import 'package:clg_app/ui/admin/provider/department_provider.dart';
import 'package:clg_app/ui/admin/provider/teacher_provider.dart';
import 'package:clg_app/ui/reusable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AddExamScreen extends StatefulWidget {
  final String courseId;
  const AddExamScreen({Key? key, required this.courseId}) : super(key: key);

  @override
  State<AddExamScreen> createState() => _AddExamScreenState();
}

class _AddExamScreenState extends State<AddExamScreen> {
  late TextEditingController _examName;
  late TextEditingController _examTotal;

  late TeacherProvider _provider;
  final _key = GlobalKey<FormState>();

  void _navigate(bool? val) async {
    Navigator.of(context).pop(val ?? false);
  }

  @override
  void initState() {
    _provider = Provider.of<TeacherProvider>(context, listen: false);
    _examName = TextEditingController();
    _examTotal = TextEditingController();
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
        _navigate(null);
        return true;
      },
      child: ChangeNotifierProvider.value(
        value: _provider,
        child: Scaffold(
          body: SafeArea(child: bodyContainer()),
        ),
      ),
    );
  }

  Widget bodyContainer() => Consumer<TeacherProvider>(
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
              title: 'Exam name',
              controller: _examName,
              hint: 'Enter exam',
              validator: (val) {
                if (val != null && val.isNotEmpty) {
                  return null;
                } else {
                  return 'Enter valid exam';
                }
              },
            ),
            SizedBox(height: 30.h),
            myTextFeild(
              context,
              title: 'Exam Total Score',
              controller: _examTotal,
              hint: 'Enter Total score',
              keyboardType: TextInputType.number,
              validator: (val) {
                if (val != null && val.isNotEmpty) {
                  return null;
                } else {
                  return 'Enter valid score';
                }
              },
            ),
            SizedBox(height: 70.h),
            myButton(
              context,
              title: 'Add Exam',
              onPressed: () async {
                if (_key.currentState != null &&
                    _key.currentState!.validate()) {
                  final _result = await _provider.addExam(
                      courseId: widget.courseId,
                      examName: _examName.value.text,
                      total: int.parse(_examTotal.value.text));
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
