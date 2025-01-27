import 'package:craftsiliconweather/core/common/error/exceptions.dart';
import 'package:craftsiliconweather/core/common/error/failures.dart';
import 'package:craftsiliconweather/features/home/data/datasources/local/get_weather_local_datasource.dart';
import 'package:craftsiliconweather/features/home/data/datasources/remote/get_weather_remote_datasource.dart';
import 'package:craftsiliconweather/features/home/data/models/weather_body.dart';
import 'package:craftsiliconweather/features/home/data/models/weather_response.dart';
import 'package:craftsiliconweather/features/home/domain/repositories/get_weather_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: GetWeatherRepository)
class GetWeatherRepositoryImpl implements GetWeatherRepository {
  final GetWeatherRemoteDataSource _getWeatherRemoteDataSource;
  final GetWeatherLocalDataSource _getWeatherLocalDataSource;

  GetWeatherRepositoryImpl(
      this._getWeatherRemoteDataSource, this._getWeatherLocalDataSource);

  @override
  Future<Either<Failure, WeatherResponse>> getWeatherRemote(
      {required WeatherBody weatherParams}) async {
    try {
      final response = await _getWeatherRemoteDataSource.getWeatherRemote(
          payload: weatherParams);

      return Right(response);
    } on ServerException {
      /// An error occurred of type server
      /// Probably some problem with the server.
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, WeatherResponse?>> getWeatherLocal() async {
    try {
      final response = await _getWeatherLocalDataSource.getWeatherLocal();

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
