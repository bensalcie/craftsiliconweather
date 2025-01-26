import 'package:craftsiliconweather/core/common/constants/app_strings.dart';
import 'package:flutter/material.dart';

class AppTextViewMedium extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  final Function()? onClick;
  final Color? textColor;
  final double? padding;
  final FontWeight? weight;
  final double? fontSize;
  final double? paddingvertical;
  final FontStyle? fontStyle;
  final int? maxLines;

  const AppTextViewMedium(
      {super.key,
      required this.text,
      required this.textAlign,
      this.onClick,
      this.padding,
      this.weight,
      this.paddingvertical,
      this.fontSize,
      this.fontStyle,
      this.textColor,
      this.maxLines});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Padding(
        padding: EdgeInsets.only(
            left: padding ?? 24,
            right: padding ?? 24,
            top: paddingvertical ?? 0,
            bottom: paddingvertical ?? 0.0),
        child: Text(text,
            textAlign: textAlign,
            maxLines: maxLines,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontStyle: fontStyle,
                color: textColor,
                fontFamily: app_font,
                fontWeight: weight ?? FontWeight.bold,
                fontSize: fontSize ?? 18)),
      ),
    );
  }
}
