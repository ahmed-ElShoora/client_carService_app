import 'package:flutter/material.dart';

import 'custome_text.dart';

class CustomTextFormField extends StatelessWidget {
  final String text;

  final String hint;

  final TextEditingController controller;
  dynamic validator;

  TextDirection textDire;
  TextAlign textAlign;

  Icon sufficIcon;

  CustomTextFormField({
    super.key,
    required this.text,
    required this.hint,
    required this.validator,
    required this.controller,
    required this.textDire,
    required this.textAlign,
    required this.sufficIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          CustomText(
            text: text,
            fontSize: 14,
            color: Colors.grey.shade900,
            alignment: Alignment.topRight,
          ),
          TextFormField(
            controller: controller,
            validator: validator,
            textDirection: textDire,
            textAlign: textAlign,
            decoration: InputDecoration(
              hintText: hint,
              suffixIcon: sufficIcon,
              hintStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 18
              ),
              fillColor: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}