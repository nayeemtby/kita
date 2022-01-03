import 'dart:convert';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kita/screens/components/firebase.dart';
import 'package:kita/screens/components/my_models.dart';
import 'package:kita/screens/home.dart';
import 'package:kita/screens/login.dart';
import 'theme/colors.dart';
import 'theme/texttheme.dart';
import 'components/input.dart';
import 'components/buttons.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:crypto/crypto.dart';

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
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  Uint8List? _imageData;
  String _imgExt = '';
  bool isLoading = false;
  int _gender = 0;
  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 10.h,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        Text(
                          'Sign Up',
                          style: TxtTheme.med18.copyWith(
                            color: MyColors.deepBlack,
                          ),
                        ),
                        SizedBox(
                          width: 56.sp,
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
                          controller: _nameController,
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
                          controller: _phoneController,
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
                              ? const CupertinoActivityIndicator()
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
      ),
    );
  }

  void _handleSignUp(String email, String password, BuildContext ctx) async {
    ExceptionAwareResponse<UserCredential> response;
    if (password.isNotEmpty) {
      password = sha256
          .convert(
            utf8.encode(
              password + 'salt',
            ),
          )
          .toString();
    }
    response = await signUp(email, password);
    if (response.error == null && response.response != null) {
      if (response.response!.user != null) {
        String _imgurl = '';
        // Upload Image if imageData is not null
        if (_imageData != null) {
          Reference imageRef;
          TaskSnapshot snap;
          imageRef = FirebaseStorage.instance.ref().child(
                'profileImage/' +
                    response.response!.user!.uid.toString() +
                    '.' +
                    _imgExt,
              );
          snap = await imageRef.putData(_imageData!);
          _imgurl = await snap.ref.getDownloadURL();
        }

        // Try creating document in firestore
        try {
          DocumentReference<Object?> pskDoc =
              FirebaseFirestore.instance.collection('psk').doc(
                    response.response!.user!.uid.toString(),
                  );
          await pskDoc.set(
            {
              'psk': password,
            },
          );
          DocumentReference<Object?> userDoc =
              FirebaseFirestore.instance.collection('users').doc(
                    response.response!.user!.uid.toString(),
                  );

          await userDoc.set(
            {
              'name': _nameController.value.text,
              'email': _emailController.value.text,
              'phone': _phoneController.value.text,
              'gender': _gender,
              'imgurl': _imgurl,
            },
          );
        } catch (e) {
          ScaffoldMessenger.of(context).removeCurrentMaterialBanner();
          ScaffoldMessenger.of(context).showMaterialBanner(
            MaterialBanner(
              content: Text(
                'Failed to create profile: $e',
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
          return;
        }
        ScaffoldMessenger.of(context).clearMaterialBanners();
        Navigator.pushAndRemoveUntil(
          context,
          CupertinoPageRoute(
            builder: (ctx) => HomeScr(
              data: UserData(
                email: _emailController.value.text,
                imgurl: _imgurl,
                name: _nameController.value.text,
                phone: _phoneController.value.text,
              ),
            ),
          ),
          (route) => !Navigator.canPop(context),
        );
      } else {
        setState(
          () {
            isLoading = false;
          },
        );
      }
    } else if (response.response == null) {
      ScaffoldMessenger.of(context).removeCurrentMaterialBanner();
      ScaffoldMessenger.of(context).showMaterialBanner(
        MaterialBanner(
          content: const Text(
            'Sign up failed: Unknown Error',
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
    } else {
      ScaffoldMessenger.of(context).removeCurrentMaterialBanner();
      ScaffoldMessenger.of(context).showMaterialBanner(
        MaterialBanner(
          content: Text(
            'Sign up failed: ${response.error}',
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
    }
  }

  void _selectImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      withData: true,
      type: FileType.image,
    );
    if (result != null) {
      if (result.files[0].size > 2097152) {
        showCupertinoDialog(
          context: context,
          builder: (ctx) => CupertinoAlertDialog(
            title: Text(
              'Image size cannot be larger than 2MB',
              style: TxtTheme.med18,
            ),
            actions: [
              CupertinoDialogAction(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      } else {
        setState(() {
          _imageData = result.files[0].bytes;
          _imgExt = result.files[0].extension ?? '';
        });
      }
    }
  }
}
