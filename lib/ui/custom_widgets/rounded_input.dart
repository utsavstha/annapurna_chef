import 'package:annapurna_chef/constants/colors.dart';
import 'package:flutter/material.dart';

import 'input_container.dart';

class RoundedInput extends StatelessWidget {
  RoundedInput(
      {Key? key,
      required this.icon,
      required this.hint,
      required this.controller,
      required this.isPassword})
      : super(key: key);

  final IconData icon;
  final String hint;
  final TextEditingController controller;
  final bool isPassword;

  @override
  Widget build(BuildContext context) {
    return InputContainer(
        child: TextField(
      obscureText: isPassword,
      controller: controller,
      cursorColor: colorVacant,
      decoration: InputDecoration(
          icon: Icon(
            icon,
          ),
          hintText: hint,
          border: InputBorder.none),
    ));
  }
}
