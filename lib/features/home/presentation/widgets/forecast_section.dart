import 'package:craftsiliconweather/core/common/presentation/widgets/app_shimmer_grid_vertical_loader.dart';
import 'package:craftsiliconweather/features/home/data/models/forecast_body.dart';
import 'package:craftsiliconweather/features/home/presentation/bloc/get_forecast_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForecastSection extends StatefulWidget {
  const ForecastSection({super.key});

  @override
  State<ForecastSection> createState() => _ForecastSectionState();
}

class _ForecastSectionState extends State<ForecastSection> {
  @override
  void initState() {
    _fetchForecast();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Weekly forecast",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          BlocBuilder<GetForecastBloc, GetForecastState>(
            builder: (context, state) {
              if (state is GetForecastLoading) {
                return const Center(
                  child: AppShimmerGridVerticalLoader(
                    height: 100,
                    width: 100,
                    itemCount: 5,
                    isCircular: false,
                    isRounded: true,
                    borderRadius: 16,
                  ),
                );
              }
              if (state is GetForecastSuccess) {
                final forecastItems = state.forecastRepsonse.list;
                return ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: forecastItems.length,
                  separatorBuilder: (context, index) =>
                      Divider(color: Colors.grey[800]),
                  itemBuilder: (context, index) {
                    final item = forecastItems[
                        index]; // Assuming item is of type ListElement
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              // Format the date (dt) from UNIX timestamp to a readable date
                              DateTime.fromMillisecondsSinceEpoch(
                                      item.dt * 1000)
                                  .toLocal()
                                  .toString()
                                  .split(' ')[0], // Example: 'YYYY-MM-DD'
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Image.network(
                              // Load the weather icon using the "icon" field from Weather
                              "https://openweathermap.org/img/wn/${item.weather.first.icon}.png",
                              color: Colors.orangeAccent,
                              width: 24,
                              height: 24,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "${item.main.tempMax.toStringAsFixed(1)}°",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              "${item.main.tempMin.toStringAsFixed(1)}°C",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Text(
                              // Use description from the first Weather object
                              item.weather.first.description,
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }

  void _fetchForecast() {
    context.read<GetForecastBloc>().add(GetForecast(
        weatherBody: ForecastBody(lat: -1.286389, lon: 36.817223, cnt: 5)));
  }
}
