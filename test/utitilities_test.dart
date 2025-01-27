import 'package:craftsiliconweather/core/common/utils/app_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('formatTime Tests', () {
    test('formatTime formats valid timestamps correctly', () {
      int timestamp = 1633096800; // Represents a specific time
      String result = formatTime(timestamp);
      expect(
          result, isNotEmpty); // Expecting a non-empty string (formatted time)
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
}
