import 'package:firebase_auth_rest/firebase_auth_rest.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kita/screens/adduser.dart';
import 'package:kita/screens/profile.dart';
import 'package:kita/screens/users.dart';
import 'package:kita/screens/welcome.dart';
import 'theme/colors.dart';
import 'theme/texttheme.dart';

class HomeScr extends StatefulWidget {
  final UserData? data;
  final FirebaseAccount? account;
  const HomeScr({
    Key? key,
    this.data,
    this.account,
  }) : super(key: key);
  @override
  State<HomeScr> createState() => _HomeScrState();
}

class _HomeScrState extends State<HomeScr> {
  void showAddPage() {
    setState(() {
      _addUser = true;
    });
  }

  bool _addUser = false;

  //Page List
  late List<Widget> pages = [
    UsersPage(
      showAddPage: showAddPage,
    ),
    ProfilePage(
      data: widget.data,
    ),
  ];
  int _pageIndex = 1;
  Widget _page = const SizedBox();

  @override
  void dispose() {
    widget.account?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_addUser) {
      _addUser = false;
      _page = AddUserPage(
        parentSetState: setState,
      );
    } else {
      _page = pages[_pageIndex - 1];
    }
    return Scaffold(
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50.r),
          topRight: Radius.circular(50.r),
        ),
        child: BottomNavigationBar(
          currentIndex: _pageIndex,
          backgroundColor: MyColors.deepBlack,
          selectedLabelStyle: TxtTheme.reg13.copyWith(
            color: MyColors.primaryWhite,
          ),
          selectedItemColor: MyColors.primaryWhite,
          unselectedItemColor: MyColors.primaryWhite,
          iconSize: 18.r,
          unselectedLabelStyle: TxtTheme.reg13.copyWith(
            color: MyColors.primaryWhite,
            fontSize: 10.sp,
          ),
          onTap: (value) {
            if (value > 0) {
              setState(() {
                _pageIndex = value;
              });
            } else {
              Navigator.pushReplacement(
                context,
                CupertinoPageRoute(
                  builder: (ctx) => const WelcomeScr(),
                ),
              );
            }
          },
          items: const [
            BottomNavigationBarItem(
              label: 'Logout',
              icon: Icon(Icons.exit_to_app),
            ),
            BottomNavigationBarItem(
              label: 'Users',
              icon: Icon(Icons.person_outline_outlined),
            ),
            BottomNavigationBarItem(
              label: 'Profile',
              icon: Icon(Icons.perm_contact_calendar_outlined),
            )
          ],
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: SafeArea(child: _page),
      ),
    );
  }
}
