import 'package:cached_network_image/cached_network_image.dart';
import 'package:craftsiliconweather/core/common/constants/dimens.dart';
import 'package:craftsiliconweather/core/common/presentation/widgets/app_shimmer_grid_vertical_loader.dart';
import 'package:craftsiliconweather/core/common/presentation/widgets/app_textview_small_no_tap.dart';
import 'package:craftsiliconweather/core/common/utils/app_utils.dart';
import 'package:craftsiliconweather/features/home/data/models/forecast_response.dart';
import 'package:craftsiliconweather/features/home/presentation/bloc/get_forecast_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForecastSection extends StatelessWidget {
  const ForecastSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Ink(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16), topRight: Radius.circular(16)),
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
                    itemCount: 6,
                    isCircular: false,
                    isRounded: true,
                    borderRadius: 16,
                  ),
                );
              }
              if (state is GetForecastSuccess) {
                final forecastItems = state.forecastRepsonse.list;

                // Use a map to retain only the last occurrence of each day
                final Map<String, ListElement> uniqueDays = {};
                for (final item in forecastItems) {
                  uniqueDays[getDayOfWeek(item.dt)] =
                      item; // Replace old item with the latest one
                }

                // Convert the map values back to a strongly-typed list
                final List<ListElement> filteredForecastItems =
                    uniqueDays.values.toList();

                return ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: filteredForecastItems.length,
                  separatorBuilder: (context, index) =>
                      Divider(color: Colors.grey[800]),
                  itemBuilder: (context, index) {
                    final item = filteredForecastItems[
                        index]; // Assuming item is of type ListElement
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              getDayOfWeek(item.dt),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(width: 16),
                            CachedNetworkImage(
                              imageUrl:
                                  "https://openweathermap.org/img/wn/${item.weather.first.icon}@2x.png",
                              width: 30,
                              color: Colors.orange.shade400,
                              height: 30,
                              errorWidget: (context, url, error) => Image.asset(
                                // Load the weather icon using the "icon" field from Weather
                                'assets/images/logo.png',
                                width: 30,
                                color: Colors.orange.shade400,
                                height: 30,
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "${item.main.tempMax.toStringAsFixed(1)}°C",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: elements_small_padding),
                            AppTextViewSubtitleSmallNoTap(
                              maxLines: 1,
                              text: "${item.main.tempMin.toStringAsFixed(1)}°C",
                              textAlign: TextAlign.start,
                            ),
                            const SizedBox(width: app_small_padding),
                            AppTextViewSubtitleSmallNoTap(
                              textAlign: TextAlign.start,
                              padding: 0,
                              maxLines: 1,
                              // Use description from the first Weather object
                              text: item.weather.first.description
                                  .capitalizeFirstLetter(),
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
}
