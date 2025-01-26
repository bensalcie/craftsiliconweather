import 'package:craftsiliconweather/core/common/presentation/widgets/app_textview_subtitle.dart';
import 'package:craftsiliconweather/features/home/data/models/weather_response.dart';
import 'package:flutter/material.dart';

class WeatherHeader extends StatelessWidget {
  const WeatherHeader({
    super.key,
    required this.weather,
  });

  final WeatherResponse weather;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              weather.name ?? '',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey[800],
              ),
            ),
            AppTextViewSubtitle(
                padding: 1,
                text: weather.sys?.country ?? '',
                textAlign: TextAlign.start,
                textColor: Colors.blueGrey[600])
          ],
        ),
        const Icon(Icons.location_on, size: 30, color: Colors.blueGrey),
      ],
    );
  }
}
