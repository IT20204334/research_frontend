import 'package:flutter/material.dart';
import 'package:form_validation/form_validation.dart';
import 'package:indoortracking/Controllers/AuthController.dart';
import 'package:indoortracking/Models/Strings/main_screen.dart';
import 'package:indoortracking/Models/Utils/Common.dart';
import 'package:indoortracking/Models/Utils/Utils.dart';
import 'package:indoortracking/Views/Widgets/custom_button.dart';
import 'package:indoortracking/Views/Widgets/custom_text_form_field.dart';

import '../../Models/Strings/business_register_screen.dart';
import '../../Models/Utils/Colors.dart';
import '../../Models/Utils/Routes.dart';
import '../Widgets/custom_back_button.dart';

class BusinessRegister extends StatefulWidget {
  BusinessRegister({Key? key}) : super(key: key);

  @override
  State<BusinessRegister> createState() => _BusinessRegisterState();
}

class _BusinessRegisterState extends State<BusinessRegister> {
  bool termsAndConditionCheck = false;

  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _mobile = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirm_password = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final AuthController _registerController = AuthController();

  @override
  void initState() {
    _name.text = 'User';
    _email.text = 'user@gmail.com';
    _mobile.text = '0771234587';
    _password.text = 'User@123';
    _confirm_password.text = 'User@123';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: color6,
      body: SafeArea(
          child: SizedBox(
              height: displaySize.height,
              width: displaySize.width,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: CustomCustomBackButton(onclickFunction: () {
                            Routes(context: context).back();
                          })),
                      const Center(
                        child: Text(
                          Signup_title,
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 5.0),
                                  child: CustomTextFormField(
                                      height: 5.0,
                                      controller: _name,
                                      backgroundColor: color7,
                                      iconColor: color3,
                                      isIconAvailable: true,
                                      hint: 'Full Name',
                                      icon: Icons.person_pin_circle_outlined,
                                      textInputType: TextInputType.text,
                                      validation: (value) {
                                        final validator = Validator(
                                          validators: [
                                            const RequiredValidator()
                                          ],
                                        );
                                        return validator.validate(
                                          label: 'Invalid Name',
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
                                      controller: _email,
                                      backgroundColor: color7,
                                      iconColor: color3,
                                      isIconAvailable: true,
                                      hint: 'Email Address',
                                      icon: Icons.email_outlined,
                                      textInputType: TextInputType.emailAddress,
                                      validation: (value) {
                                        final validator = Validator(
                                          validators: [const EmailValidator()],
                                        );
                                        return validator.validate(
                                          label: 'Invalid Name',
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
                                      controller: _mobile,
                                      backgroundColor: color7,
                                      iconColor: color3,
                                      isIconAvailable: true,
                                      hint: 'Mobile Number',
                                      icon: Icons.phone,
                                      textInputType: TextInputType.emailAddress,
                                      validation: (value) {
                                        final validator = Validator(
                                          validators: [
                                            const RequiredValidator()
                                          ],
                                        );
                                        return validator.validate(
                                          label: 'Invalid Mobile Number',
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
                                      icon: Icons.lock_open,
                                      textInputType: TextInputType.text,
                                      validation: (value) {
                                        final validator = Validator(
                                          validators: [
                                            const RequiredValidator()
                                          ],
                                        );
                                        return validator.validate(
                                          label: 'Invalid Password',
                                          value: value,
                                        );
                                      },
                                      obscureText: true),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 5.0),
                                  child: CustomTextFormField(
                                      height: 5.0,
                                      controller: _confirm_password,
                                      backgroundColor: color7,
                                      iconColor: color3,
                                      isIconAvailable: true,
                                      hint: 'Confirm Password',
                                      icon: Icons.lock_open,
                                      textInputType: TextInputType.text,
                                      validation: (value) {
                                        final validator = Validator(
                                          validators: [
                                            const RequiredValidator()
                                          ],
                                        );
                                        return validator.validate(
                                          label: 'Invalid Retype Password',
                                          value: value,
                                        );
                                      },
                                      obscureText: true),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 5.0),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        height: 20.0,
                                        width: 20.0,
                                        child: Checkbox(
                                          checkColor: color3,
                                          fillColor:
                                              MaterialStateProperty.all(color3),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(3)),
                                          value: termsAndConditionCheck,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              termsAndConditionCheck = value!;
                                            });
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10.0),
                                        child: SizedBox(
                                          width: displaySize.width * 0.65,
                                          child: Text(
                                            Signup_Checkbox_termsAndConditions_lbl,
                                            style: TextStyle(
                                                color: color8,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 45.0, vertical: 20.0),
                                  child: CustomButton(
                                      buttonText: SignUp_title,
                                      textColor: color6,
                                      backgroundColor: color3,
                                      isBorder: false,
                                      borderColor: color6,
                                      onclickFunction: () {
                                        FocusScope.of(context).unfocus();
                                        if (termsAndConditionCheck == true) {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            CustomUtils.showLoader(context);
                                            _registerController.doRegistration({
                                              "name": _name.text,
                                              "email": _email.text,
                                              "mobile": _mobile.text,
                                              "password": _password.text,
                                              "type": 2
                                            }).then((value) {
                                              CustomUtils.hideLoader(context);
                                              if (value == true) {
                                                _formKey.currentState!.reset();
                                                _name.text = '';
                                                _email.text = '';
                                                _mobile.text = '';
                                                _password.text = '';
                                                _confirm_password.text = '';
                                              }
                                            });
                                          }
                                        } else {
                                          CustomUtils.showSnackBar(
                                              context,
                                              "Please Accept the Terms and Conditions for Proceed",
                                              CustomUtils.ERROR_SNACKBAR);
                                        }
                                      }),
                                ),
                              ],
                            )),
                      )
                    ],
                  ),
                ),
              ))),
    );
  }

  getShadow() {
    return <BoxShadow>[
      const BoxShadow(
        color: Colors.black12,
        spreadRadius: -2,
        blurRadius: 5,
        offset: Offset(0, 4), // changes position of shadow
      ),
    ];
  }
}
