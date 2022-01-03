import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kita/screens/components/my_models.dart';
import 'theme/colors.dart';
import 'theme/texttheme.dart';

class ProfilePage extends StatelessWidget {
  final UserData data;
  const ProfilePage({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String bgTxt = '';
    data.name.split(' ').forEach(
      (element) {
        if (element.isNotEmpty) {
          bgTxt += element[0];
        }
      },
    );
    bgTxt = bgTxt.toUpperCase();
    DateTime? date = FirebaseAuth.instance.currentUser!.metadata.creationTime;
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
            physics: const BouncingScrollPhysics(),
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
                      foregroundImage: data.imgurl.isEmpty
                          ? null
                          : NetworkImage(
                              data.imgurl,
                            ),
                      child: bgTxt.isEmpty
                          ? null
                          : SizedBox.square(
                              dimension: 88.r * 2 / 1.414,
                              child: FittedBox(
                                alignment: Alignment.center,
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  bgTxt,
                                  style: TxtTheme.montyBig.copyWith(
                                    color: MyColors.primaryWhite,
                                    fontSize: 88.r,
                                  ),
                                ),
                              ),
                            ),
                    ),
                  ),
                  Text(
                    data.name.isEmpty ? 'No Name' : data.name,
                    style: TxtTheme.med32
                        .copyWith(color: MyColors.deepBlack, fontSize: 36.sp),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Text(
                    data.email.isEmpty ? 'No email' : data.email,
                    textAlign: TextAlign.center,
                    style: TxtTheme.med14
                        .copyWith(color: MyColors.deepBlack, height: 1.5.h),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Text(
                    data.phone.isEmpty ? 'No phone number' : data.phone,
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
                          date == null
                              ? 'Created on unknown date'
                              : 'Created on ${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}',
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
