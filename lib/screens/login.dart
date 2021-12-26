import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'theme/colors.dart';
import 'theme/texttheme.dart';
import 'components/input.dart';
import 'components/buttons.dart';

class LoginScr extends StatelessWidget {
  const LoginScr({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 14.h,
                  ),
                  child: Row(
                    children: [
                      CupertinoButton(
                        padding: const EdgeInsets.all(0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.arrow_back_ios_new_rounded,
                              size: 17.sp,
                              color: MyColors.primaryBlue,
                            ),
                            Text(
                              'Back',
                              style: TxtTheme.reg17.copyWith(
                                color: MyColors.primaryBlue,
                              ),
                            )
                          ],
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 40.h,
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Login',
                          style: TxtTheme.med32.copyWith(
                            color: MyColors.deepBlack,
                          ),
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        Text(
                          'Enter your email address and password to access your account',
                          style: TxtTheme.reg20.copyWith(
                            color: MyColors.secondaryBlack,
                          ),
                        ),
                        SizedBox(
                          height: 100.h,
                        ),
                        const TxtInput(
                          hint: 'Email',
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        TxtInput(
                          hint: 'Password',
                          password: true,
                          suffix: Icon(
                            Icons.visibility,
                            color: MyColors.secondaryBlack,
                            size: 24.sp,
                          ),
                        ),
                        SizedBox(
                          height: 60.h,
                        ),
                        PrimaryBtn(
                          txt: 'Login',
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: 40.h,
                    ),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Don’t have an account? ',
                            style: TxtTheme.med16.copyWith(
                              color: MyColors.secondaryBlack,
                            ),
                          ),
                          CupertinoButton(
                            padding: const EdgeInsets.all(0),
                            child: Text(
                              'Sign Up',
                              style: TxtTheme.med16,
                            ),
                            onPressed: () {},
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
