import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kita/screens/components/firebase.dart';
import 'package:kita/screens/components/my_models.dart';
import 'package:kita/screens/home.dart';
import 'package:kita/screens/signup.dart';
import 'theme/colors.dart';
import 'theme/texttheme.dart';
import 'components/input.dart';
import 'components/buttons.dart';

class LoginScr extends StatefulWidget {
  const LoginScr({Key? key}) : super(key: key);

  @override
  State<LoginScr> createState() => _LoginScrState();
}

class _LoginScrState extends State<LoginScr> {
  bool hidePass = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);

            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: SizedBox(
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
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
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
                                  TxtInput(
                                    hint: 'Email',
                                    controller: _emailController,
                                  ),
                                  SizedBox(
                                    height: 12.h,
                                  ),
                                  TxtInput(
                                    hint: 'Password',
                                    controller: _passwordController,
                                    password: true,
                                    hidePassword: hidePass,
                                    suffix: InkWell(
                                      onTap: () {
                                        setState(() {
                                          hidePass = !hidePass;
                                        });
                                      },
                                      child: Icon(
                                        hidePass
                                            ? Icons.visibility
                                            : Icons.visibility_off_rounded,
                                        color: MyColors.secondaryBlack,
                                        size: 24.sp,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 60.h,
                                  ),
                                  PrimaryBtn(
                                    txt: 'Login',
                                    onTap: () {
                                      if (!isLoading) {
                                        _handleLogin(
                                          _emailController.value.text,
                                          _passwordController.value.text,
                                          context,
                                        );
                                        setState(() {
                                          isLoading = true;
                                        });
                                      }
                                    },
                                    child: isLoading
                                        ? const CircularProgressIndicator(
                                            color: MyColors.primaryWhite,
                                          )
                                        : null,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              bottom: 40.h,
                            ),
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Don\'t have an account? ',
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
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                        context,
                                        CupertinoPageRoute(
                                          builder: (ctx) => const SignupScr(),
                                        ),
                                      );
                                    },
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleLogin(String email, String password, BuildContext ctx) async {
    password = sha256
        .convert(
          utf8.encode(
            password + 'salt',
          ),
        )
        .toString();
    ExceptionAwareResponse<UserCredential> response = ExceptionAwareResponse(
      response: null,
    );
    response = await login(
      email,
      password,
    );
    if (response.error == null && response.response != null) {
      if (response.response!.user != null) {
        DocumentSnapshot<Map<String, dynamic>> doc;
        UserData data;
        try {
          doc = await FirebaseFirestore.instance
              .doc(
                'users/' + response.response!.user!.uid.toString(),
              )
              .get();

          if (doc.data() != null) {
            Map<String, dynamic> tmp = doc.data()!;
            data = UserData(
              email: tmp['email'],
              phone: tmp['phone'],
              name: tmp['name'],
              imgurl: tmp['imgurl'],
            );
          } else {
            data = const UserData();
          }
        } catch (e) {
          print(e);
          data = const UserData();
        }
        ScaffoldMessenger.of(context).clearMaterialBanners();
        Navigator.pushAndRemoveUntil(
          context,
          CupertinoPageRoute(
            builder: (ctx) => HomeScr(
              data: data,
            ),
          ),
          (route) => !Navigator.canPop(context),
        );
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } else if (response.error == null && response.response == null) {
      ScaffoldMessenger.of(context).removeCurrentMaterialBanner();
      ScaffoldMessenger.of(context).showMaterialBanner(
        MaterialBanner(
          content: const Text(
            'Login Failed: Unknown Error',
          ),
          actions: [
            GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(context).removeCurrentMaterialBanner();
              },
              child: Icon(
                Icons.close,
                size: 18.sp,
              ),
            ),
          ],
        ),
      );
      setState(() {
        isLoading = false;
      });
    } else {
      ScaffoldMessenger.of(context).removeCurrentMaterialBanner();
      ScaffoldMessenger.of(context).showMaterialBanner(
        MaterialBanner(
          content: Text(
            'Login failed: ${response.error} ',
          ),
          actions: [
            GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(context).removeCurrentMaterialBanner();
              },
              child: Icon(
                Icons.close,
                size: 18.sp,
              ),
            ),
          ],
        ),
      );
      setState(() {
        isLoading = false;
      });
    }
  }
}
