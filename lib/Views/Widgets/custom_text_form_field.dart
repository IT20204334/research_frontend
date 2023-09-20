import 'package:flutter/material.dart';
import 'package:indoortracking/Models/Utils/Colors.dart';

class CustomTextFormField extends StatefulWidget {
  double height = 5.0;
  String hint;
  IconData icon;
  TextInputType textInputType;
  Color backgroundColor;
  Color iconColor;
  bool isIconAvailable;
  var validation;
  bool obscureText;
  TextEditingController controller;

  CustomTextFormField(
      {Key? key,
      required this.height,
      required this.hint,
      required this.icon,
      required this.textInputType,
      required this.backgroundColor,
      required this.iconColor,
      required this.isIconAvailable,
      required this.validation,
      required this.controller,
      required this.obscureText})
      : super(key: key);

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState(
      height: height,
      hint: hint,
      icon: icon,
      textInputType: textInputType,
      backgroundColor: backgroundColor,
      iconColor: iconColor,
      controller: controller,
      isIconAvailable: isIconAvailable,
      validation: validation,
      obscureText: obscureText);
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  double height = 5.0;
  String hint;
  IconData icon;
  TextInputType textInputType;
  Color backgroundColor;
  Color iconColor;
  bool isIconAvailable;
  var validation;
  bool obscureText;
  TextEditingController controller;

  _CustomTextFormFieldState(
      {required this.height,
      required this.hint,
      required this.icon,
      required this.textInputType,
      required this.backgroundColor,
      required this.iconColor,
      required this.isIconAvailable,
      required this.validation,
      required this.controller,
      required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: backgroundColor, borderRadius: BorderRadius.circular(5.0)),
      padding: EdgeInsets.symmetric(vertical: height, horizontal: 10.0),
      child: Row(
        children: [
          (isIconAvailable == true)
              ? Icon(
                  icon,
                  color: iconColor,
                )
              : const SizedBox.shrink(),
          Flexible(
              child: TextFormField(
            controller: controller,
            obscureText: obscureText,
            cursorColor: color3,
            keyboardType: textInputType,
            validator: validation,
            decoration: InputDecoration(
                hintStyle: TextStyle(color: color8),
                label: Text(hint),
                labelStyle:
                    TextStyle(color: color8, fontFamily: 'Raleway-SemiBold'),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding: const EdgeInsets.only(
                    left: 15, bottom: 11, top: 11, right: 15)),
          ))
        ],
      ),
    );
  }
}
