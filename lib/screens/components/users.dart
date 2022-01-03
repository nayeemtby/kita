import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kita/screens/components/my_models.dart';
import 'package:kita/screens/theme/colors.dart';
import 'package:kita/screens/theme/texttheme.dart';

class UserItem extends StatelessWidget {
  final UserData data;
  final void Function(String)? remove;
  final String id;
  const UserItem({
    Key? key,
    this.id = '',
    required this.data,
    this.remove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String bgTxt = '';
    data.name.split(' ').forEach(
      (element) {
        bgTxt += element[0];
      },
    );
    bgTxt = bgTxt.toUpperCase();
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
                foregroundImage: data.imgurl.isEmpty
                    ? null
                    : NetworkImage(
                        data.imgurl,
                      ),
                child: bgTxt.isEmpty
                    ? null
                    : SizedBox.square(
                        dimension: 24.r * 2 / 1.414,
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
              SizedBox(
                width: 8.w,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.name,
                    style: TxtTheme.reg17.copyWith(
                      color: MyColors.deepBlack,
                    ),
                  ),
                  Text(
                    data.email,
                    style: TxtTheme.reg13.copyWith(
                      color: MyColors.primaryGray,
                    ),
                  )
                ],
              )
            ],
          ),
          CupertinoButton(
            padding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 4.h,
            ),
            child: Text(
              'Remove',
              style: TxtTheme.reg13,
            ),
            onPressed: () {
              if (remove != null && id.isNotEmpty) {
                showCupertinoDialog(
                  context: context,
                  builder: (ctx) => Alert(
                    ontap: remove!,
                    id: id,
                  ),
                );
              }
            },
          )
          // InkWell(
          //   onTap: () {
          //     showCupertinoDialog(
          //       context: context,
          //       builder: (ctx) => const Alert(),
          //     );
          //   },
          //   child: Container(
          // padding: EdgeInsets.symmetric(
          //   horizontal: 12.w,
          //   vertical: 4.h,
          // ),
          //       decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(7.r),
          //         color: MyColors.silver,
          //       ),
          //       child: CupertinoButton(
          // child: Text(
          //   'Remove',
          //   style: TxtTheme.reg13,
          // ),
          //         onPressed: () {},
          //       )),
          // )
        ],
      ),
    );
  }
}

class Alert extends StatelessWidget {
  final void Function(String) ontap;
  final String id;
  const Alert({Key? key, required this.ontap, required this.id})
      : super(key: key);

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
          onPressed: () {
            Navigator.pop(context);
            ontap(id);
          },
        )
      ],
    );
  }
}
