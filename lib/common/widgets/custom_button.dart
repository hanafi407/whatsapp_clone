import 'package:flutter/material.dart';

import '../../colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.text, required this.height, required this.onPressed});

  final String text;
  final double height;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onPressed();
      },
      child: Text(text),
      style: ElevatedButton.styleFrom(
          backgroundColor: tabColor, minimumSize: Size(double.infinity, height)),
    );
  }
}
