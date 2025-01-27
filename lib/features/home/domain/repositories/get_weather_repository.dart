import 'package:craftsiliconweather/core/common/error/failures.dart';
import 'package:craftsiliconweather/features/home/data/models/weather_body.dart';
import 'package:craftsiliconweather/features/home/data/models/weather_response.dart';
import 'package:dartz/dartz.dart';

abstract class GetWeatherRepository {
  /// Get Weather
  /// [getWeather]
  Future<Either<Failure, WeatherResponse>> getWeatherRemote(
      {required WeatherBody weatherParams});

  Future<Either<Failure, WeatherResponse?>> getWeatherLocal();
}
