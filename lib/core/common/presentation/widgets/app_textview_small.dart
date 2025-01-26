import 'package:craftsiliconweather/core/common/constants/app_strings.dart';
import 'package:flutter/material.dart';

class AppTextViewSubtitleSmall extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  final FontWeight? weight;
  final Color? textColor;
  final double? fontSize;
  final double? padding;
  final double? height;
  final int? maxLines;
  final Function()? onTap;

  const AppTextViewSubtitleSmall(
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
      child: Padding(
        padding: EdgeInsets.only(left: padding ?? 12),
        child: Text(text,
            textAlign: textAlign,
            maxLines: maxLines,
            style: TextStyle(
                color: textColor,
                fontFamily: app_font,
                fontWeight: weight ?? FontWeight.w600,
                fontSize: fontSize ?? 12,
                height: height)),
      ),
    );
  }
}
