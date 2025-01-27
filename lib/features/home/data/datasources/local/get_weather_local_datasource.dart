import 'package:craftsiliconweather/core/common/constants/app_strings.dart';
import 'package:craftsiliconweather/core/common/data/datasources/local/storage_utils.dart';
import 'package:craftsiliconweather/core/common/error/exceptions.dart';
import 'package:craftsiliconweather/features/home/data/models/weather_response.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

abstract class GetWeatherLocalDataSource {
  ///[GetWeatherLocalDataSource] Call api to Get Home Views
  ///
  ///
  /// Throws a [ServerException] for all error codes.
  Future<WeatherResponse?> getWeatherLocal();
}

@LazySingleton(as: GetWeatherLocalDataSource)
class GetWeatherLocalDataSourceImpl implements GetWeatherLocalDataSource {
  final StorageUtils storageUtils;

  GetWeatherLocalDataSourceImpl(this.storageUtils);

  @override
  Future<WeatherResponse?> getWeatherLocal() async {
    try {
      final weatherResponse = storageUtils.getJsonData<WeatherResponse?>(
        weatherkey,
        WeatherResponse.fromJson,
      );

      if (weatherResponse != null) {
        return weatherResponse;
      } else {
        throw NoDataException();
      }
    } catch (e) {
      if (kDebugMode) {
        print('GetWeatherLocalDataSource response: $e');
      }
      rethrow;
    }
  }
}
