import 'package:bloc/bloc.dart';
import 'package:craftsiliconweather/features/home/data/models/weather_body.dart';
import 'package:craftsiliconweather/features/home/data/models/weather_response.dart';
import 'package:craftsiliconweather/features/home/domain/usecases/get_weather_usecase.dart';
import 'package:equatable/equatable.dart';

import 'package:injectable/injectable.dart';

part 'get_weather_event.dart';
part 'get_weather_state.dart';

@injectable
class GetWeatherBloc extends Bloc<GetWeatherEvent, GetWeatherState> {
  final GetWeatherUseCase _getWeatherUseCase;

  GetWeatherBloc(this._getWeatherUseCase) : super(GetWeatherInitial()) {
    on<GetWeather>(_onGetWeather);
  }

  _onGetWeather(GetWeather event, Emitter<GetWeatherState> emit) async {
    emit(GetWeatherLoading());

    final result = await _getWeatherUseCase.call(event.weatherBody);
    emit(
      result.fold(
        (failure) =>
            const GetWeatherFailed(errorMessage: 'Something went wrong'),
        (data) => GetWeatherSuccess(weatherResponse: data),
      ),
    );
  }
}
