import 'package:craftsiliconweather/core/common/network/dio_config.dart';
import 'package:craftsiliconweather/features/home/data/models/forecast_body.dart';
import 'package:craftsiliconweather/features/home/data/models/forecast_response.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

abstract class GetForecastRemoteDataSource {
  ///[GetForecastRemoteDataSource] Call api to Get Home Views
  ///
  ///
  /// Throws a [ServerException] for all error codes.
  Future<ForecastResponse> getForecast({required ForecastBody payload});
}

@LazySingleton(as: GetForecastRemoteDataSource)
class GetForecastRemoteDataSourceImpl implements GetForecastRemoteDataSource {
  final DioClient _client;

  GetForecastRemoteDataSourceImpl(this._client);

  @override
  Future<ForecastResponse> getForecast({required ForecastBody payload}) async {
    try {
      final response =
          await _client.get('/forecast', queryParameters: payload.toJson());
      if (kDebugMode) {
        print('GetForecastRemoteDataSource response: $response');
      }

      final res = ForecastResponse.fromJson(response);
      return res;
    } catch (e) {
      if (kDebugMode) {
        print('GetForecastRemoteDataSource response: $e');
      }
      rethrow;
    }
  }
}
