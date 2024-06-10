import 'dart:core';

import 'package:flutter/material.dart';

class MyAppText extends StatelessWidget {
  final String text;
  final String? fontFamily;
  final int? maxLine;
  final Color? color;
  final TextOverflow? textOverflow;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextDecoration? textDecoration;
  final TextAlign? textAlign;

  const MyAppText(
      {super.key,
      required this.text,
      this.textAlign,
      this.color,
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
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontFamily: fontFamily,
        decoration: textDecoration,
      ),
    );
  }
}
