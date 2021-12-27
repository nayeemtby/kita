import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kita/screens/theme/colors.dart';
import 'package:kita/screens/theme/texttheme.dart';

class UserItem extends StatelessWidget {
  const UserItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 24.r,
              ),
              SizedBox(
                width: 8.w,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Name',
                    style: TxtTheme.reg17.copyWith(
                      color: MyColors.deepBlack,
                    ),
                  ),
                  Text(
                    'Email',
                    style: TxtTheme.reg13.copyWith(
                      color: MyColors.primaryGray,
                    ),
                  )
                ],
              )
            ],
          ),
          InkWell(
            onTap: () {
              showCupertinoDialog(
                context: context,
                builder: (ctx) => const Alert(),
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 12.w,
                vertical: 4.h,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7.r),
                color: MyColors.silver,
              ),
              child: Text(
                'Remove',
                style: TxtTheme.reg13.copyWith(
                  color: MyColors.primaryBlack,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Alert extends StatelessWidget {
  const Alert({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(
        'Remove this user?',
        style: TxtTheme.med16,
      ),
      actions: [
        CupertinoDialogAction(
          child: const Text(
            'Cancel',
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        CupertinoDialogAction(
          isDestructiveAction: true,
          child: const Text(
            'Yes',
          ),
          onPressed: () {},
        )
      ],
    );
  }
}
