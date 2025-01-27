import 'package:craftsiliconweather/core/common/constants/app_strings.dart';
import 'package:craftsiliconweather/core/common/data/datasources/local/storage_utils.dart';
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
  Future<WeatherResponse> getWeatherRemote({required WeatherBody payload});
}

@LazySingleton(as: GetWeatherRemoteDataSource)
class GetWeatherRemoteDataSourceImpl implements GetWeatherRemoteDataSource {
  final DioClient _client;
  final StorageUtils storageUtils;

  GetWeatherRemoteDataSourceImpl(this._client, this.storageUtils);

  @override
  Future<WeatherResponse> getWeatherRemote(
      {required WeatherBody payload}) async {
    try {
      final response =
          await _client.get('/weather', queryParameters: payload.toJson());
      if (kDebugMode) {
        print('GetWeatherRemoteDataSource response: $response');
      }

      //Persist on Local storage.
      final weatherResponse = WeatherResponse.fromJson(response);
      await storageUtils.saveJsonData(weatherkey, weatherResponse.toJson);
      return weatherResponse;
    } catch (e) {
      if (kDebugMode) {
        print('GetWeatherRemoteDataSource response: $e');
      }
      rethrow;
    }
  }
}
