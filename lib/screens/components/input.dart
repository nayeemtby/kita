import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kita/screens/theme/colors.dart';
import 'package:kita/screens/theme/texttheme.dart';

class TxtInput extends StatelessWidget {
  final String hint;
  final bool password;
  final Widget? suffix;
  final Widget? leading;
  final TextEditingController? controller;
  final bool hidePassword;
  const TxtInput({
    Key? key,
    required this.hint,
    this.password = false,
    this.suffix,
    this.leading,
    this.controller,
    this.hidePassword = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: password ? hidePassword : false,
      cursorColor: MyColors.deepBlack,
      style: TxtTheme.reg16.copyWith(
        color: MyColors.primaryBlack,
      ),
      decoration: InputDecoration(
        prefixIcon: leading,
        label: Text(
          hint,
        ),
        labelStyle: TxtTheme.reg16.copyWith(
          color: MyColors.primaryGray,
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: 16.h,
          horizontal: 14.w,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.r),
          borderSide: BorderSide.none,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        filled: true,
        fillColor: MyColors.secondaryGray,
        suffix: suffix,
      ),
    );
  }
}
