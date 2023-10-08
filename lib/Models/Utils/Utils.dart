import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:indoortracking/Models/DB/User.dart';
import 'package:indoortracking/Models/Utils/Colors.dart';
import 'package:indoortracking/Views/PopUps/Loading.dart';

class CustomUtils {
  static const int DEFAULT_SNACKBAR = 1;
  static const int SUCCESS_SNACKBAR = 2;
  static const int ERROR_SNACKBAR = 3;
  static int ADMINISTRATOR = 1;
  static int FARMER = 2;
  static int SUPERVISOR = 3;

  static late String loggedInToken;
  static late ProfileUser? loggedInUser;

  static getToken() {
    return utf8.decode(base64.decode(loggedInToken));
  }

    static String getCurrentDate() {
    return DateFormat("yyyy/MM/dd").format(DateTime.now());
  }

  static String formatDate(DateTime date) {
    return DateFormat("yyyy/MM/dd").format(date);
  }

  static String formatTime(DateTime date) {
    return DateFormat("hh:mm a").format(date);
  }

  static String formatDateTime(DateTime date) {
    return DateFormat("yyyy/MM/dd hh:mm a").format(date);
  }

  static String formatTimeAPI(DateTime date) {
    return DateFormat("hh:mm:ss").format(date);
  }


  static getGradientBackground() {
    return BoxDecoration(
        gradient: LinearGradient(
      begin: Alignment.topRight,
      tileMode: TileMode.decal,
      end: Alignment.bottomLeft,
      colors: [
        color3,
        color2,
      ],
    ));
  }

  static setLoggedToken(token) {
    loggedInToken = base64.encode(utf8.encode(token));
    return loggedInToken;
  }

  static getUser() {
    return loggedInUser;
  }

  static Future showLoader(context) async {
    await showDialog(
      context: context,
      builder: (_) => const Loading(),
    );
  }

  static Future hideLoader(context) async {
    Navigator.pop(context);
  }

  static showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: color11,
        textColor: color6,
        fontSize: 14.0);
  }

  static showSnackBar(context, message, int type) {
    Color backgroundColor = color6;
    Color textColor = color8;
    print(type);
    switch (type) {
      case 1:
        backgroundColor = color6;
        textColor = color8;
        break;
      case 2:
        backgroundColor = color3;
        textColor = color6;
        break;
      case 3:
        backgroundColor = color3;
        textColor = color6;
        break;
      default:
    }

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: backgroundColor,
      content: Text(
        message,
        style: TextStyle(fontFamily: 'Raleway-SemiBold', color: textColor),
      ),
    ));
  }

  static showSnackBarList(context, contents, int type) {
    Color backgroundColor = color6;
    Color textColor = color8;

    switch (type) {
      case 1:
        backgroundColor = color6;
        textColor = color8;
        break;
      case 2:
        backgroundColor = color3;
        textColor = color6;
        break;
      case 3:
        backgroundColor = color6;
        textColor = color8;
        break;
      default:
    }

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: backgroundColor,
      content: Wrap(
        children: [
          for (String message in contents)
            Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: Text(
                message,
                style:
                    TextStyle(fontFamily: 'Raleway-SemiBold', color: textColor),
              ),
            ),
        ],
      ),
    ));
  }

  static showSnackBarMessage(context, contents, int type) {
    Color backgroundColor = color6;
    Color textColor = color8;
    switch (type) {
      case 1:
        backgroundColor = color6;
        textColor = color8;
        break;
      case 2:
        backgroundColor = color3;
        textColor = color6;
        break;
      case ERROR_SNACKBAR:
        backgroundColor = color3;
        textColor = color9;
        break;
      default:
    }

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: backgroundColor,
      content: Padding(
        padding: const EdgeInsets.only(bottom: 5.0),
        child: Text(
          contents,
          style: TextStyle(fontFamily: 'Raleway-SemiBold', color: textColor),
        ),
      ),
    ));
  }

  static String firebaseAuthResponse(String code) {
    switch (code) {
      case 'invalid-email':
      case 'user-not-found':
      case 'wrong-password':
        return 'Invalid credentails.';
      case 'user-disabled':
        return 'Account has been disabled.';
      default:
        return 'Something wrong. Please try again later';
    }
  }
}
