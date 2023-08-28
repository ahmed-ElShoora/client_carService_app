import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;

  final double fontSize;

  final Color color;

  final Alignment alignment;

  final FontWeight fontweight;

  final double height;

  final TextAlign alignmentText;

  CustomText({
    this.text = '',
    this.fontSize = 18,
    this.color = Colors.black,
    this.alignment = Alignment.center,
    this.height = 1,
    this.fontweight = FontWeight.bold,
    this.alignmentText = TextAlign.right
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      child: Text(
        text,
        style: TextStyle(
          color: color,
          height: height,
          fontSize: fontSize,
          fontWeight: fontweight
        ),
        textAlign: alignmentText,
      ),
    );
  }
}