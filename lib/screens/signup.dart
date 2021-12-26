import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'theme/colors.dart';
import 'theme/texttheme.dart';
import 'components/input.dart';
import 'components/buttons.dart';

class SignupScr extends StatefulWidget {
  const SignupScr({Key? key}) : super(key: key);

  @override
  State<SignupScr> createState() => _SignupScrState();
}

class _SignupScrState extends State<SignupScr> {
  int _gender = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              SizedBox(
                height: 10.h,
              ),
              Text(
                'Sign up',
                style: TxtTheme.med32.copyWith(
                  color: MyColors.deepBlack,
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
              Center(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    CircleAvatar(
                      radius: 56.r,
                    ),
                    Positioned(
                      bottom: -10.r,
                      left: 5.r,
                      child: CircleAvatar(
                        radius: 20.r,
                        backgroundColor: MyColors.deepBlack,
                        child: Icon(
                          Icons.camera_alt,
                          size: 20.r,
                          color: MyColors.primaryWhite,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 60.h,
              ),
              TxtInput(
                hint: 'Name',
              ),
              SizedBox(
                height: 12.h,
              ),
              TxtInput(hint: 'Email'),
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
                height: 12.h,
              ),
              TxtInput(
                hint: 'Mobile Number',
                password: true,
                suffix: CupertinoButton(
                  child: Text(
                    'Verify',
                    style: TxtTheme.reg15,
                  ),
                  onPressed: () {},
                  padding: const EdgeInsets.all(0),
                ),
              ),
              SizedBox(
                height: 14.h,
              ),
              Text(
                'Gender',
                style: TxtTheme.reg19.copyWith(
                  color: MyColors.primaryBlack,
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Male',
                    style: TxtTheme.reg19.copyWith(
                      color: MyColors.deepBlack,
                    ),
                  ),
                  SizedBox(
                    width: 16.w,
                  ),
                  Radio<int>(
                    fillColor: MaterialStateProperty.all(MyColors.deepBlack),
                    value: 0,
                    groupValue: _gender,
                    onChanged: (Object? value) {
                      setState(() {
                        _gender = value as int;
                      });
                    },
                  ),
                  SizedBox(
                    width: 42.w,
                  ),
                  Text(
                    'Female',
                    style: TxtTheme.reg19.copyWith(
                      color: MyColors.deepBlack,
                    ),
                  ),
                  SizedBox(
                    width: 16.w,
                  ),
                  Radio<int>(
                    fillColor: MaterialStateProperty.all(MyColors.deepBlack),
                    value: 1,
                    groupValue: _gender,
                    onChanged: (Object? value) {
                      setState(() {
                        _gender = value as int;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 32.h,
              ),
              PrimaryBtn(
                txt: 'Sign up',
                onTap: () {},
              ),
              Expanded(
                  child: Padding(
                padding: EdgeInsets.only(bottom: 36.h),
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Already have an account? ',
                        style: TxtTheme.med16.copyWith(
                          color: MyColors.secondaryBlack,
                        ),
                      ),
                      CupertinoButton(
                        padding: const EdgeInsets.all(0),
                        child: Text(
                          'Login',
                          style: TxtTheme.med16,
                        ),
                        onPressed: () {},
                      )
                    ],
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
    ));
  }
}
