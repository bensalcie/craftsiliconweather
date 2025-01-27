import 'package:craftsiliconweather/core/common/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('formatTime Tests', () {
    test('formatTime formats valid timestamps correctly', () {
      int timestamp = 1633096800; // Represents a specific time
      String result = formatTime(timestamp);
      expect(result, isNotEmpty); // Expecting a non-empty string (formatted time)
    });

    test('formatTime returns "N/A" for null timestamp', () {
      String result = formatTime(null);
      expect(result, 'N/A'); // Null timestamp should result in "N/A"
    });

    test('formatTime returns "N/A" for invalid timestamp', () {
      int? timestamp; // Invalid timestamp
      String result = formatTime(timestamp);
      expect(result, 'N/A'); // Invalid timestamp should return "N/A"
    });
  });

  group('getWeatherIcon Tests', () {
    test('getWeatherIcon returns correct icon for "clear sky"', () {
      IconData result = getWeatherIcon("clear sky");
      expect(result, Icons.wb_sunny_outlined);
    });

    test('getWeatherIcon returns correct icon for "few clouds"', () {
      IconData result = getWeatherIcon("few clouds");
      expect(result, Icons.cloud_outlined);
    });

    test('getWeatherIcon returns correct icon for "scattered clouds"', () {
      IconData result = getWeatherIcon("scattered clouds");
      expect(result, Icons.filter_drama_outlined);
    });

    test('getWeatherIcon returns correct icon for unknown weather descriptions', () {
      IconData result = getWeatherIcon("unknown weather");
      expect(result, Icons.wb_cloudy_outlined); // Default icon
    });

    test('getWeatherIcon handles case-insensitive weather descriptions', () {
      IconData result = getWeatherIcon("CLEAR SKY");
      expect(result, Icons.wb_sunny_outlined); // Should match case-insensitively
    });

    test('getWeatherIcon returns correct icon for "snow"', () {
      IconData result = getWeatherIcon("snow");
      expect(result, Icons.ac_unit_outlined);
    });

    test('getWeatherIcon returns correct icon for "mist"', () {
      IconData result = getWeatherIcon("mist");
      expect(result, Icons.blur_on_outlined);
    });

    test('getWeatherIcon returns correct icon for "thunderstorm with light rain"', () {
      IconData result = getWeatherIcon("thunderstorm with light rain");
      expect(result, Icons.thunderstorm_outlined);
    });

    test('getWeatherIcon handles unexpected weather gracefully', () {
      IconData result = getWeatherIcon("");
      expect(result, Icons.wb_cloudy_outlined); // Default to cloudy for empty strings
    });
  });
}
