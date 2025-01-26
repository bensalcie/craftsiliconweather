import 'package:craftsiliconweather/core/common/constants/app_strings.dart';
import 'package:flutter/material.dart';

class AppTextViewLarge extends StatelessWidget {
  final String message;
  final TextAlign? textAlign;
  final double? padding;
  final double? fontSize;
  final Color? textColor;
  final FontWeight? weight;

  const AppTextViewLarge(
      {super.key,
      required this.message,
      this.textAlign,
      this.padding,
      this.textColor,
      this.weight,
      this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: padding ?? 24, right: padding ?? 24),
      child: Text(
        message,
        textAlign: textAlign,
        style: TextStyle(
            color: textColor,
            fontFamily: app_font,
            fontWeight: weight ?? FontWeight.w700,
            fontSize: fontSize ?? 26),
      ),
    );
  }
}
