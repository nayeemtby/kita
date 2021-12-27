import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kita/screens/components/users.dart';
import 'theme/colors.dart';
import 'theme/texttheme.dart';
import 'components/input.dart';

class UsersPage extends StatelessWidget {
  final void Function() showAddPage;
  const UsersPage({
    Key? key,
    required this.showAddPage,
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
              'User List',
              style: TxtTheme.med18.copyWith(
                color: MyColors.deepBlack,
              ),
            ),
          ),
        ),
        Divider(
          thickness: 1.sp,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.person_outline_rounded,
                      size: 24.sp,
                    ),
                    Text(
                      'Total User\n15',
                      textAlign: TextAlign.center,
                      style: TxtTheme.med14.copyWith(
                        color: MyColors.deepBlack,
                      ),
                    )
                  ],
                ),
              ),
              Material(
                borderRadius: BorderRadius.circular(7.r),
                color: MyColors.deepBlack,
                child: InkWell(
                  onTap: () {
                    showAddPage();
                  },
                  borderRadius: BorderRadius.circular(7.r),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 14.w,
                      vertical: 6.h,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.person_add_alt,
                          size: 14.sp,
                          color: MyColors.primaryWhite,
                        ),
                        SizedBox(
                          width: 6.w,
                        ),
                        Text(
                          'Add New User',
                          style: TxtTheme.reg13.copyWith(
                            color: MyColors.primaryWhite,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TxtInput(
                hint: 'Search',
                leading: Padding(
                  padding: EdgeInsets.only(left: 4.w),
                  child: Icon(
                    Icons.search,
                    size: 24.h,
                  ),
                ),
              ),
              SizedBox(
                height: 14.h,
              ),
              Divider(
                thickness: 1.h,
                height: 1.h,
              ),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(15, (index) => const UserItem()),
              ),
            ),
          ),
        )
      ],
    );
  }
}
