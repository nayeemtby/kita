import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'components/buttons.dart';
import 'theme/texttheme.dart';
import 'theme/colors.dart';

class WelcomeScr extends StatelessWidget {
  const WelcomeScr({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 116.h),
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/welcome.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "TestMe",
              style: TxtTheme.montyBig.copyWith(color: MyColors.primaryWhite),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: MyColors.deepBlack,
                borderRadius: BorderRadius.circular(5.r),
              ),
              child: Text(
                "USER AUTHENTICA",
                style:
                    TxtTheme.montySmall.copyWith(color: MyColors.primaryWhite),
              ),
            ),
            SizedBox(
              height: 42.h,
            ),
            const PrimaryBtn(txt: 'Login'),
            SizedBox(
              height: 13.h,
            ),
            const PrimaryBtn(
              txt: 'Sign Up',
              primary: false,
            )
          ],
        ),
      ),
    );
  }
}
