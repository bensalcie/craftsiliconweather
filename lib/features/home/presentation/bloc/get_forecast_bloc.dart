import 'package:bloc/bloc.dart';
import 'package:craftsiliconweather/core/common/data/datasources/local/storage_utils.dart';
import 'package:craftsiliconweather/core/common/error/failures.dart';
import 'package:craftsiliconweather/core/common/usecases/usecase.dart';
import 'package:craftsiliconweather/core/common/utils/app_utils.dart';
import 'package:craftsiliconweather/features/home/data/models/forecast_body.dart';
import 'package:craftsiliconweather/features/home/data/models/forecast_response.dart';
import 'package:craftsiliconweather/features/home/domain/usecases/get_forecast_local_usecase.dart';
import 'package:craftsiliconweather/features/home/domain/usecases/get_forecast_remote_usecase.dart';
import 'package:equatable/equatable.dart';

import 'package:injectable/injectable.dart';

part 'get_forecast_event.dart';
part 'get_forecast_state.dart';

@injectable
class GetForecastBloc extends Bloc<GetForecastEvent, GetForecastState> {
  final GetForecastRemoteUseCase _getWeatherUseCase;
  final GetForecastLocalUseCase _forecastLocalUseCase;

  final StorageUtils storageUtils;

  GetForecastBloc(
      this._getWeatherUseCase, this.storageUtils, this._forecastLocalUseCase)
      : super(GetForecastInitial()) {
    on<GetForecast>(_onGetForecast);
  }

  _onGetForecast(GetForecast event, Emitter<GetForecastState> emit) async {
    emit(GetForecastLoading());

    final isInternetAvailable = await checkIfInternetIsAvailable();

    final result = isInternetAvailable == true
        ? await _getWeatherUseCase.call(event.forecastBody)
        : await _forecastLocalUseCase.call(NoParams());
    emit(
      result.fold(
        (failure) => failure.runtimeType == DatabaseFailure
            ? const GetLocalFailed(
                errorMessage:
                    'No Data found, please connect to your Internet and Retry')
            : const GetForecastFailed(errorMessage: 'Something went wrong'),
        (data) => GetForecastSuccess(forecastRepsonse: data),
      ),
    );
  }
}
