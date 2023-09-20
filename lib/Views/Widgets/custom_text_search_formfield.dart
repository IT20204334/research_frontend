import 'package:flutter/material.dart';
import 'package:dropdown_plus/dropdown_plus.dart';
import 'package:indoortracking/Models/Utils/Colors.dart';

class CustomSearchTextFormField extends StatefulWidget {
  final List<String> option;
  final Color hint_color;
  final String hint_text;
  final Color action_icon_color;
  final double dropdown_height;
  String leading_image;
  var leading_icon;
  var leading_icon_color;

  CustomSearchTextFormField({
    Key? key,
    required this.option,
    required this.hint_color,
    required this.hint_text,
    required this.action_icon_color,
    required this.dropdown_height,
    this.leading_image = '',
    this.leading_icon,
    this.leading_icon_color,
  }) : super(key: key);

  @override
  State<CustomSearchTextFormField> createState() =>
      _CustomSearchTextFormFieldState(
        option: option,
        hint_color: hint_color,
        hint_text: hint_text,
        action_icon_color: action_icon_color,
        dropdown_height: dropdown_height,
        leading_image: leading_image,
        leading_icon: leading_icon,
        leading_icon_color: leading_icon_color,
      );
}

class _CustomSearchTextFormFieldState extends State<CustomSearchTextFormField> {
  List<String> option;
  Color hint_color;
  String hint_text;
  Color action_icon_color;
  double dropdown_height;
  String leading_image;
  var leading_icon;
  var leading_icon_color;

  _CustomSearchTextFormFieldState({
    required this.option,
    required this.hint_color,
    required this.hint_text,
    required this.action_icon_color,
    required this.dropdown_height,
    this.leading_image = '',
    this.leading_icon,
    this.leading_icon_color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0), color: color6),
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        children: [
          (leading_image != '')
              ? Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Image.asset(leading_image),
                )
              : const SizedBox.shrink(),
          (leading_icon != null)
              ? Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Icon(
                    leading_icon,
                    color: leading_icon_color,
                  ),
                )
              : const SizedBox.shrink(),
          Flexible(
              child: TextDropdownFormField(
            options: option,
            decoration: InputDecoration(
              hintStyle: TextStyle(
                  color: hint_color,
                  fontFamily: 'Raleway-SemiBold',
                  fontSize: 14),
              hintText: hint_text,
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              contentPadding: const EdgeInsets.only(
                  left: 15, bottom: 11, top: 14, right: 15),
              suffixIcon: Icon(
                Icons.keyboard_arrow_down_rounded,
                color: action_icon_color,
              ),
            ),
            dropdownHeight: dropdown_height,
          ))
        ],
      ),
    );
  }
}
