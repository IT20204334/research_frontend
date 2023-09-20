import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:indoortracking/Models/DB/User.dart';
import 'package:indoortracking/Models/Utils/FirebaseStructure.dart';
import 'package:indoortracking/Models/Utils/Utils.dart';
import 'package:indoortracking/Views/Auth/Login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _databaseRef = FirebaseDatabase.instance.ref();

  Future<bool> doRegistration(data) async {
    bool check = true;
    await _auth
        .createUserWithEmailAndPassword(
      email: data['email'],
      password: data['password'],
    )
        .then((value) async {
      data.remove('password');
      data.remove('password_confirmation');
      await _databaseRef
          .child(FirebaseStructure.USERS)
          .child(value.user!.uid)
          .set(data);
      CustomUtils.showToast('Successfully Registered.');
    }).catchError((e) {
      check = false;
      CustomUtils.showToast(e.toString());
    });

    return check;
  }

  Future<bool> doLogin(data) async {
    bool check = true;
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: data['email'], password: data['password'])
          .then((value) async {
        CustomUtils.loggedInUser = await getUserData();
      });
    } on FirebaseAuthException catch (e) {
      check = false;
      CustomUtils.showToast(CustomUtils.firebaseAuthResponse(e.code));
    }
    return check;
  }

  Future<bool> doLoginCheck() async {
    bool check = false;
    if (FirebaseAuth.instance.currentUser != null) {
      check = true;
      CustomUtils.loggedInUser = await getUserData();
    }
    return check;
  }

  Future<void> sendPasswordResetLink(data) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: data['email']);
      CustomUtils.showToast('Password reset link has been sent.');
    } catch ($e) {}
  }

  Future<void> logout(context) async {
    await _auth.signOut();
    CustomUtils.loggedInUser = null;
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => const Login()));
  }

  Future<void> logoutOnce(context) async {
    await _auth.signOut();
    CustomUtils.loggedInUser = null;
  }

  Future<ProfileUser> getUserData() async {
    late ProfileUser user;
    await _databaseRef
        .child(FirebaseStructure.USERS)
        .child(_auth.currentUser!.uid)
        .once()
        .then((DatabaseEvent event) async {
      Map<dynamic, dynamic> profileUserData = event.snapshot.value as Map;
      if (event.snapshot.value != null) {
        user = ProfileUser(
            name: profileUserData['name'],
            email: _auth.currentUser!.email,
            mobile: profileUserData['mobile'],
            type: profileUserData['type'],
            lng: profileUserData['lng'] ?? 0,
            ltd: profileUserData['ltd'] ?? 0,
            supervisor: profileUserData['supervisor'] ?? '',
            uid: _auth.currentUser!.uid);
      }
    });
    return user;
  }
}
