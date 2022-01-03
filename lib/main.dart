import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'screens/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebaseoptions.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  try {
    await Firebase.initializeApp(
      name: 'worker',
      options: firebaseOpts,
    );
  } catch (e) {
    print(e);
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: () => MaterialApp(
        theme: ThemeData(fontFamily: 'MRB'),
        debugShowCheckedModeBanner: false,
        home: const SplashScr(),
      ),
    );
  }
}
