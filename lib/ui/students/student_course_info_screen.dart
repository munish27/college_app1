import 'package:clg_app/core/my_preference.dart';
import 'package:clg_app/data/entities/teacher_class_entity.dart';
import 'package:clg_app/data/remote/api_response.dart';
import 'package:clg_app/ui/admin/provider/teacher_provider.dart';
import 'package:clg_app/ui/chat_room.dart';
import 'package:clg_app/ui/reusable_widgets.dart';
import 'package:clg_app/ui/staff/attendance_class_list.dart';
import 'package:clg_app/ui/staff/attendance_list_screen.dart';
import 'package:clg_app/ui/staff/exam_list_screen.dart';
import 'package:clg_app/ui/staff/staff_class_list_screen.dart';
import 'package:clg_app/ui/staff/student_list_screen.dart';
import 'package:clg_app/ui/students/provider/student_admin_provider.dart';
import 'package:clg_app/ui/students/student_attendance_screen.dart';
import 'package:clg_app/ui/students/student_mark_list_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class StudentCourseInfoScreen extends StatefulWidget {
  late String courseId;
  late String studentId;
  late String staffId;
  StudentCourseInfoScreen({
    Key? key,
    required this.courseId,
    required this.studentId,
    required this.staffId,
  }) : super(key: key);

  @override
  State<StudentCourseInfoScreen> createState() =>
      _StudentCourseInfoScreenState();
}

class _StudentCourseInfoScreenState extends State<StudentCourseInfoScreen> {
  late StudentAdminProvider _provider;

  @override
  void initState() {
    _provider = Provider.of<StudentAdminProvider>(context, listen: false);
    super.initState();
  }

  String chatRoomId(String user1, String user2) {
    if (user1[0].toLowerCase().codeUnits[0] >
        user2.toLowerCase().codeUnits[0]) {
      return "$user1$user2";
    } else {
      return "$user2$user1";
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _provider,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: appbar(context: context, title: 'Course Info'),
        body: SafeArea(child: bodyContainer()),
      ),
    );
  }

  Widget bodyContainer() => _form();

  Widget _form() => ListView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 31.h),
        shrinkWrap: true,
        children: [
          GridView(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16.w,
              mainAxisSpacing: 16.h,
              childAspectRatio: 4 / 2,
            ),
            children: [
              _gridItemBuilder(
                title: 'Marks',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          ChangeNotifierProvider.value(
                        value: _provider,
                        builder: (context, child) => StudentMarkListScreen(
                          courseId: widget.courseId,
                          studentId: widget.studentId,
                        ),
                      ),
                    ),
                  );
                },
              ),
              _gridItemBuilder(
                title: 'Attendance',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          ChangeNotifierProvider.value(
                        value: _provider,
                        builder: (context, child) => StudentAttendanceScreen(
                          courseId: widget.courseId,
                          studentId: widget.studentId,
                        ),
                      ),
                    ),
                  );
                },
              ),
              MyPreference().getUserType() == 2
                  ? _gridItemBuilder(
                      title: 'Chat with tutor',
                      onTap: () async {
                        final _firebaseUser =
                            FirebaseAuth.instance.currentUser?.uid;

                        final _roomId =
                            chatRoomId(_firebaseUser ?? '', widget.staffId);
                        FirebaseFirestore _firestore =
                            FirebaseFirestore.instance;
                        final _userInfo = await _firestore
                            .collection('users')
                            .doc(widget.staffId)
                            .get();

                        print('${_userInfo.data()}');

                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                ChangeNotifierProvider.value(
                              value: _provider,
                              builder: (context, child) => ChatRoom(
                                chatRoomId: _roomId,
                                userMap: _userInfo.data()!,
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : SizedBox(),
            ],
          ),
        ],
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
