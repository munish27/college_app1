import 'package:clg_app/core/my_preference.dart';
import 'package:clg_app/data/entities/student_entity.dart';
import 'package:clg_app/data/remote/api_response.dart';
import 'package:clg_app/ui/admin/provider/teacher_provider.dart';
import 'package:clg_app/ui/chat_room.dart';
import 'package:clg_app/ui/reusable_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class StudentListScreen extends StatefulWidget {
  late String classId;
  StudentListScreen({Key? key, required this.classId}) : super(key: key);

  @override
  State<StudentListScreen> createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  late TeacherProvider _provider;

  String chatRoomId(String user1, String user2) {
    if (user1[0].toLowerCase().codeUnits[0] >
        user2.toLowerCase().codeUnits[0]) {
      return "$user1$user2";
    } else {
      return "$user2$user1";
    }
  }

  @override
  void initState() {
    _provider = Provider.of<TeacherProvider>(context, listen: false);
    _provider.getStudents(classId: widget.classId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _provider,
      child: Scaffold(
        backgroundColor: Color(0xffF8FAFF),
        appBar: appbar(context: context, title: 'Students'),
        body: bodyContainer(),
      ),
    );
  }

  Widget bodyContainer() =>
      Consumer<TeacherProvider>(builder: (context, value, child) {
        if (value.students.isNotEmpty) {
          return _listBuilder(value.students);
        } else if (value.status == STATUS.LOADING) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return const SizedBox();
        }
      });

  Widget _listBuilder(List<StudentEntity> students) => ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 21.h),
        itemBuilder: (_, index) => _itemBuilder(
          name: students[index].sName,
          semester: students[index].semName,
          department: students[index].dName,
          onTap: () async {
            final _firebaseUser = FirebaseAuth.instance.currentUser?.uid;
            final _roomId =
                chatRoomId(students[index].sId, _firebaseUser ?? '');

            FirebaseFirestore _firestore = FirebaseFirestore.instance;
            final _userInfo = await _firestore
                .collection('users')
                .doc(students[index].sId)
                .get();

            print('${_userInfo.data()}');
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => ChangeNotifierProvider.value(
                  value: _provider,
                  builder: (context, child) => ChatRoom(
                    chatRoomId: _roomId,
                    userMap: _userInfo.data()!,
                  ),
                ),
              ),
            );
          },
        ),
        separatorBuilder: (_, __) => SizedBox(height: 10.h),
        itemCount: students.length,
      );

  Widget _itemBuilder({
    required String name,
    required String semester,
    required String department,
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
                department,
                style: Theme.of(context).textTheme.caption?.copyWith(
                      color: Colors.grey.shade500,
                    ),
              ),
              SizedBox(height: 20.h),
              Text(
                semester,
                style: Theme.of(context).textTheme.subtitle2,
              ),
              MyPreference().getUserType() == 1
                  ? Align(
                      alignment: Alignment.bottomRight,
                      child:
                          IconButton(icon: Icon(Icons.send), onPressed: onTap))
                  : SizedBox(),
            ],
          ),
        ),
      );
}
