import 'package:annapurna_chef/constants/colors.dart';
import 'package:flutter/material.dart';

class InputContainer extends StatelessWidget {
  InputContainer({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        width: size.width * 0.8,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: colorVacant.withAlpha(50)),
        child: child);
  }
}
