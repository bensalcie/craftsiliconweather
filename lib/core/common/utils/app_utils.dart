import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String formatTime(int? timestamp) {
  if (timestamp == null) return 'N/A';
  try {
    return DateFormat.jm()
        .format(DateTime.fromMillisecondsSinceEpoch(timestamp * 1000));
  } catch (e) {
    return 'N/A';
  }
}

IconData getWeatherIcon(String description) {
  switch (description.toLowerCase()) {
    case "clear sky":
      return Icons.wb_sunny_outlined;
    case "few clouds":
      return Icons.cloud_outlined;
    case "scattered clouds":
    case "broken clouds":
      return Icons.wb_cloudy_outlined;
    case "shower rain":
    case "rain":
      return Icons.umbrella_outlined;
    case "thunderstorm":
    case "thunderstorm with light rain":
      return Icons.thunderstorm_outlined;
    case "snow":
      return Icons.ac_unit_outlined;
    case "mist":
      return Icons.blur_on_outlined;
    default:
      return Icons.wb_cloudy_outlined; // Default icon
  }
}
