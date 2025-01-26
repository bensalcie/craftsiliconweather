import 'package:craftsiliconweather/core/common/error/exceptions.dart';
import 'package:craftsiliconweather/core/common/error/failures.dart';
import 'package:craftsiliconweather/features/home/data/datasources/get_weather_remote_datasource.dart';
import 'package:craftsiliconweather/features/home/data/models/weather_body.dart';
import 'package:craftsiliconweather/features/home/data/models/weather_response.dart';
import 'package:craftsiliconweather/features/home/domain/repositories/get_weather_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: GetWeatherRepository)
class GetWeatherRepositoryImpl implements GetWeatherRepository {
  final GetWeatherRemoteDataSource _getWeatherRemoteDataSource;

  GetWeatherRepositoryImpl(this._getWeatherRemoteDataSource);

  @override
  Future<Either<Failure, WeatherResponse>> getWeather(
      {required WeatherBody weatherParams}) async {
    try {
      final response =
          await _getWeatherRemoteDataSource.getWeather(payload: weatherParams);

      return Right(response);
    } on ServerException {
      /// An error occurred of type server
      /// Probably some problem with the server.
      return Left(ServerFailure());
    }
  }
}
