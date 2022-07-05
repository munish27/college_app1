import 'package:clg_app/core/my_preference.dart';
import 'package:clg_app/core/theme_util.dart';
import 'package:clg_app/ui/admin/dashboard_admin_screen.dart';
import 'package:clg_app/ui/onboarding_screen.dart';
import 'package:clg_app/ui/staff/staff_admin_screen.dart';
import 'package:clg_app/ui/students/student_admin_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await MyPreference().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (_) => MaterialApp(
        title: 'College Monitor',
        theme: ThemeData(
          textTheme: ThemeUtil.init,
          primarySwatch: Colors.blue,
        ),
        home: MyPreference().getToken() != null &&
                MyPreference().getToken().isNotEmpty
            ? MyPreference().getUserType() == 0
                ? const DashboardAdminScreen()
                : MyPreference().getUserType() == 1
                    ? const StaffAdminScreen()
                    : const StudentAdminScreen()
            : const OnboardingScreen(),
      ),
    );
  }
}
