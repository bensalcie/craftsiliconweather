import 'package:craftsiliconweather/core/common/error/failures.dart';
import 'package:craftsiliconweather/core/common/usecases/usecase.dart';
import 'package:craftsiliconweather/features/home/data/models/forecast_body.dart';
import 'package:craftsiliconweather/features/home/data/models/forecast_response.dart';
import 'package:craftsiliconweather/features/home/domain/repositories/get_forecast_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetForecastRemoteUseCase
    implements UseCase<ForecastResponse, ForecastBody> {
  final GetForecastRepository _dealsRepository;

  GetForecastRemoteUseCase(this._dealsRepository);

  @override
  Future<Either<Failure, ForecastResponse>> call(ForecastBody params) async {
    return await _dealsRepository.getForecastRemote(weatherParams: params);
  }
}
