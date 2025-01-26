import 'package:craftsiliconweather/core/common/error/failures.dart';
import 'package:craftsiliconweather/features/home/data/models/forecast_body.dart';
import 'package:craftsiliconweather/features/home/data/models/forecast_response.dart';
import 'package:dartz/dartz.dart';

abstract class GetForecastRepository {
  /// [getForecast]
  Future<Either<Failure, ForecastResponse>> getForecast(
      {required ForecastBody weatherParams});
}
