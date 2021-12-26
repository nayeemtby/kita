import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/colors.dart';
import '../theme/texttheme.dart';

class PrimaryBtn extends StatelessWidget {
  final String txt;
  final bool primary;
  const PrimaryBtn({
    Key? key,
    required this.txt,
    this.primary = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        child: Text(
          txt,
          style: TxtTheme.med17.copyWith(
            color: primary ? MyColors.primaryWhite : MyColors.deepBlack,
          ),
        ),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 13.h),
          primary: primary ? MyColors.primaryBlack : MyColors.secondaryWhite,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          onPrimary: primary ? MyColors.primaryWhite : MyColors.primaryBlack,
        ),
      ),
    );
  }
}
