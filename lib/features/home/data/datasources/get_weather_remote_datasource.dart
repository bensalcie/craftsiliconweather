import 'package:craftsiliconweather/core/common/network/dio_config.dart';
import 'package:craftsiliconweather/features/home/data/models/weather_body.dart';
import 'package:craftsiliconweather/features/home/data/models/weather_response.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

abstract class GetWeatherRemoteDataSource {
  ///[GetWeatherRemoteDataSource] Call api to Get Home Views
  ///
  ///
  /// Throws a [ServerException] for all error codes.
  Future<WeatherResponse> getWeather({required WeatherBody payload});
}

@LazySingleton(as: GetWeatherRemoteDataSource)
class GetWeatherRemoteDataSourceImpl implements GetWeatherRemoteDataSource {
  final DioClient _client;

  GetWeatherRemoteDataSourceImpl(this._client);

  @override
  Future<WeatherResponse> getWeather({required WeatherBody payload}) async {
    try {
      final response =
          await _client.get('/weather', queryParameters: payload.toJson());
      if (kDebugMode) {
        print('GetWeatherRemoteDataSource response: $response');
      }

      final res = WeatherResponse.fromJson(response);
      return res;
    } catch (e) {
      if (kDebugMode) {
        print('GetWeatherRemoteDataSource response: $e');
      }
      rethrow;
    }
  }
}
