import 'package:craftsiliconweather/core/common/constants/dimens.dart';
import 'package:craftsiliconweather/core/common/presentation/widgets/app_textview_subtitle.dart';
import 'package:craftsiliconweather/features/home/data/models/weather_response.dart';
import 'package:craftsiliconweather/themes/theme.dart';
import 'package:flutter/material.dart';

class WeatherHeader extends StatelessWidget {
  const WeatherHeader({
    super.key,
    required this.weather,
  });

  final WeatherResponse? weather;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: app_padding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                weather?.name ?? 'Search city...',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              AppTextViewSubtitle(
                  padding: 1,
                  text: weather?.sys?.country ?? '',
                  textAlign: TextAlign.start,
                  textColor: Colors.white)
            ],
          ),
          Icon(Icons.location_on, size: 30, color: kLightColor),
        ],
      ),
    );
  }
}
