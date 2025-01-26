import 'package:craftsiliconweather/core/common/constants/app_strings.dart';
import 'package:flutter/material.dart';

class AppTextViewSubtitle extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  final Function()? onClick;
  final Color? textColor;
  final FontWeight? weight;
  final double? padding;
  final bool? isUnderLined;
  final double? fontSize;
  final bool? shouldStrikeThrough;
  final double? paddingright;
  final double? paddingleft;
  final Color? backgroundColor;

  const AppTextViewSubtitle(
      {super.key,
      required this.text,
      required this.textAlign,
      this.onClick,
      this.textColor,
      this.fontSize,
      this.weight,
      this.shouldStrikeThrough,
      this.paddingleft,
      this.paddingright,
      this.isUnderLined,
      this.backgroundColor,
      this.padding});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Padding(
        padding: EdgeInsets.only(
            left: paddingleft ?? padding ?? 24,
            right: paddingright ?? padding ?? 24),
        child: Text(text,
            textAlign: textAlign,
            style: TextStyle(
                backgroundColor: backgroundColor,
                color: textColor,
                decoration: isUnderLined == true
                    ? TextDecoration.underline
                    : shouldStrikeThrough == true
                        ? TextDecoration.lineThrough
                        : null,
                fontFamily: app_font,
                fontWeight: weight ?? FontWeight.w500,
                fontSize: fontSize ?? 15)),
      ),
    );
  }
}
