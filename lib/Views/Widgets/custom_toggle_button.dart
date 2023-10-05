import 'package:flutter/material.dart';
import 'package:indoortracking/Models/Utils/Colors.dart';
import 'package:toggle_switch/toggle_switch.dart';

class CustomToggleButton extends StatefulWidget {
  const CustomToggleButton({Key? key}) : super(key: key);

  @override
  State<CustomToggleButton> createState() => _CustomToggleButtonState();
}

class _CustomToggleButtonState extends State<CustomToggleButton> {
  List<bool> toggleButtonValues = [true, false];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        ToggleSwitch(
          minHeight: 50.0,
          inactiveBgColor: color9,
          inactiveFgColor: color8,
          activeBgColor: [color6],
          activeFgColor: color3,
          activeBorders: [Border.all(color: color9, width: 3.0)],
          initialLabelIndex: 0,
          totalSwitches: 2,
          labels: const ['Yes', 'No'],
          onToggle: (index) {
            print('switched to: $index');
          },
        )
      ],
    );
  }
}
