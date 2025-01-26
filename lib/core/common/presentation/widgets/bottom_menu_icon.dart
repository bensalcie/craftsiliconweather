import 'package:craftsiliconweather/core/common/constants/app_strings.dart';
import 'package:craftsiliconweather/core/common/constants/dimens.dart';
import 'package:craftsiliconweather/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BottomMenuIcon extends StatelessWidget {
  final bool isActive;
  final String assetsvgicon;
  final String iconlabel;
  const BottomMenuIcon(
      {super.key,
      required this.isActive,
      required this.assetsvgicon,
      required this.iconlabel});

  @override
  Widget build(BuildContext context) {
    return Ink(
      height: 50,
      width: 70,
      decoration: BoxDecoration(
        color: isActive
            ? kPrimaryDark
            : kPrimaryColor, // Apply the selected color to the active icon
        borderRadius: BorderRadius.circular(10.0), // Rounded corners
      ),
      padding: const EdgeInsets.all(elements_small_padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: elements_small_padding,
          ),
          SvgPicture.asset(assetsvgicon,
              height: 24,
              width: 24,
              semanticsLabel: iconlabel,
              colorFilter: isActive
                  ? ColorFilter.mode(kLightColor, BlendMode.srcIn)
                  : ColorFilter.mode(Colors.grey.shade800, BlendMode.srcIn)),
          Text(iconlabel,
              textAlign: TextAlign.center,
              maxLines: 1,
              style: TextStyle(
                  color: isActive ? Colors.white : Colors.grey.shade800,
                  fontFamily: app_font,
                  fontWeight: FontWeight.w600,
                  fontSize: 10))
        ],
      ),
    );
  }
}
