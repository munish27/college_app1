import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeUtil {
  const ThemeUtil._();

  static TextTheme get _textTheme => GoogleFonts.ralewayTextTheme();

  static TextStyle? get _heading6 => _textTheme.headline6?.copyWith(
        fontSize: 20.sp,
        fontFamily: 'Raleway-Bold',
      );

  static TextStyle? get _bodyText1 => _textTheme.bodyText1?.copyWith(
        fontSize: 16.sp,
        fontFamily: 'Raleway-Regular',
      );

  static TextStyle? get _bodyText2 => _textTheme.bodyText2?.copyWith(
        fontSize: 14.sp,
        fontFamily: 'Raleway-Regular',
      );

  static TextStyle? get _subtitle1 => _textTheme.subtitle1?.copyWith(
        fontSize: 16.sp,
        fontFamily: 'Raleway-SemiBold',
        fontWeight: FontWeight.bold,
      );

  static TextStyle? get _subtitle2 => _textTheme.subtitle2?.copyWith(
        fontSize: 14.sp,
        fontFamily: 'Raleway-SemiBold',
      );

  static TextStyle? get _button => _textTheme.button?.copyWith(
        fontSize: 14.sp,
        fontFamily: 'Raleway-SemiBold',
      );

  static TextStyle? get _caption => _textTheme.caption?.copyWith(
        fontSize: 12.sp,
        fontFamily: 'Raleway-Regular',
        color: Color(0xff1B2B41).withOpacity(.72)
      );

  static TextTheme get init => TextTheme(
        headline6: _heading6,
        subtitle1: _subtitle1,
        subtitle2: _subtitle2,
        bodyText1: _bodyText1,
        bodyText2: _bodyText2,
        caption: _caption,
      );
}
