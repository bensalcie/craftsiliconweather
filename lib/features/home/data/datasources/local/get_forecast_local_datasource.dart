import 'package:craftsiliconweather/core/common/constants/app_strings.dart';
import 'package:craftsiliconweather/core/common/data/datasources/local/storage_utils.dart';
import 'package:craftsiliconweather/core/common/error/exceptions.dart';
import 'package:craftsiliconweather/features/home/data/models/forecast_response.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

abstract class GetForecastLocalDataSource {
  ///[GetForecastLocalDataSource] Call api to Get Home Views
  ///
  ///
  /// Throws a [ServerException] for all error codes.
  Future<ForecastResponse> getForecastLocal();
}

@LazySingleton(as: GetForecastLocalDataSource)
class GetForecastLocalDataSourceImpl implements GetForecastLocalDataSource {
  final StorageUtils storageUtils;

  GetForecastLocalDataSourceImpl(this.storageUtils);

  @override
  Future<ForecastResponse> getForecastLocal() async {
    try {
      final forecastResponse = storageUtils.getJsonData<ForecastResponse>(
        forecastkey,
        ForecastResponse.fromJson,
      );

      if (forecastResponse != null) {
        return forecastResponse;
      } else {
        throw NoDataException();
      }
    } catch (e) {
      if (kDebugMode) {
        print('GetForecastLocalDataSource response: $e');
      }
      rethrow;
    }
  }
}
