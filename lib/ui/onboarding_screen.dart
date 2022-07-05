import 'package:clg_app/core/color_util.dart';
import 'package:clg_app/core/my_preference.dart';
import 'package:clg_app/ui/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: bodyContainer(),
    );
  }

  Widget bodyContainer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        itemBuilder(
          title: 'Admin',
          subTitle: 'Manage College System',
          onTap: () async {
            await MyPreference().setUserType(0);
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => const LoginScreen()));
          },
          color: const Color.fromARGB(255, 189, 189, 213),
          icon: 'assets/vectors/ic_admin.svg',
        ),
        itemBuilder(
          title: 'Teacher',
          subTitle: 'Manage Student related Info',
          onTap: () async {
            await MyPreference().setUserType(1);
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => LoginScreen()));
          },
          color: ColorUtil.TeacherCardColor,
          icon: 'assets/vectors/ic_teacher.svg',
        ),
        itemBuilder(
          title: 'Student',
          subTitle: 'View Student Info',
          onTap: () async {
            await MyPreference().setUserType(2);
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => const LoginScreen()));
          },
          color: ColorUtil.StudentCardColor,
          icon: 'assets/vectors/ic_student.svg',
        ),
      ],
    );
  }

  Widget itemBuilder({
    required String title,
    required String subTitle,
    required Function() onTap,
    required Color color,
    required String icon,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 1.sw,
        margin: EdgeInsets.only(left: 24.w, right: 24.w, top: 82.h),
        padding: EdgeInsets.symmetric(horizontal: 12.67.w, vertical: 16.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.w),
          color: color,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //Title &sub
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title),
                SizedBox(height: 7.h),
                Text(subTitle),
              ],
            ),
            //icon
            SvgPicture.asset(
              icon,
              width: 127.78.w,
              height: 122.h,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}
