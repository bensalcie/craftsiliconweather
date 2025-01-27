import 'package:craftsiliconweather/core/common/utils/app_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('timeAgo', () {
    test('returns "Now" for differences less than 60 seconds', () {
      final int now = DateTime.now().millisecondsSinceEpoch;
      expect(timeAgo(now), "Now");
      expect(timeAgo(now - 5000), "Now"); // 5 seconds ago
    });

    test('returns minutes for differences less than 60 minutes', () {
      final int fiveMinutesAgo = DateTime.now()
          .subtract(const Duration(minutes: 5))
          .millisecondsSinceEpoch;
      expect(timeAgo(fiveMinutesAgo), "5 minutes ago");

      final int oneMinuteAgo = DateTime.now()
          .subtract(const Duration(minutes: 1))
          .millisecondsSinceEpoch;
      expect(timeAgo(oneMinuteAgo), "1 minute ago");
    });

    test('returns hours for differences less than 24 hours', () {
      final int twoHoursAgo = DateTime.now()
          .subtract(const Duration(hours: 2))
          .millisecondsSinceEpoch;
      expect(timeAgo(twoHoursAgo), "2 hours ago");

      final int oneHourAgo = DateTime.now()
          .subtract(const Duration(hours: 1))
          .millisecondsSinceEpoch;
      expect(timeAgo(oneHourAgo), "1 hour ago");
    });

    test('returns days for differences less than 30 days', () {
      final int fiveDaysAgo = DateTime.now()
          .subtract(const Duration(days: 5))
          .millisecondsSinceEpoch;
      expect(timeAgo(fiveDaysAgo), "5 days ago");

      final int oneDayAgo = DateTime.now()
          .subtract(const Duration(days: 1))
          .millisecondsSinceEpoch;
      expect(timeAgo(oneDayAgo), "1 day ago");
    });

    test('returns months for differences less than 12 months', () {
      final int twoMonthsAgo = DateTime.now()
          .subtract(const Duration(days: 60)) // Approximately 2 months
          .millisecondsSinceEpoch;
      expect(timeAgo(twoMonthsAgo), "2 months ago");

      final int oneMonthAgo = DateTime.now()
          .subtract(const Duration(days: 30)) // Approximately 1 month
          .millisecondsSinceEpoch;
      expect(timeAgo(oneMonthAgo), "1 month ago");
    });

    test('returns years for differences greater than or equal to 12 months',
        () {
      final int twoYearsAgo = DateTime.now()
          .subtract(const Duration(days: 730)) // Approximately 2 years
          .millisecondsSinceEpoch;
      expect(timeAgo(twoYearsAgo), "2 years ago");

      final int oneYearAgo = DateTime.now()
          .subtract(const Duration(days: 365)) // Approximately 1 year
          .millisecondsSinceEpoch;
      expect(timeAgo(oneYearAgo), "1 year ago");
    });
  });
}
