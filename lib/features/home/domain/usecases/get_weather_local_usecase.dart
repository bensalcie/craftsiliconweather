import 'package:craftsiliconweather/core/common/error/failures.dart';
import 'package:craftsiliconweather/core/common/usecases/usecase.dart';
import 'package:craftsiliconweather/features/home/data/models/weather_response.dart';
import 'package:craftsiliconweather/features/home/domain/repositories/get_weather_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetWeatherLocalUseCase implements UseCase<WeatherResponse, NoParams> {
  final GetWeatherRepository _dealsRepository;

  GetWeatherLocalUseCase(this._dealsRepository);

  @override
  Future<Either<Failure, WeatherResponse?>> call(NoParams noParams) async {
    return await _dealsRepository.getWeatherLocal();
  }
}
