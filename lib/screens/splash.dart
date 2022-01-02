import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kita/screens/theme/texttheme.dart';
import 'package:kita/screens/welcome.dart';
import 'theme/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScr extends StatelessWidget {
  const SplashScr({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double bigRadius = 254.r;
    final double mediumRadius = 78.r;
    final double smallRadius = 26.r;
    Timer(
      const Duration(
        seconds: 2,
      ),
      () {
        Navigator.pushReplacement(
          context,
          CupertinoPageRoute(
            builder: (ctx) => const WelcomeScr(),
          ),
        );
      },
    );
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: ClipRect(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Transform.translate(
                offset: Offset(-20.w, -54.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: bigRadius,
                      height: bigRadius,
                      decoration: BoxDecoration(
                        color: MyColors.bubbleColor,
                        borderRadius: BorderRadius.circular(bigRadius / 2),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: smallRadius,
                            ),
                            Container(
                              width: smallRadius,
                              height: smallRadius,
                              decoration: BoxDecoration(
                                color: MyColors.bubbleColor,
                                borderRadius:
                                    BorderRadius.circular(smallRadius / 2),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 33.h,
                        ),
                        Container(
                          width: mediumRadius,
                          height: mediumRadius,
                          decoration: BoxDecoration(
                            color: MyColors.bubbleColor,
                            borderRadius:
                                BorderRadius.circular(mediumRadius / 2),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "TestMe",
                    style:
                        TxtTheme.montyBig.copyWith(color: MyColors.deepBlack),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: MyColors.deepBlack,
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                    child: Text(
                      "USER AUTHENTICA",
                      style: TxtTheme.montySmall
                          .copyWith(color: MyColors.primaryWhite),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: bigRadius,
              )
            ],
          ),
        ),
      ),
    );
  }
}
