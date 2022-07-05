import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget myTextFeild(
  BuildContext context, {
  required String title,
  String? hint,
  required TextEditingController controller,
  bool obscureText = false,
  TextInputType? keyboardType,
  FormFieldValidator<String>? validator,
  bool? enabled,
}) =>
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //title
        Text(
          title,
          style: Theme.of(context).textTheme.caption,
        ),
        SizedBox(height: 5.h),
        TextFormField(
          enabled: enabled,
          obscureText: obscureText,
          keyboardType: keyboardType,
          controller: controller,
          validator: validator,
          style: Theme.of(context).textTheme.bodyText2,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.w),
              borderSide: BorderSide(
                color: const Color(0xff1C375A).withOpacity(.2),
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.w),
              borderSide: BorderSide(
                color: const Color(0xff1C375A).withOpacity(.2),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.w),
              borderSide: BorderSide(
                color: const Color(0xff1C375A).withOpacity(.2),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.w),
              borderSide: BorderSide(
                color: const Color(0xff1C375A).withOpacity(.2),
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.w),
              borderSide: BorderSide(
                color: const Color(0xff1C375A).withOpacity(.2),
              ),
            ),
          ),
        ),
      ],
    );

Widget myButton(
  BuildContext context, {
  required String title,
  required VoidCallback? onPressed,
}) =>
    ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        textStyle: Theme.of(context).textTheme.button,
        primary: Color(0xff6AE099),
        elevation: 0,
        minimumSize: Size.fromHeight(58.h),
        maximumSize: Size.fromHeight(58.h),
      ),
      child: Text(title),
    );

PreferredSizeWidget appbar({
  required BuildContext context,
  required String title,
  Function()? onBackPressed,
  List<Widget>? actions,
}) {
  return PreferredSize(
    child: AppBar(
      actions: actions,
      elevation: 0,
      backgroundColor: Colors.white,
      titleSpacing: 0,
      leading: IconButton(
        icon: Icon(
          CupertinoIcons.chevron_left,
        ),
        color: Colors.black,
        onPressed: onBackPressed != null
            ? onBackPressed
            : () {
                Navigator.of(context).pop();
              },
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.headline6,
      ),
      centerTitle: Platform.isAndroid ? false : true,
    ),
    preferredSize: Size.fromHeight(kToolbarHeight),
  );
}
