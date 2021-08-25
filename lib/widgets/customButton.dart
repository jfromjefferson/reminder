import 'package:flutter/material.dart';
import 'package:remind_me_of/utils/colors.dart';
import 'package:remind_me_of/widgets/customText.dart';

class CustomButton extends StatelessWidget {

  final VoidCallback onPressed;
  final String text;
  final double ?textSize;
  final Color ?buttonColor;
  final Color ?textColor;
  final EdgeInsets padding;

  CustomButton({
    required this.onPressed,
    required this.text,
    required this.padding,
    this.textSize = 20,
    this.buttonColor = primaryColor,
    this.textColor = Colors.white
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: CustomText(
        text: text,
        size: textSize,
        color: textColor,
      ),
      style: TextButton.styleFrom(
          backgroundColor: buttonColor,
          padding: padding
      ),
    );
  }
}