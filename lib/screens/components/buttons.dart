import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/colors.dart';
import '../theme/texttheme.dart';

class PrimaryBtn extends StatelessWidget {
  final String txt;
  Widget? child;
  final bool primary;
  final bool disabled;
  final void Function()? onTap;
  PrimaryBtn({
    Key? key,
    required this.txt,
    this.primary = true,
    required this.onTap,
    this.child,
    this.disabled = false,
  }) : super(key: key) {
    child == null
        ? null
        : child = SizedBox.square(
            dimension:
                getTxtSize(txt: txt, factor: 1, style: TxtTheme.med17).height,
            child: child,
          );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        child: child ??
            SizedBox(
              height:
                  getTxtSize(txt: txt, factor: 1, style: TxtTheme.med17).height,
              child: Center(
                child: Text(
                  txt,
                  style: TxtTheme.med17,
                ),
              ),
            ),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 13.sp),
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

Size getTxtSize(
    {required String txt,
    int maxLines = 1,
    required double factor,
    required TextStyle style}) {
  return (TextPainter(
          maxLines: maxLines,
          text: TextSpan(text: txt, style: style),
          textDirection: TextDirection.ltr,
          textScaleFactor: factor)
        ..layout())
      .size;
}
