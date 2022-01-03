import 'dart:convert';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kita/screens/components/my_models.dart';
import 'components/firebase.dart';
import 'theme/colors.dart';
import 'theme/texttheme.dart';
import 'components/input.dart';
import 'components/buttons.dart';

class AddUserPage extends StatefulWidget {
  final StateSetter parentSetState;
  final FirebaseAuth authInstance;
  const AddUserPage({
    Key? key,
    required this.parentSetState,
    required this.authInstance,
  }) : super(key: key);

  @override
  State<AddUserPage> createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  Uint8List? _imageData;
  bool hidePass = true;
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
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CupertinoButton(
                    padding: const EdgeInsets.all(0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.close,
                          size: 18.sp,
                          color: MyColors.primaryBlue,
                        ),
                      ],
                    ),
                    onPressed: () {
                      widget.parentSetState(() {});
                    },
                  ),
                  Text(
                    'Add New User',
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
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                      height: 40.h,
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
                      height: 12.h,
                    ),
                    TxtInput(
                      hint: 'Mobile Number',
                      controller: _phoneController,
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
                      txt: 'Add User',
                      child:
                          isLoading ? const CupertinoActivityIndicator() : null,
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
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _handleSignUp(String email, String password, BuildContext ctx) async {
    showCupertinoDialog(
      context: context,
      builder: (ctx) => const LoadingDialog(),
    );
    ExceptionAwareResponse<UserCredential> response;
    password = sha256
        .convert(
          utf8.encode(
            password + 'salt',
          ),
        )
        .toString();
    response = await signUp(
      email,
      password,
      instance: widget.authInstance,
    );
    if (response.error == null && response.response != null) {
      if (response.response!.user != null) {
        String _imgurl = '';
        // Upload Image if imageData is not null
        if (_imageData != null) {
          Reference imageRef;
          TaskSnapshot snap;
          imageRef = FirebaseStorage.instance.ref().child(
                'profileImage/' + response.response!.user!.uid.toString(),
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
          Navigator.pop(context);
          setState(() {
            isLoading = false;
          });
          showCupertinoDialog(
            context: context,
            builder: (ctx) => ErrorDialog(
              message: e.toString(),
              title: 'Profile Creation Failed',
            ),
          );
        }
        widget.authInstance.signOut();
        Navigator.pop(context);
        widget.parentSetState(() {});
      } else {
        setState(
          () {
            isLoading = false;
          },
        );
      }
    } else if (response.response == null) {
      Navigator.pop(context);
      setState(() {
        isLoading = false;
      });
      showCupertinoDialog(
        context: context,
        builder: (ctx) => ErrorDialog(
          title: 'Sign Up Failed',
          message: response.error.toString(),
        ),
      );
    } else {
      Navigator.pop(context);
      setState(() {
        isLoading = false;
      });
      showCupertinoDialog(
        context: context,
        builder: (ctx) => ErrorDialog(
          title: 'Sign Up Failed',
          message: response.error,
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
        });
      }
    }
  }
}

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: CupertinoAlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Creating User',
              style: TxtTheme.med16,
            ),
            SizedBox(
              height: 16.h,
            ),
            CupertinoActivityIndicator(
              radius: 10.r,
            ),
          ],
        ),
        actions: const [],
      ),
    );
  }
}

class ErrorDialog extends StatelessWidget {
  final String title;
  final String message;
  const ErrorDialog({
    Key? key,
    required this.title,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(
        title,
        style: TxtTheme.med18.copyWith(
          color: CupertinoColors.destructiveRed,
        ),
      ),
      content: Text(
        message,
        style: TxtTheme.med16,
      ),
      actions: [
        CupertinoDialogAction(
          child: const Text('OK'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
