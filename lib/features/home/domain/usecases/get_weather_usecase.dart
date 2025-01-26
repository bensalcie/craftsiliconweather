import 'package:craftsiliconweather/core/common/error/failures.dart';
import 'package:craftsiliconweather/core/common/usecases/usecase.dart';
import 'package:craftsiliconweather/features/home/data/models/weather_body.dart';
import 'package:craftsiliconweather/features/home/data/models/weather_response.dart';
import 'package:craftsiliconweather/features/home/domain/repositories/get_weather_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetWeatherUseCase implements UseCase<WeatherResponse, WeatherBody> {
  final GetWeatherRepository _dealsRepository;

  GetWeatherUseCase(this._dealsRepository);

  @override
  Future<Either<Failure, WeatherResponse>> call(WeatherBody params) async {
    return await _dealsRepository.getWeather(weatherParams: params);
  }
}
