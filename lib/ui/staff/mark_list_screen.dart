import 'package:clg_app/core/my_preference.dart';
import 'package:clg_app/data/remote/api_response.dart';
import 'package:clg_app/ui/admin/provider/teacher_provider.dart';
import 'package:clg_app/ui/reusable_widgets.dart';
import 'package:clg_app/ui/staff/add_marks_screen.dart';
import 'package:clg_app/ui/staff/teachers_list_admin_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

class MarkListScreen extends StatefulWidget {
  late String examName;
  String? examId;
  String? classId;
  MarkListScreen({Key? key, this.classId, this.examId, required this.examName})
      : super(key: key);

  @override
  State<MarkListScreen> createState() => _MarkListScreenState();
}

class _MarkListScreenState extends State<MarkListScreen> {
  late TeacherProvider _provider;

  final ValueNotifier<int> _textField = ValueNotifier(-1);
  final _textController = TextEditingController();

  @override
  void initState() {
    _provider = TeacherProvider();
    Future.delayed(Duration(seconds: 0), () {
      _provider.getMarks(classId: widget.classId!, examId: widget.examId!);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _provider,
      child: Scaffold(
        backgroundColor: Color(0xffF8FAFF),
        appBar: appbar(context: context, title: 'Marks'),
        body: bodyContainer(),
        floatingActionButton:
            Consumer<TeacherProvider>(builder: (context, value, child) {
          if (value.marks.isNotEmpty) {
            return SizedBox();
          } else {
            return FloatingActionButton(
                onPressed: () async {
                  final _result = await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          ChangeNotifierProvider.value(
                        value: _provider,
                        builder: (context, child) => AddMarksscreen(
                          classId: widget.classId.toString(),
                          examId: widget.examId!,
                        ),
                      ),
                    ),
                  );

                  if (_result != null && _result) {
                    _provider.getMarks(
                        classId: widget.classId!, examId: widget.examId!);
                  }
                },
                child: Icon(Icons.add));
          }
        }),
      ),
    );
  }

  Widget bodyContainer() =>
      Consumer<TeacherProvider>(builder: (context, value, child) {
        if (value.status == STATUS.LOADING) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (value.marks.isNotEmpty) {
          return ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 21.h),
            itemBuilder: (_, index) => _itemBuilder(
              id: value.marks[index].markId ?? 0,
              name: value.marks[index].exName ?? '',
              className: value.marks[index].clsName ?? '',
              semester: value.marks[index].semName ?? '',
              mark: value.marks[index].score ?? 0,
              total: value.marks[index].exTotal ?? 0,
              department: value.marks[index].dName ?? '',
              email: value.marks[index].exName.toString(),
              onTap: () {},
            ),
            separatorBuilder: (_, __) => SizedBox(height: 10.h),
            itemCount: value.marks.length,
          );
        } else {
          return Center(
            child: Text('No Marks Found'),
          );
        }
      });

  Widget _itemBuilder({
    required String name,
    required int mark,
    required int id,
    required int total,
    required String email,
    required String department,
    required String semester,
    required String className,
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
            mainAxisSize: MainAxisSize.min,
            children: [
              MyPreference().getUserType() == 0 ||
                      MyPreference().getUserType() == 1
                  ? Flexible(
                      child: ValueListenableBuilder(
                        valueListenable: _textField,
                        builder: (context, val, child) {
                          if (val == -1) {
                            return Align(
                              alignment: Alignment.topRight,
                              child: IconButton(
                                visualDensity: VisualDensity(
                                    horizontal: -4.0, vertical: -4.0),
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  _textController.text = mark.toString();
                                  _textField.value = id;
                                },
                                icon: Icon(Icons.edit),
                                iconSize: 18.w,
                              ),
                            );
                          } else {
                            return SizedBox();
                          }
                        },
                      ),
                    )
                  : SizedBox(),
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          name,
                          style:
                              Theme.of(context).textTheme.subtitle1?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          department,
                          style: Theme.of(context).textTheme.caption?.copyWith(
                                color: Colors.grey.shade500,
                              ),
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          email,
                          style: Theme.of(context).textTheme.caption?.copyWith(
                                color: Colors.grey.shade500,
                              ),
                        ),
                        SizedBox(height: 20.h),
                        Text(
                          semester,
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                      ],
                    ),

                    ///
                    ///

                    ValueListenableBuilder(
                      valueListenable: _textField,
                      builder: (context, val, child) {
                        if (val == id) {
                          return SizedBox();
                        } else {
                          return CircularPercentIndicator(
                            radius: 100.0.w,
                            lineWidth: 13.0,
                            animation: true,
                            percent: mark / total,
                            center: Text(
                              '$mark / $total',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            circularStrokeCap: CircularStrokeCap.round,
                            progressColor: Colors.purple,
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              Flexible(
                flex: 1,
                child: ValueListenableBuilder(
                  valueListenable: _textField,
                  builder: (context, val, child) {
                    if (val == id) {
                      return myTextFeild(
                        context,
                        title: 'Mark',
                        controller: _textController,
                      );
                    } else {
                      return SizedBox();
                    }
                  },
                ),
              ),
              Flexible(
                flex: 1,
                child: ValueListenableBuilder(
                  valueListenable: _textField,
                  builder: (context, val, child) {
                    if (val == id) {
                      return myButton(context, title: 'Update',
                          onPressed: () async {
                        final _result = await _provider.editMark(
                            markId: id.toString(),
                            mark: _textController.value.text);
                        _textField.value = -1;
                        if (_result) {
                          _provider.getMarks(
                              classId: widget.classId!, examId: widget.examId!);
                        }
                      });
                    } else {
                      return SizedBox();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      );
}
