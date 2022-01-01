import 'dart:typed_data';
import 'package:firebase_auth_rest/firebase_auth_rest.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kita/screens/components/firebase.dart';
import 'package:kita/screens/home.dart';
import 'package:kita/screens/login.dart';
import 'theme/colors.dart';
import 'theme/texttheme.dart';
import 'components/input.dart';
import 'components/buttons.dart';
import 'package:file_picker/file_picker.dart';

class SignupScr extends StatefulWidget {
  const SignupScr({
    Key? key,
  }) : super(key: key);

  @override
  State<SignupScr> createState() => _SignupScrState();
}

class _SignupScrState extends State<SignupScr> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  Uint8List? _imageData;
  bool isLoading = false;
  int _gender = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: GestureDetector(
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 10.h,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Center(
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            CircleAvatar(
                              radius: 56.r,
                              foregroundImage: _imageData == null
                                  ? null
                                  : MemoryImage(_imageData!),
                            ),
                            Positioned(
                              bottom: -10.r,
                              left: 5.r,
                              child: GestureDetector(
                                onTap: () {
                                  _selectImage();
                                },
                                child: CircleAvatar(
                                  radius: 20.r,
                                  backgroundColor: MyColors.deepBlack,
                                  child: Icon(
                                    Icons.camera_alt,
                                    size: 20.r,
                                    color: MyColors.primaryWhite,
                                  ),
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
                      TxtInput(
                        hint: 'Email',
                        controller: _emailController,
                      ),
                      SizedBox(
                        height: 12.h,
                      ),
                      TxtInput(
                        hint: 'Password',
                        password: true,
                        controller: _passwordController,
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
                        suffix: Text(
                          'Verify',
                          style: TxtTheme.reg15.copyWith(
                            color: MyColors.primaryBlue,
                          ),
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
                            fillColor:
                                MaterialStateProperty.all(MyColors.deepBlack),
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
                            fillColor:
                                MaterialStateProperty.all(MyColors.deepBlack),
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
                        child: isLoading
                            ? const CircularProgressIndicator(
                                color: MyColors.primaryWhite,
                              )
                            : null,
                        onTap: isLoading
                            ? null
                            : () {
                                _handleSignUp(
                                  _emailController.value.text,
                                  _passwordController.value.text,
                                  context,
                                );
                                setState(() {
                                  isLoading = !isLoading;
                                });
                              },
                      ),
                      Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Already have an account? ',
                              style: TxtTheme.med16.copyWith(
                                color: MyColors.secondaryBlack,
                                height: 1.4,
                              ),
                            ),
                            CupertinoButton(
                              padding: const EdgeInsets.all(0),
                              child: Text(
                                'Login',
                                style: TxtTheme.med16,
                              ),
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (ctx) => const LoginScr(),
                                  ),
                                );
                              },
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ))
              ],
            ),
          ),
        ),
      ),
    ));
  }

  void _handleSignUp(String email, String password, BuildContext ctx) async {
    dynamic response;
    try {
      response = await signUp(email, password);
    } catch (e) {
      ScaffoldMessenger.of(context).showMaterialBanner(
        MaterialBanner(
          content: Text('Error: ${e.toString()}'),
          actions: [
            InkWell(
              onTap: () {
                ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
              },
              child: const Icon(Icons.close),
            ),
          ],
        ),
      );
      setState(() {
        isLoading = false;
      });
    }
    if (response.runtimeType == FirebaseAccount) {
      ScaffoldMessenger.of(context).clearMaterialBanners();
      response = response as FirebaseAccount;
      final UserData? data = await response.getDetails();
      Navigator.pushReplacement(
        context,
        CupertinoPageRoute(
          builder: (ctx) => HomeScr(
            data: data,
            account: response,
          ),
        ),
      );
    }
  }

  void _selectImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      withData: true,
      type: FileType.image,
    );
    if (result != null) {
      setState(() {
        _imageData = result.files[0].bytes;
      });
    }
  }
}
