import 'dart:core';

import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final String? fontFamily;
  final int? maxLine;
  final TextOverflow? textOverflow;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextDecoration? textDecoration;
  final TextAlign? textAlign;

  const CustomText(
      {super.key,
      required this.text,
      this.textAlign,
      this.fontFamily,
      this.maxLine,
      this.textOverflow,
      this.fontSize,
      this.fontWeight,
      this.textDecoration});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: textOverflow,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontFamily: fontFamily,
        decoration: textDecoration,
      ),
    );
  }
}
