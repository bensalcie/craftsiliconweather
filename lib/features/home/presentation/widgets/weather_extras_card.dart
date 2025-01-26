import 'package:craftsiliconweather/core/common/constants/dimens.dart';
import 'package:craftsiliconweather/core/common/presentation/widgets/app_textview_medium.dart';
import 'package:craftsiliconweather/core/common/presentation/widgets/app_textview_small.dart';
import 'package:craftsiliconweather/features/home/data/models/weather_response.dart';
import 'package:craftsiliconweather/themes/theme.dart';
import 'package:flutter/material.dart';

class WeatherExtrasDetailCard extends StatelessWidget {
  const WeatherExtrasDetailCard({super.key, required this.weather});
  final WeatherResponse? weather;

  @override
  Widget build(BuildContext context) {
    return Ink(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16), topRight: Radius.circular(16)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTextViewMedium(
            textColor: kLightColor,
            text: 'About App',
            padding: 0,
            fontSize: 23,
            paddingvertical: 10,
            textAlign: TextAlign.center,
          ),
          const SizedBox(width: app_large_padding),
          const SizedBox(width: app_large_padding),
          AppTextViewMedium(
            text: 'App Version ',
            fontSize: 19,
            weight: FontWeight.w400,
            textColor: Colors.white,
            padding: 0,
            textAlign: TextAlign.start,
          ),
          const SizedBox(width: 16),
          AppTextViewSubtitleSmall(
            text: 'v1.0.0',
            weight: FontWeight.w300,
            padding: 0,
            textColor: Colors.white,
            textAlign: TextAlign.center,
          ),
          const SizedBox(width: app_large_padding),
          AppTextViewMedium(
            text: 'Open Weather Map API',
            textColor: Colors.white,
            fontSize: 19,
            weight: FontWeight.w400,
            padding: 0,
            textAlign: TextAlign.center,
          ),
          const SizedBox(width: 16),
          AppTextViewSubtitleSmall(
            text: ' v.2.5',
            weight: FontWeight.w300,
            padding: 0,
            textColor: Colors.white,
            textAlign: TextAlign.center,
          ),
          const SizedBox(width: app_large_padding),
          AppTextViewMedium(
            text: 'Open source libraries used',
            fontSize: 19,
            onClick: () => showLicensePage(context: context),
            weight: FontWeight.w400,
            textColor: Colors.white,
            padding: 0,
            textAlign: TextAlign.center,
          ),
          const SizedBox(width: app_padding),
          AppTextViewSubtitleSmall(
            text: 'Select to View',
            weight: FontWeight.w300,
            padding: 0,
            onTap: () => showLicensePage(context: context),
            textColor: Colors.white,
            textAlign: TextAlign.center,
          ),
          const SizedBox(width: 16),
        ],
      ),
    );
  }
}
