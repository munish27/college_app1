import 'package:alan_voice/alan_voice.dart';
import 'package:clg_app/core/my_preference.dart';
import 'package:clg_app/ui/admin/departments_admin_screen.dart';
import 'package:clg_app/ui/notification_screen.dart';
import 'package:clg_app/ui/onboarding_screen.dart';
import 'package:clg_app/ui/staff/teachers_list_screen.dart';
import 'package:clg_app/ui/students/student_list_dashboard_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class DashboardAdminScreen extends StatefulWidget {
  const DashboardAdminScreen({Key? key}) : super(key: key);

  @override
  State<DashboardAdminScreen> createState() => _DashboardAdminScreenState();
}

class _DashboardAdminScreenState extends State<DashboardAdminScreen> {
  @override
  void initState() {
    _initAlanButton();
    super.initState();
  }

  void _initAlanButton() {
    AlanVoice.addButton(
      "2cc9a01e864a231d1101b7e8b46945732e956eca572e1d8b807a3e2338fdd0dc/stage",
      buttonAlign: AlanVoice.BUTTON_ALIGN_LEFT,
    );

    void _handleCommand(Map<String, dynamic> command) {
      switch (command["command"]) {
        case "departments":
          Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => DepartmentsAdminScreen()));
          break;
        case "teachers":
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => TeachersListScreen()));
          break;
        case "students":
          Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => StudentListDashboardScreen()));
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: RichText(
          text: TextSpan(
            text: 'Hi,',
            children: [
              TextSpan(text: ' '),
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
              onPressed: () async {
                if (await MyPreference().dropPreferences()) {
                  FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (_) => OnboardingScreen()),
                      (route) => false);
                }
              },
              icon: Icon(
                Icons.logout,
                color: Colors.black,
              )),
        ],
      ),
      body: SafeArea(child: bodyContainer()),
    );
  }

  Widget bodyContainer() => Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50.h),
            _gridItemBuilder(
              title: 'Departments',
              icon: 'assets/vectors/ic_department.svg',
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => DepartmentsAdminScreen()));
              },
              color: Color(0xff009CDE),
            ),
            _gridItemBuilder(
              title: 'Teachers',
              icon: 'assets/vectors/ic_teachers.svg',
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => TeachersListScreen()));
              },
              color: Color(0xff53D769),
            ),
            _gridItemBuilder(
              title: 'Students',
              icon: 'assets/vectors/ic_students.svg',
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => StudentListDashboardScreen()));
              },
              color: Color(0xffF9B853),
            ),
            _gridItemBuilder(
              title: 'Notifications',
              icon: 'assets/vectors/ic_department.svg',
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => NotificationScreen()));
              },
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
