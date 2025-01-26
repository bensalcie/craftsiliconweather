import 'package:craftsiliconweather/core/common/utils/app_utils.dart';
import 'package:craftsiliconweather/features/home/data/models/weather_response.dart';
import 'package:craftsiliconweather/features/home/presentation/widgets/weather_details_card.dart';
import 'package:flutter/material.dart';

class WeatherSummarySmall extends StatelessWidget {
  const WeatherSummarySmall({
    super.key,
    required this.weather,
  });

  final WeatherResponse weather;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        WeatherDetailCard(
          icon: Icons.water_drop_outlined,
          label: "Humidity",
          value: "${weather.main?.humidity ?? 0}%",
        ),
        WeatherDetailCard(
          icon: Icons.air,
          label: "Wind Speed",
          value: "${weather.wind?.speed ?? 0} m/s",
        ),
        WeatherDetailCard(
          icon: Icons.wb_sunny_outlined,
          label: "Sunrise",
          value: formatTime(weather.sys?.sunrise),
        ),
        WeatherDetailCard(
          icon: Icons.nights_stay_outlined,
          label: "Sunset",
          value: formatTime(weather.sys?.sunset),
        ),
      ],
    );
  }
}
