import 'package:clg_app/core/my_preference.dart';
import 'package:clg_app/data/entities/staff_detail_entity.dart';
import 'package:clg_app/data/remote/api_response.dart';
import 'package:clg_app/ui/admin/provider/teacher_provider.dart';
import 'package:clg_app/ui/onboarding_screen.dart';
import 'package:clg_app/ui/reusable_widgets.dart';
import 'package:clg_app/ui/staff/courses_list_screen.dart';
import 'package:clg_app/ui/staff/staff_class_list_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class StaffLogoutScreen extends StatefulWidget {
  StaffLogoutScreen({Key? key}) : super(key: key);

  @override
  State<StaffLogoutScreen> createState() => _StaffLogoutScreenState();
}

class _StaffLogoutScreenState extends State<StaffLogoutScreen> {
  late TeacherProvider _provider;

  @override
  void initState() {
    _provider = Provider.of<TeacherProvider>(context, listen: false);
    Future.delayed(Duration(seconds: 0), () {
      _provider.getStaffInfo(MyPreference().getMyId());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _provider,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: appbar(context: context, title: 'My Info'),
        body: bodyContainer(),
      ),
    );
  }

  Widget bodyContainer() =>
      Consumer<TeacherProvider>(builder: (context, value, child) {
        if (value.status == STATUS.LOADING) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (value.staffInfo != null) {
          return _detailView(value.staffInfo!);
        } else {
          return const Center(
            child: Text('No data Found'),
          );
        }
      });

  Widget _detailView(StaffDetailEntity _staff) => ListView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        shrinkWrap: true,
        children: [
          Align(
            alignment: Alignment.center,
            child: SvgPicture.asset(
              'assets/vectors/ic_profile.svg',
              width: 84.w,
              height: 84.w,
            ),
          ),
          SizedBox(height: 20.h),
          //user info
          Align(
            alignment: Alignment.center,
            child: Text(
              _staff.stName!.toUpperCase(),
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          SizedBox(height: 20.h),
          _infoBuilder(title: 'Gender', value: _staff.gender),
          _infoBuilder(title: 'DOB', value: _staff.dob),
          _infoBuilder(title: 'Email', value: _staff.email),
          _infoBuilder(title: 'Contact', value: _staff.contact),
          _infoBuilder(title: 'Department', value: _staff.dName),
          _infoBuilder(title: 'Semester', value: _staff.semName),
          _infoBuilder(title: 'Address', value: _staff.stAddress),
          SizedBox(height: 50.h),
          myButton(context, title: 'Logout', onPressed: () async {
            if (await MyPreference().dropPreferences()) {
              FirebaseAuth.instance.signOut();
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => OnboardingScreen()),
                  (route) => false);
            }
          }),
          SizedBox(height: 20.h),
          myButton(context, title: 'Reset Password', onPressed: () async {
            final _data = await _provider.resetPassword();

            if (_data != null) {
              if (!await launchUrlString(_data!))
                throw 'Could not launch $_data';
            }
          }),
        ],
      );

  Widget _itemBuilder({
    required String title,
    required String icon,
    required Function() onTap,
  }) =>
      GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.w),
            color: Color(0xffF6F8FD),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                icon,
                color: Color(0xff1A5CCE),
                width: 60.w,
                height: 60.w,
              ),
              Text(
                title,
                style: Theme.of(context).textTheme.subtitle1?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Color(0xff1A5CCE),
                    ),
              ),
            ],
          ),
        ),
      );

  Widget _infoBuilder({
    required String title,
    String? value,
  }) =>
      Visibility(
          visible: value != null && value.isNotEmpty ? true : false,
          child: Container(
            margin: EdgeInsets.only(bottom: 10.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.caption?.copyWith(
                          color: Colors.grey.shade500,
                        ),
                  ),
                  flex: 1,
                ),
                Text(
                  ' : ',
                  style: Theme.of(context).textTheme.caption?.copyWith(
                        color: Colors.grey.shade500,
                      ),
                ),
                Expanded(
                    child: Text(
                  value ?? '',
                  style: Theme.of(context).textTheme.subtitle2,
                )),
              ],
            ),
          ));
}
