import 'dart:async';

import 'package:flutter/material.dart';
import 'package:indoortracking/Controllers/AuthController.dart';
import 'package:indoortracking/Models/Strings/app.dart';
import 'package:indoortracking/Models/Strings/splash_screen.dart';
import 'package:indoortracking/Models/Utils/Colors.dart';
import 'package:indoortracking/Models/Utils/Common.dart';
import 'package:indoortracking/Models/Utils/Images.dart';
import 'package:indoortracking/Models/Utils/Routes.dart';
import 'package:indoortracking/Views/Auth/Login.dart';
import 'package:indoortracking/Views/Home/Home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer _timer;

  final AuthController _authController = AuthController();

  @override
  void initState() {
    super.initState();
    startApp();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    displaySize = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: color6,
      body: SafeArea(
          child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: displaySize.width * 0.3,
                    child: Image.asset(logoOnly),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Text(
                      common_name1.toUpperCase(),
                      style: TextStyle(fontSize: 20.0, color: color11),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Text(
                      common_name2.toUpperCase(),
                      style: TextStyle(fontSize: 12.0, color: color3),
                    ),
                  )
                ],
              )),
          Positioned(
              bottom: 0.0,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: Text(
                      SplashScreen_bottom_text_1.toUpperCase(),
                      style: TextStyle(color: color11, fontSize: 12.0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30.0),
                    child: Text(
                      SplashScreen_bottom_text_2.toUpperCase(),
                      style: TextStyle(fontSize: 10.0, color: color11),
                    ),
                  )
                ],
              ))
        ],
      )),
    );
  }

  void startApp() {
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) async {
      _timer.cancel();

      if (await _authController.doLoginCheck()) {
        Routes(context: context).navigateReplace(const Home());
      } else {
        Routes(context: context).navigateReplace(const Login());
      }
    });
  }
}
