import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kita/screens/components/my_models.dart';
import 'package:kita/screens/components/users.dart';
import 'theme/colors.dart';
import 'theme/texttheme.dart';
import 'components/input.dart';
import 'package:firebase_core/firebase_core.dart';

class UsersPage extends StatefulWidget {
  final void Function() showAddPage;
  const UsersPage({
    Key? key,
    required this.showAddPage,
  }) : super(key: key);

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final String currentUser = FirebaseAuth.instance.currentUser!.uid;
  late QuerySnapshot snap;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    getUsers();
  }

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
          height: 1.sp,
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
                      'Total Users\n${isLoading ? '--' : snap.docs.length - 1}',
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
                    widget.showAddPage();
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
          child: isLoading
              ? Center(
                  child: CupertinoActivityIndicator(
                    radius: 10.r,
                  ),
                )
              : SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(
                        snap.docs.length,
                        (index) {
                          if (snap.docs[index].id == currentUser) {
                            return const SizedBox();
                          }
                          Map<String, dynamic> data =
                              snap.docs[index].data() as Map<String, dynamic>;
                          return UserItem(
                            remove: removeUser,
                            id: snap.docs[index].id,
                            data: UserData(
                              email: data['email'],
                              name: data['name'],
                              imgurl: data['imgurl'],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
        )
      ],
    );
  }

  void getUsers() async {
    try {
      snap = await FirebaseFirestore.instance.collection('users').get();
    } catch (e) {
      showCupertinoDialog(
        context: context,
        builder: (ctx) => CupertinoAlertDialog(
          content: Text(
            e.toString(),
          ),
          actions: [
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
      return;
    }
    setState(() {
      isLoading = false;
    });
  }

  void removeUser(String id) async {
    showCupertinoDialog(
      context: context,
      builder: (ctx) => WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: CupertinoAlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Removing User',
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
      ),
    );
    final FirebaseAuth authInstance = FirebaseAuth.instanceFor(
      app: Firebase.app(
        'worker',
      ),
    );
    DocumentReference<Map<String, dynamic>> pskDoc =
        FirebaseFirestore.instance.collection('psk').doc(id);
    DocumentReference<Map<String, dynamic>> dataDoc =
        FirebaseFirestore.instance.collection('users').doc(id);
    String email = (await dataDoc.get()).data()!['email'];
    String psk = (await pskDoc.get()).data()!['psk'];
    await (await authInstance.signInWithEmailAndPassword(
      email: email,
      password: psk,
    ))
        .user!
        .delete();
    await pskDoc.delete();
    await dataDoc.delete();
    try {
      await FirebaseStorage.instance.ref('profileImage').child(id).delete();
    } catch (e) {
      print(e.toString());
    }
    Navigator.pop(context);
    setState(() {
      isLoading = true;
    });
    getUsers();
  }
}
