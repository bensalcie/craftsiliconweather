import 'package:craftsiliconweather/core/common/di/injection.dart';
import 'package:craftsiliconweather/features/home/data/models/weather_body.dart';
import 'package:craftsiliconweather/features/home/presentation/bloc/get_forecast_bloc.dart';
import 'package:craftsiliconweather/features/home/presentation/bloc/get_weather_bloc.dart';
import 'package:craftsiliconweather/features/home/presentation/bloc/location_permission_bloc.dart';
import 'package:craftsiliconweather/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocsRoot extends StatelessWidget {
  const BlocsRoot({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => getIt<GetWeatherBloc>()
              ..add(
                GetWeather(
                    weatherBody: WeatherBody(placename: 'Nairobi'),
                    isSearchPage: false),
              )),
        BlocProvider(create: (context) => getIt<GetForecastBloc>()),
        BlocProvider(create: (context) => getIt<LocationPermissionBloc>()),
      ],
      child: MyApp(),
    );
  }
}
