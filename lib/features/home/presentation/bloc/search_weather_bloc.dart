import 'package:bloc/bloc.dart';
import 'package:craftsiliconweather/core/common/data/datasources/local/storage_utils.dart';
import 'package:craftsiliconweather/features/home/data/models/weather_body.dart';
import 'package:craftsiliconweather/features/home/data/models/weather_response.dart';
import 'package:craftsiliconweather/features/home/domain/usecases/get_weather_usecase.dart';
import 'package:equatable/equatable.dart';

import 'package:injectable/injectable.dart';

part 'search_weather_event.dart';
part 'search_weather_state.dart';

@injectable
class SearchWeatherBloc extends Bloc<SearchWeatherEvent, SearchWeatherState> {
  final GetWeatherUseCase _getWeatherUseCase;
  final StorageUtils storageUtils;

  SearchWeatherBloc(this._getWeatherUseCase, this.storageUtils)
      : super(SearchWeatherInitial()) {
    on<SearchWeather>(_onSearchWeather);
  }

  _onSearchWeather(
      SearchWeather event, Emitter<SearchWeatherState> emit) async {
    emit(SearchWeatherLoading());

    final result = await _getWeatherUseCase.call(event.weatherBody);
    emit(
      result.fold(
        (failure) =>
            const SearchWeatherFailed(errorMessage: 'Something went wrong'),
        (data) => SearchWeatherSuccess(weatherResponse: data),
      ),
    );
  }
}
