import 'package:cached_network_image/cached_network_image.dart';
import 'package:craftsiliconweather/core/common/constants/dimens.dart';
import 'package:craftsiliconweather/core/common/presentation/widgets/app_textview_medium.dart';
import 'package:craftsiliconweather/core/common/presentation/widgets/app_textview_small_no_tap.dart';
import 'package:craftsiliconweather/core/common/utils/app_utils.dart';
import 'package:craftsiliconweather/features/home/data/models/weather_response.dart';
import 'package:flutter/material.dart';

class CurrentWeatherStatus extends StatelessWidget {
  const CurrentWeatherStatus({
    super.key,
    required this.weather,
  });

  final WeatherResponse? weather;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: app_small_padding),
      child: Ink(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            CachedNetworkImage(
              height: 130,
              imageUrl:
                  "https://openweathermap.org/img/wn/${weather?.weather?.first?.icon}@4x.png",
              errorWidget: (context, url, error) => Image.asset(
                filterQuality: FilterQuality.high,
                fit: BoxFit.cover,
                'assets/images/logo.png',
                height: 130,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppTextViewMedium(
                    fontSize: 46,
                    maxLines: 2,
                    text:
                        "${weather?.main?.temp?.toStringAsFixed(1) ?? 'N/A'}°C",
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 5),
                  AppTextViewSubtitleSmallNoTap(
                    text: (weather?.weather?[0]?.description ?? '')
                        .capitalizeFirstLetter(),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
