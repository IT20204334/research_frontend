// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:form_validation/form_validation.dart';
import 'package:indoortracking/Controllers/AuthController.dart';
import 'package:indoortracking/Models/Strings/login_screen.dart';
import 'package:indoortracking/Models/Utils/Colors.dart';
import 'package:indoortracking/Models/Utils/Common.dart';
import 'package:indoortracking/Models/Utils/Images.dart';
import 'package:indoortracking/Models/Utils/Routes.dart';
import 'package:indoortracking/Models/Utils/Utils.dart';
import 'package:indoortracking/Views/Auth/forget_password.dart';
import 'package:indoortracking/Views/Auth/register.dart';
import 'package:indoortracking/Views/Home/Home.dart';
import 'package:indoortracking/Views/Widgets/custom_button.dart';
import 'package:indoortracking/Views/Widgets/custom_text_form_field.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final AuthController _authController = AuthController();
  final _keyForm = GlobalKey<FormState>();

  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  void initState() {

    // _username.text = 'admin@gmail.com';
    // _password.text = 'Admin@123';

    _username.text = 'user@gmail.com';
    _password.text = 'User@123';

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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: displaySize.width * 0.3,
                        child: Image.asset(logoOnly),
                      )),
                  const SizedBox(
                    height: 40.0,
                  ),
                  Center(
                    child: Text(
                      Login_title.toUpperCase(),
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
                        Login_subtitle.toUpperCase(),
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
                        horizontal: 20.0, vertical: 5.0),
                    child: CustomTextFormField(
                        height: 5.0,
                        controller: _password,
                        backgroundColor: color7,
                        iconColor: color3,
                        isIconAvailable: true,
                        hint: 'Password',
                        icon: Icons.lock_outline,
                        textInputType: TextInputType.text,
                        validation: (value) {
                          final validator = Validator(
                            validators: [const RequiredValidator()],
                          );
                          return validator.validate(
                            label: 'Invalid Email Address',
                            value: value,
                          );
                        },
                        obscureText: true),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 20.0),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: () {
                          Routes(context: context)
                              .navigate(const ForgetPassword());
                        },
                        child: const Text(
                          Login_forget_password_text,
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 45.0, vertical: 5.0),
                    child: CustomButton(
                        buttonText: Login_button_text,
                        textColor: color6,
                        backgroundColor: color3,
                        isBorder: false,
                        borderColor: color6,
                        onclickFunction: () {
                          if (_keyForm.currentState!.validate()) {
                            CustomUtils.showLoader(context);
                            _authController.doLogin({
                              'email': _username.text,
                              'password': _password.text
                            }).then((value) {
                              CustomUtils.hideLoader(context);
                              if (value == true) {
                                _keyForm.currentState!.reset();
                                _username.text = '';
                                _password.text = '';
                                Routes(context: context)
                                    .navigateReplace(Home());
                              }
                            });
                          }
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: GestureDetector(
                        onTap: () {
                          Routes(context: context).navigate(BusinessRegister());
                        },
                        child: const Text(
                          Login_register_button_text,
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ),
      )),
    );
  }
}
