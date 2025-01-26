import 'package:craftsiliconweather/core/common/constants/app_strings.dart';
import 'package:craftsiliconweather/core/common/constants/dimens.dart';
import 'package:craftsiliconweather/core/common/presentation/widgets/app_shimmer_vertical_loader.dart';
import 'package:craftsiliconweather/core/common/presentation/widgets/app_textview_medium.dart';
import 'package:craftsiliconweather/core/common/utils/app_utils.dart';
import 'package:craftsiliconweather/features/home/presentation/bloc/get_weather_bloc.dart';
import 'package:craftsiliconweather/features/home/presentation/widgets/current_weather_status.dart';
import 'package:craftsiliconweather/features/home/presentation/widgets/forecast_section.dart';
import 'package:craftsiliconweather/features/home/presentation/widgets/weather_details_card.dart';
import 'package:craftsiliconweather/features/home/presentation/widgets/weather_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        automaticallyImplyLeading: true,
        title: SizedBox(
          height: 120,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: app_padding,
              ),
              Row(
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    height: 34,
                    width: 34,
                  ),
                  const SizedBox(
                    width: app_padding,
                  ),
                  const AppTextViewMedium(
                    text: app_title,
                    padding: 4,
                    fontSize: 20,
                    weight: FontWeight.w800,
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ],
          ),
        ),
        iconTheme: const IconThemeData(size: 24),
        titleSpacing: 20,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: app_padding),
        child: SingleChildScrollView(
          child: BlocBuilder<GetWeatherBloc, GetWeatherState>(
            builder: (context, state) {
              if (state is GetWeatherLoading) {
                return const AppShimmerVerticalLoader(
                  height: 100,
                  width: double.infinity,
                  itemCount: 5,
                  isCircular: false,
                  isRounded: true,
                  borderRadius: 10.0,
                );
              }

              if (state is GetWeatherSuccess) {
                final weather = state.weatherResponse;

                return ListView(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    WeatherHeader(weather: weather),
                    CurrentWeatherStatus(weather: weather),
                    const SizedBox(height: app_padding),
                    Row(
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
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
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
                    ),
                    const SizedBox(height: app_padding),
                    const ForecastSection()
                  ],
                );
              }
              return SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
