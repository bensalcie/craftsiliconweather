import 'package:craftsiliconweather/core/common/error/failures.dart';
import 'package:craftsiliconweather/core/common/usecases/usecase.dart';
import 'package:craftsiliconweather/features/home/data/models/forecast_response.dart';
import 'package:craftsiliconweather/features/home/domain/repositories/get_forecast_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetForecastLocalUseCase implements UseCase<ForecastResponse, NoParams> {
  final GetForecastRepository _dealsRepository;

  GetForecastLocalUseCase(this._dealsRepository);

  @override
  Future<Either<Failure, ForecastResponse>> call(NoParams params) async {
    return await _dealsRepository.getForecastLocal();
  }
}
