import 'package:craftsiliconweather/core/common/constants/app_strings.dart';
import 'package:craftsiliconweather/core/common/constants/dimens.dart';
import 'package:craftsiliconweather/core/common/presentation/widgets/app_shimmer_vertical_loader.dart';
import 'package:craftsiliconweather/core/common/presentation/widgets/app_textview_medium.dart';
import 'package:craftsiliconweather/features/home/presentation/bloc/get_weather_bloc.dart';
import 'package:craftsiliconweather/features/home/presentation/widgets/current_weather_status.dart';
import 'package:craftsiliconweather/features/home/presentation/widgets/forecast_section.dart';
import 'package:craftsiliconweather/features/home/presentation/widgets/location_permission_view.dart';
import 'package:craftsiliconweather/features/home/presentation/widgets/weather_header.dart';
import 'package:craftsiliconweather/features/home/presentation/widgets/weather_summary_small.dart';
import 'package:craftsiliconweather/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Ink(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF645AFF),
                    Color(0xFF8A77FF),
                  ],
                ),
              ),
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
                        AppBar(
                          backgroundColor: Colors.transparent,
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
                                    AppTextViewMedium(
                                      text: app_title,
                                      padding: 4,
                                      fontSize: 20,
                                      textColor: kLightColor,
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
                        WeatherHeader(weather: weather),
                        const SizedBox(height: app_small_padding),
                        LocationPermissionView(),
                        const SizedBox(height: app_small_padding),
                        CurrentWeatherStatus(weather: weather),
                        const SizedBox(height: app_small_padding),
                        WeatherSummarySmall(weather: weather),
                        const SizedBox(height: app_padding),
                        const ForecastSection()
                      ],
                    );
                  }
                  return SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
