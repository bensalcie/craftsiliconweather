import 'package:craftsiliconweather/core/common/error/exceptions.dart';
import 'package:craftsiliconweather/core/common/error/failures.dart';
import 'package:craftsiliconweather/features/home/data/datasources/get_forecast_remote_datasource.dart';
import 'package:craftsiliconweather/features/home/data/models/forecast_body.dart';
import 'package:craftsiliconweather/features/home/data/models/forecast_response.dart';
import 'package:craftsiliconweather/features/home/domain/repositories/get_forecast_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: GetForecastRepository)
class GetForecastRepositoryImpl implements GetForecastRepository {
  final GetForecastRemoteDataSource _getWeatherRemoteDataSource;

  GetForecastRepositoryImpl(this._getWeatherRemoteDataSource);

  @override
  Future<Either<Failure, ForecastResponse>> getForecast(
      {required ForecastBody weatherParams}) async {
    try {
      final response =
          await _getWeatherRemoteDataSource.getForecast(payload: weatherParams);

      return Right(response);
    } on ServerException {
      /// An error occurred of type server
      /// Probably some problem with the server.
      return Left(ServerFailure());
    }
  }
}
