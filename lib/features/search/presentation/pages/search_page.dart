import 'package:craftsiliconweather/core/common/constants/app_strings.dart';
import 'package:craftsiliconweather/core/common/constants/dimens.dart';
import 'package:craftsiliconweather/core/common/presentation/widgets/app_search_view.dart';
import 'package:craftsiliconweather/core/common/presentation/widgets/app_shimmer_vertical_loader.dart';
import 'package:craftsiliconweather/core/common/presentation/widgets/app_textview_medium.dart';
import 'package:craftsiliconweather/core/common/utils/app_utils.dart';
import 'package:craftsiliconweather/features/home/data/models/weather_body.dart';
import 'package:craftsiliconweather/features/home/presentation/bloc/search_weather_bloc.dart';
import 'package:craftsiliconweather/features/home/presentation/widgets/current_weather_status.dart';
import 'package:craftsiliconweather/features/home/presentation/widgets/weather_details_card.dart';
import 'package:craftsiliconweather/features/home/presentation/widgets/weather_extras_card.dart';
import 'package:craftsiliconweather/features/home/presentation/widgets/weather_header.dart';
import 'package:craftsiliconweather/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Expanded(
          flex: 1,
          child: Ink(
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
            child: Column(
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
                AppSearchView(
                    cancelLabel: 'Cancel',
                    searchHint: 'Seach City',
                    onSearchTermChanged: (term) {
                      context.read<SearchWeatherBloc>().add(SearchWeather(
                          isSearchPage: true,
                          weatherBody: WeatherBody(placename: term)));
                    }),
                BlocBuilder<SearchWeatherBloc, SearchWeatherState>(
                  builder: (context, state) {
                    if (state is SearchWeatherLoading) {
                      return const AppShimmerVerticalLoader(
                        height: 100,
                        width: double.infinity,
                        itemCount: 5,
                        isCircular: false,
                        isRounded: true,
                        borderRadius: 10.0,
                      );
                    }

                    if (state is SearchWeatherSuccess) {
                      final weather = state.weatherResponse;

                      return ListView(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: [
                          WeatherHeader(weather: weather),
                          const SizedBox(height: app_small_padding),
                          const SizedBox(height: app_small_padding),
                          CurrentWeatherStatus(weather: weather),
                          const SizedBox(height: app_small_padding),
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
                          WeatherExtrasDetailCard(weather: weather),
                        ],
                      );
                    }
                    return ListView(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: [
                        WeatherHeader(weather: null),
                        const SizedBox(height: app_small_padding),
                        const SizedBox(height: app_small_padding),
                        CurrentWeatherStatus(weather: null),
                        const SizedBox(height: app_small_padding),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            WeatherDetailCard(
                              icon: Icons.water_drop_outlined,
                              label: "Humidity",
                              value: "${0}%",
                            ),
                            WeatherDetailCard(
                              icon: Icons.air,
                              label: "Wind Speed",
                              value: "${0} m/s",
                            ),
                            WeatherDetailCard(
                              icon: Icons.wb_sunny_outlined,
                              label: "Sunrise",
                              value: formatTime(0),
                            ),
                            WeatherDetailCard(
                              icon: Icons.nights_stay_outlined,
                              label: "Sunset",
                              value: formatTime(0),
                            ),
                          ],
                        ),
                        const SizedBox(height: app_padding),
                        WeatherExtrasDetailCard(weather: null),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class WeatherTimeCard extends StatelessWidget {
  final String time;
  final String temp;
  final IconData icon;

  const WeatherTimeCard({
    super.key,
    required this.time,
    required this.temp,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 30, color: Colors.blue),
        const SizedBox(height: 10),
        Text(
          time,
          // style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
        ),
        const SizedBox(height: 5),
        Text(
          temp,
          // style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class WeatherFutureCard extends StatelessWidget {
  final String day;
  final String temp;
  final IconData icon;

  const WeatherFutureCard({
    super.key,
    required this.day,
    required this.temp,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 3,
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            day,
            // style: GoogleFonts.poppins(fontSize: 16),
          ),
          Row(
            children: [
              Icon(icon, size: 25, color: Colors.blue),
              const SizedBox(width: 10),
              Text(
                temp,
                // style: GoogleFonts.poppins(
                //   fontSize: 16,
                //   fontWeight: FontWeight.bold,
                // ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
