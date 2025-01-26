import 'package:bloc/bloc.dart';
import 'package:craftsiliconweather/core/common/data/datasources/local/storage_utils.dart';
import 'package:craftsiliconweather/features/home/data/models/forecast_body.dart';
import 'package:craftsiliconweather/features/home/data/models/forecast_response.dart';
import 'package:craftsiliconweather/features/home/domain/usecases/get_forecast_usecase.dart';
import 'package:equatable/equatable.dart';

import 'package:injectable/injectable.dart';

part 'get_forecast_event.dart';
part 'get_forecast_state.dart';

@injectable
class GetForecastBloc extends Bloc<GetForecastEvent, GetForecastState> {
  final GetForecastUseCase _getWeatherUseCase;
  final StorageUtils storageUtils;

  GetForecastBloc(this._getWeatherUseCase, this.storageUtils)
      : super(GetForecastInitial()) {
    on<GetForecast>(_onGetForecast);
  }

  _onGetForecast(GetForecast event, Emitter<GetForecastState> emit) async {
    emit(GetForecastLoading());

    // final existingCoodinates =
    //     await storageUtils.getDataForSingle(key: locationskey);
    // if (existingCoodinates.isNotEmpty) {
    //   final coordinates = existingCoodinates.split(',');
    //   forecastBody = ForecastBody(
    //       lat: double.tryParse(coordinates[0]) ?? -1.286389,
    //       lon: double.tryParse(coordinates[1]) ?? 36.817223,
    //       units: 'metric',
    //       q: 'daily',
    //       cnt: 5);
    // } else {
    //   forecastBody = ForecastBody(
    //       lat: -1.286389, lon: 36.817223, cnt: 5, units: 'metric', q: 'daily');
    // }

    final result = await _getWeatherUseCase.call(event.forecastBody);
    emit(
      result.fold(
        (failure) =>
            const GetForecastFailed(errorMessage: 'Something went wrong'),
        (data) => GetForecastSuccess(forecastRepsonse: data),
      ),
    );
  }
}
