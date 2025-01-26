import 'package:craftsiliconweather/core/common/constants/app_strings.dart';
import 'package:flutter/material.dart';

class AppTextViewRestrictedMultiline extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  final FontWeight? weight;
  final Color? textColor;
  final double? fontSize;
  final double? padding;
  final double? height;
  final int? maxLines;
  final Function()? onTap;

  const AppTextViewRestrictedMultiline(
      {super.key,
      this.onTap,
      required this.text,
      required this.textAlign,
      this.weight,
      this.maxLines,
      this.textColor,
      this.fontSize,
      this.padding,
      this.height});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap != null ? onTap!() : null;
      },
      child: Flexible(
        child: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Text(text,
              textAlign: TextAlign.justify,
              maxLines: 3,
              style: TextStyle(
                  color: textColor,
                  fontFamily: app_font,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  height: height)),
        ),
      ),
    );
  }
}
