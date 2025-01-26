import 'package:bloc/bloc.dart';
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

  GetForecastBloc(this._getWeatherUseCase) : super(GetForecastInitial()) {
    on<GetForecast>(_onGetForecast);
  }

  _onGetForecast(GetForecast event, Emitter<GetForecastState> emit) async {
    emit(GetForecastLoading());

    final result = await _getWeatherUseCase.call(event.weatherBody);
    emit(
      result.fold(
        (failure) =>
            const GetForecastFailed(errorMessage: 'Something went wrong'),
        (data) => GetForecastSuccess(forecastRepsonse: data),
      ),
    );
  }
}
