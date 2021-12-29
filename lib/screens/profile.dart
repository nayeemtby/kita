import 'package:firebase_auth_rest/firebase_auth_rest.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'theme/colors.dart';
import 'theme/texttheme.dart';

class ProfilePage extends StatelessWidget {
  final UserData? data;
  const ProfilePage({
    Key? key,
    this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: 14.h,
          ),
          child: Center(
            child: Text(
              'Profile',
              style: TxtTheme.med18.copyWith(
                color: MyColors.deepBlack,
              ),
            ),
          ),
        ),
        Divider(
          thickness: 1.sp,
          height: 1.sp,
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 16.h,
                      bottom: 24.h,
                    ),
                    child: CircleAvatar(
                      radius: 88.r,
                    ),
                  ),
                  Text(
                    'Mr. John Doe',
                    style: TxtTheme.med32
                        .copyWith(color: MyColors.deepBlack, fontSize: 36.sp),
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  Text(
                    '${data == null ? 'user@host.domain' : data!.email ?? 'Has no Email'}\nPassword',
                    textAlign: TextAlign.center,
                    style: TxtTheme.med14
                        .copyWith(color: MyColors.deepBlack, height: 1.5.h),
                  ),
                  Text(
                    'Phone: *88012xxxxxxxx',
                    style: TxtTheme.med18.copyWith(
                      color: MyColors.deepBlack,
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    elevation: 2,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      child: Center(
                        child: Text(
                          'Created on 12/12/2021 06.30 AM',
                          style: TxtTheme.med14.copyWith(
                            color: MyColors.primaryGray,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 14.h,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 16.sp,
                          color: MyColors.primaryGray,
                        ),
                        SizedBox(
                          width: 6.w,
                        ),
                        Text(
                          'Location',
                          style: TxtTheme.med16.copyWith(
                            color: MyColors.primaryGray,
                          ),
                        )
                      ],
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        5.r,
                      ),
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: EdgeInsets.all(
                          10.r,
                        ),
                        child: Image.asset(
                          'assets/map.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
