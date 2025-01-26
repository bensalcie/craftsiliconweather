import 'package:craftsiliconweather/core/common/presentation/widgets/app_textview_small_no_tap.dart';
import 'package:craftsiliconweather/themes/theme.dart';
import 'package:flutter/material.dart';

class WeatherDetailCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const WeatherDetailCard({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3),
        child: Ink(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.0),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Icon(icon, size: 30, color: kLightColor),
              const SizedBox(height: 5),
              AppTextViewSubtitleSmallNoTap(
                text: label,
                fontSize: 9,
                padding: 0,
                maxLines: 1,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 5),
              AppTextViewSubtitleSmallNoTap(
                text: value,
                maxLines: 2,
                padding: 0,
                fontSize: 10,
                textAlign: TextAlign.start,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
