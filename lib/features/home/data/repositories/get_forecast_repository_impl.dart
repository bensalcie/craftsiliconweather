import 'package:craftsiliconweather/core/common/error/exceptions.dart';
import 'package:craftsiliconweather/core/common/error/failures.dart';
import 'package:craftsiliconweather/features/home/data/datasources/local/get_forecast_local_datasource.dart';
import 'package:craftsiliconweather/features/home/data/datasources/remote/get_forecast_remote_datasource.dart';
import 'package:craftsiliconweather/features/home/data/models/forecast_body.dart';
import 'package:craftsiliconweather/features/home/data/models/forecast_response.dart';
import 'package:craftsiliconweather/features/home/domain/repositories/get_forecast_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: GetForecastRepository)
class GetForecastRepositoryImpl implements GetForecastRepository {
  final GetForecastRemoteDataSource _getWeatherRemoteDataSource;
  final GetForecastLocalDataSource _getWeatherLocalDataSource;

  GetForecastRepositoryImpl(
      this._getWeatherRemoteDataSource, this._getWeatherLocalDataSource);

  @override
  Future<Either<Failure, ForecastResponse>> getForecastRemote(
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

  @override
  Future<Either<Failure, ForecastResponse>> getForecastLocal() async {
    try {
      final response = await _getWeatherLocalDataSource.getForecastLocal();

      return Right(response);
    } on NoDataException {
      return Left(ServerFailure());
    } on ServerException {
      /// An error occurred of type server
      /// Probably some problem with the server.
      return Left(ServerFailure());
    }
  }
}
