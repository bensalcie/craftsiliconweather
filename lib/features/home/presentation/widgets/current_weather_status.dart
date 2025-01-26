import 'package:craftsiliconweather/core/common/constants/dimens.dart';
import 'package:craftsiliconweather/core/common/utils/app_utils.dart';
import 'package:craftsiliconweather/features/home/data/models/weather_response.dart';
import 'package:flutter/material.dart';

class CurrentWeatherStatus extends StatelessWidget {
  const CurrentWeatherStatus({
    super.key,
    required this.weather,
  });

  final WeatherResponse weather;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          getWeatherIcon(weather.weather?[0]?.description ?? ''),
          size: 120,
          color: Colors.blueGrey[400],
        ),
        Text(
          "${weather.main?.temp ?? 'N/A'}°C",
          style: TextStyle(
            fontSize: 60,
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey[800],
          ),
        ),
        const SizedBox(height: elements_small_padding),
        Text(
          weather.weather?[0]?.description ?? '',
          style: TextStyle(
            fontSize: 22,
            color: Colors.blueGrey[600],
          ),
        ),
      ],
    );
  }
}
