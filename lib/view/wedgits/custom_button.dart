import 'package:flutter/material.dart';

import 'custome_text.dart';

class CustomButton extends StatelessWidget {
  final String text;


  final Function()? onPress;

  final int color;
  final int text_colorl;
  CustomButton({
    required this.onPress,
    this.text = 'Write text ',
    this.color = 0xff1C74BC,
    this.text_colorl = 0xffFFFFFF,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        )),
        backgroundColor: MaterialStateProperty.all(Color(color)),
        padding: MaterialStateProperty.all(EdgeInsets.all(10)),
      ),
      onPressed: onPress,
      child: CustomText(
        alignment: Alignment.center,
        text: text,
        color: Color(text_colorl),
        fontSize: 22,
      ),
    );
  }
}