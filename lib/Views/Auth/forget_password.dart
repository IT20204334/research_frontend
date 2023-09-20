// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:form_validation/form_validation.dart';
import 'package:indoortracking/Controllers/AuthController.dart';
import 'package:indoortracking/Models/Utils/Colors.dart';
import 'package:indoortracking/Models/Utils/Common.dart';
import 'package:indoortracking/Models/Utils/Images.dart';
import 'package:indoortracking/Models/Utils/Routes.dart';
import 'package:indoortracking/Models/Utils/Utils.dart';
import 'package:indoortracking/Views/Widgets/custom_button.dart';
import 'package:indoortracking/Views/Widgets/custom_back_button.dart';
import 'package:indoortracking/Views/Widgets/custom_text_form_field.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _LoginState();
}

class _LoginState extends State<ForgetPassword> {
  final AuthController _authController = AuthController();
  final _keyForm = GlobalKey<FormState>();

  final TextEditingController _username = TextEditingController();

  @override
  void initState() {
    _username.text = 'farmer@gmail.com';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: color6,
      body: SafeArea(
          child: SizedBox(
        height: displaySize.height,
        width: displaySize.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Form(
              key: _keyForm,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: CustomCustomBackButton(
                          onclickFunction: () =>
                              Routes(context: context).back())),
                  Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: displaySize.width * 0.5,
                        child: Image.asset(pw_reset),
                      )),
                  const SizedBox(
                    height: 30.0,
                  ),
                  Center(
                    child: Text(
                      "Forget Password".toUpperCase(),
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                          color: color11),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        "Reset your existing account password".toUpperCase(),
                        style: TextStyle(fontSize: 12.0, color: color3),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: displaySize.width * 0.1,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 5.0),
                    child: CustomTextFormField(
                        height: 5.0,
                        controller: _username,
                        backgroundColor: color7,
                        iconColor: color3,
                        isIconAvailable: true,
                        hint: 'Email Address / Username',
                        icon: Icons.email_outlined,
                        textInputType: TextInputType.emailAddress,
                        validation: (value) {
                          final validator = Validator(
                            validators: [const EmailValidator()],
                          );
                          return validator.validate(
                            label: 'Invalid Email Address',
                            value: value,
                          );
                        },
                        obscureText: false),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 45.0, vertical: 5.0),
                    child: CustomButton(
                        buttonText: "Send Link",
                        textColor: color6,
                        backgroundColor: color3,
                        isBorder: false,
                        borderColor: color6,
                        onclickFunction: () {
                          if (_keyForm.currentState!.validate()) {
                            CustomUtils.showLoader(context);
                            _authController.sendPasswordResetLink({
                              'email': _username.text,
                            }).then((value) {
                              CustomUtils.hideLoader(context);
                            });
                          }
                        }),
                  )
                ],
              )),
        ),
      )),
    );
  }
}
