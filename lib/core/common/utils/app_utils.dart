import 'package:craftsiliconweather/core/common/constants/dimens.dart';
import 'package:craftsiliconweather/core/common/presentation/widgets/app_button.dart';
import 'package:craftsiliconweather/core/common/presentation/widgets/app_textview_medium.dart';
import 'package:craftsiliconweather/core/common/presentation/widgets/app_textview_small.dart';
import 'package:craftsiliconweather/core/common/utils/internet_checker.dart';
import 'package:craftsiliconweather/features/home/presentation/bloc/location_permission_bloc.dart';
import 'package:craftsiliconweather/features/home/presentation/bloc/location_permission_event.dart';
import 'package:craftsiliconweather/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

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
      return Icons.filter_drama_outlined;
    case "broken clouds":
      return Icons.cloud_outlined;
    case "overcast clouds":
      return Icons.cloud_queue_outlined;
    case "shower rain":
      return Icons.shower_outlined; // Custom shower icon
    case "light rain":
    case "moderate rain":
    case "heavy intensity rain":
    case "very heavy rain":
    case "extreme rain":
      return Icons.umbrella_outlined;
    case "freezing rain":
      return Icons.ac_unit_outlined;
    case "thunderstorm":
    case "thunderstorm with light rain":
    case "thunderstorm with rain":
    case "thunderstorm with heavy rain":
    case "thunderstorm with light drizzle":
    case "thunderstorm with drizzle":
    case "thunderstorm with heavy drizzle":
      return Icons.thunderstorm_outlined;
    case "snow":
    case "light snow":
    case "heavy snow":
    case "sleet":
    case "light shower sleet":
    case "shower sleet":
    case "light rain and snow":
    case "rain and snow":
    case "light shower snow":
    case "shower snow":
    case "heavy shower snow":
      return Icons.ac_unit_outlined;
    case "mist":
    case "smoke":
    case "haze":
    case "dust":
    case "fog":
    case "sand":
    case "ash":
      return Icons.blur_on_outlined;
    case "squall":
      return Icons.air_outlined;
    case "tornado":
      return Icons.sync_outlined; // Use a rotating/swirling icon
    default:
      return Icons.wb_cloudy_outlined; // Default icon
  }
}

void showBottomSheetForm(
    {required BuildContext context,
    required Widget view,
    Function()? onDialogDissmissed,
    bool isDismissible = true}) {
  showModalBottomSheet<void>(
    enableDrag: false,
    context: context,
    isDismissible: isDismissible,
    useSafeArea: true,
    isScrollControlled: true, // Allow the sheet to take up the full height
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32), topRight: Radius.circular(32))),
    builder: (BuildContext context) {
      return view;
    },
  ).whenComplete(() {
    onDialogDissmissed != null ? onDialogDissmissed() : null;
  });
}

void showPermissionDialog(BuildContext context) {
  showBottomSheetForm(
    context: context,
    view: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          height: app_large_padding,
        ),
        const AppTextViewMedium(
            text: 'Location Permission Needed',
            fontSize: 18,
            textAlign: TextAlign.center),
        const SizedBox(
          height: app_large_padding,
        ),
        AppTextViewSubtitleSmall(
          fontSize: 14,
          maxLines: 4,
          text:
              'This app needs location access to provide location-based services. Please allow access to continue.',
          textAlign: TextAlign.start,
        ),
        const SizedBox(
          height: app_large_padding,
        ),
        const SizedBox(
          height: app_large_padding,
        ),
        AppButton(
          buttonText: 'Allow access to location',
          buttonColor: kPrimaryColor,
          buttonRadius: app_padding,
          buttonTextColor: kDarkBannerColor,
          onPressed: () {
            Navigator.of(context, rootNavigator: false).pop();

            context
                .read<LocationPermissionBloc>()
                .add(RequestLocationPermission());
          },
        ),
        const SizedBox(
          height: app_large_padding,
        ),
      ],
    ),
  );
}

void showPermanentDenialDialog(BuildContext context) {
  showBottomSheetForm(
    context: context,
    view: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          height: app_large_padding,
        ),
        const AppTextViewSubtitleSmall(
            text: 'Location Permission Needed',
            fontSize: 16,
            textAlign: TextAlign.center),
        const SizedBox(
          height: app_large_padding,
        ),
        AppTextViewSubtitleSmall(
          text:
              'Location permission is permanently denied. Please enable it from the app settings to use this feature.',
          textAlign: TextAlign.start,
        ),
        const SizedBox(
          height: app_large_padding,
        ),
        const SizedBox(
          height: app_large_padding,
        ),
        AppTextViewMedium(
          text: 'Open Settings',
          textAlign: TextAlign.start,
          onClick: () {
            Navigator.of(context, rootNavigator: false).pop();
            openAppSettings();
          },
        ),
        const SizedBox(
          height: app_large_padding,
        ),
      ],
    ),
  );
}

extension StringExtension on String {
  String capitalizeFirstLetter() {
    if (isEmpty) {
      return this;
    }
    return this[0].toUpperCase() + substring(1);
  }
}

String getDayOfWeek(int timestamp) {
  // Convert the timestamp to a DateTime object
  final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);

  // Get the day of the week and the day of the month
  final dayOfWeek = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday'
  ][date.weekday % 7];
  final dayOfMonth = date.day;

  // Format the result
  return '$dayOfWeek, $dayOfMonth';
}

// Check for bandwidth by making a small request to a reliable server
Future<bool?> checkIfInternetIsAvailable() async {
  // Check if Internet connection is available
  final internetChecker = InternetChecker();

  return internetChecker.isInternetAvailable();
}
