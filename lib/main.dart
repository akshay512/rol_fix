import 'package:flutter/material.dart';
import 'package:flare_splash_screen/flare_splash_screen.dart';
import 'package:flutter/services.dart';
import './auth/login.dart';
import './constants/const.dart';

void main() async {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    runApp(MyApp());
  });
  }

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDark=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: isDark ? Constants.darkPrimary : Constants.lightPrimary,
      statusBarIconBrightness: isDark?Brightness.light:Brightness.dark,
    ));

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Food Ambulance',
        home: SplashScreen.navigate(
          name: 'assets/spsc.flr',
          next: LoginPage(),
          backgroundColor: Colors.white,
          startAnimation: 'Start',
          until: () => Future.delayed(Duration(seconds: 5)),
        ));
  }
}

