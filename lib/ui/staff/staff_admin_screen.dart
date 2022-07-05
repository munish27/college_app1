import 'package:alan_voice/alan_voice.dart';
import 'package:clg_app/core/my_preference.dart';
import 'package:clg_app/ui/admin/provider/teacher_provider.dart';
import 'package:clg_app/ui/staff/courses_list_screen.dart';
import 'package:clg_app/ui/staff/staff_class_list_screen.dart';
import 'package:clg_app/ui/staff/staff_logout_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class StaffAdminScreen extends StatefulWidget {
  const StaffAdminScreen({Key? key}) : super(key: key);

  @override
  State<StaffAdminScreen> createState() => _StaffAdminScreenState();
}

class _StaffAdminScreenState extends State<StaffAdminScreen>
    with WidgetsBindingObserver {
  late TeacherProvider _provider;

  @override
  void initState() {
    _provider = TeacherProvider();
    _initAlanButton();

    super.initState();
  }

  void setStatus(String status) async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final FirebaseAuth _auth = FirebaseAuth.instance;
    await _firestore.collection('users').doc(_auth.currentUser!.uid).update({
      "status": status,
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // online
      setStatus("Online");
    } else {
      // offline
      setStatus("Offline");
    }
  }

  void _initAlanButton() {
    AlanVoice.addButton(
      "2cc9a01e864a231d1101b7e8b46945732e956eca572e1d8b807a3e2338fdd0dc/stage",
      buttonAlign: AlanVoice.BUTTON_ALIGN_LEFT,
    );

    void _handleCommand(Map<String, dynamic> command) {
      switch (command["command"]) {
        case "subjects":
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) => ChangeNotifierProvider.value(
                value: _provider,
                builder: (context, child) =>
                    CoursesListScreen(staffId: MyPreference().getMyId()),
              ),
            ),
          );
          break;
        case "students":
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) => ChangeNotifierProvider.value(
                value: _provider,
                builder: (context, child) =>
                    StaffClassListScreen(staffId: MyPreference().getMyId()),
              ),
            ),
          );
          break;
        case "notifications":
          break;
        case "back":
          Navigator.pop(context);
          break;
        default:
          debugPrint("Unknown command");
      }
    }

    AlanVoice.onCommand.add((command) => _handleCommand(command.data));
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _provider,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(child: bodyContainer()),
        appBar: AppBar(
          elevation: 0,
          title: RichText(
            text: TextSpan(
              text: 'Hi,',
              children: [
                const TextSpan(text: ' '),
                TextSpan(
                  text: MyPreference().getName(),
                  style: Theme.of(context).textTheme.headline6,
                ),
              ],
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
          backgroundColor: Colors.white,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) => ChangeNotifierProvider(
                        create: (_) => TeacherProvider(),
                        builder: (context, child) => StaffLogoutScreen(),
                      ),
                    ),
                  );
                },
                icon: SvgPicture.asset('assets/vectors/ic_profile.svg'))
          ],
        ),
      ),
    );
  }

  Widget bodyContainer() => Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50.h),
            _gridItemBuilder(
              title: 'Subjects',
              icon: 'assets/vectors/ic_department.svg',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        ChangeNotifierProvider.value(
                      value: _provider,
                      builder: (context, child) =>
                          CoursesListScreen(staffId: MyPreference().getMyId()),
                    ),
                  ),
                );
              },
              color: Color(0xff009CDE),
            ),
            _gridItemBuilder(
              title: 'Students',
              icon: 'assets/vectors/ic_students.svg',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        ChangeNotifierProvider.value(
                      value: _provider,
                      builder: (context, child) => StaffClassListScreen(
                          staffId: MyPreference().getMyId()),
                    ),
                  ),
                );
              },
              color: Color(0xffF9B853),
            ),
            _gridItemBuilder(
              title: 'Chat',
              icon: 'assets/vectors/ic_students.svg',
              onTap: () {
                // Navigator.of(context)
                //     .push(MaterialPageRoute(builder: (_) => ChatScreen()));
              },
              color: Color(0xffF9B853),
            ),
            _gridItemBuilder(
              title: 'Notifications',
              icon: 'assets/vectors/ic_department.svg',
              onTap: () {},
              color: Color(0xffA5A6F6),
            ),
          ],
        ),
      );

  Widget _gridItemBuilder({
    required String title,
    required String icon,
    required Color color,
    required Function() onTap,
  }) =>
      GestureDetector(
        onTap: onTap,
        child: Container(
          width: 1.sw,
          height: 120.h,
          margin: EdgeInsets.only(bottom: 17.h),
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 21.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.w),
            color: color,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //title
              Text(
                title,
                style: Theme.of(context).textTheme.subtitle1?.copyWith(
                      // color: Color(0xff2C2C2E)÷
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),

              SvgPicture.asset(
                icon,
                color: Colors.white,
                width: 80.w,
                height: 80.w,
              ),
            ],
          ),
        ),
      );
}
