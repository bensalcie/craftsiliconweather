import 'package:craftsiliconweather/themes/theme.dart';
import 'package:flutter/material.dart';

import '../../constants/app_strings.dart';

class AppButton extends StatelessWidget {
  final Color buttonColor;
  final Function()? onPressed;
  final String buttonText;
  final double buttonRadius;
  final Color buttonTextColor;
  final String? buttonSpanText;
  final double? elevation;
  final double? padding;
  final double? internalpadding;
  final Widget? buttonIcon;
  final double? fontSize;
  final FontWeight? weight;
  const AppButton(
      {super.key,
      this.fontSize,
      required this.buttonText,
      required this.buttonColor,
      required this.buttonRadius,
      required this.buttonTextColor,
      required this.onPressed,
      this.buttonSpanText,
      this.buttonIcon,
      this.weight,
      this.internalpadding,
      this.elevation,
      this.padding});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(
          left: padding ?? 24,
          right: padding ?? 24,
          top: 14,
        ),
        child: Ink(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(buttonRadius),
              ),
              backgroundColor: buttonColor,
              elevation: elevation ?? 4.0,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: internalpadding ?? 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 8), // Adjust spacing as needed

                  buttonIcon ?? const SizedBox.shrink(),
                  Expanded(
                    child: buttonColor != kLightColor
                        ? Text(
                            buttonText,
                            style: TextStyle(
                                fontSize: fontSize ?? 15,
                                color: buttonTextColor,
                                fontFamily: app_font,
                                fontWeight: weight),
                            textAlign: TextAlign.center,
                          )
                        : RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                  text: buttonText,
                                  style: TextStyle(
                                      fontSize: fontSize ?? 15,
                                      color: buttonTextColor,
                                      fontFamily: app_font,
                                      fontWeight: FontWeight.w500),
                                ),
                                buttonSpanText != null
                                    ? TextSpan(
                                        text: " $buttonSpanText",
                                        style: TextStyle(
                                            fontSize: fontSize ?? 15,
                                            color: kPrimaryColor,
                                            fontFamily: app_font,
                                            fontWeight: FontWeight.w600),
                                      )
                                    : const TextSpan(text: ''),
                              ],
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
