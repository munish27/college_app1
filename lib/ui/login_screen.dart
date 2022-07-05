import 'package:clg_app/core/my_preference.dart';
import 'package:clg_app/data/remote/api_response.dart';
import 'package:clg_app/ui/admin/dashboard_admin_screen.dart';
import 'package:clg_app/ui/admin/provider/admin_provider.dart';
import 'package:clg_app/ui/reusable_widgets.dart';
import 'package:clg_app/ui/staff/staff_admin_screen.dart';
import 'package:clg_app/ui/students/student_admin_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late LoginProvider _provider;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _provider = LoginProvider();
    _provider.addListener(() {
      if (_provider.status == STATUS.SUCCESS) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => MyPreference().getUserType() == 0
                ? DashboardAdminScreen()
                : MyPreference().getUserType() == 1
                    ? StaffAdminScreen()
                    : StudentAdminScreen()),
            (route) => false);
      } else if (_provider.status != STATUS.LOADING &&
          _provider.status == STATUS.ERROR&&_provider.errMsg!=null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(_provider.errMsg!)));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _provider,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Consumer<LoginProvider>(builder: (context, value, child) {
            if (value.status == STATUS.LOADING) {
              return const CircularProgressIndicator();
            } else {
              return _form();
            }
          }),
        ),
      ),
    );
  }

  Widget _form() => ListView(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              'Log in to your Account',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              'Welcome back, please enter your details.',
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
          SizedBox(height: 80.h),
          myTextFeild(
            context,
            title: 'Email',
            keyboardType: TextInputType.emailAddress,
            controller: _emailController,
          ),
          SizedBox(height: 20.h),
          myTextFeild(
            context,
            title: 'Password',
            obscureText: true,
            controller: _passwordController,
          ),
          SizedBox(height: 35.h),
          myButton(
            context,
            title: 'Login',
            onPressed: () {
              _provider.getLogin(
                  _emailController.value.text, _passwordController.value.text);
            },
          ),
        ],
      );
}
