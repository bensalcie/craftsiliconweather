import 'package:bloc/bloc.dart';
import 'package:craftsiliconweather/core/common/constants/app_strings.dart';
import 'package:craftsiliconweather/core/common/data/datasources/local/storage_utils.dart';
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
  final StorageUtils storageUtils;

  GetWeatherBloc(this._getWeatherUseCase, this.storageUtils)
      : super(GetWeatherInitial()) {
    on<GetWeather>(_onGetWeather);
  }

  _onGetWeather(GetWeather event, Emitter<GetWeatherState> emit) async {
    emit(GetWeatherLoading());

    WeatherBody weatherBody = event.weatherBody;
    final isSeachPage = event.isSearchPage;

    if (!isSeachPage) {
      final existingCoodinates =
          await storageUtils.getDataForSingle(key: locationskey);
          
      if (existingCoodinates.isNotEmpty) {
        final coordinates = existingCoodinates.split(',');
        weatherBody = WeatherBody(
          lat: double.tryParse(coordinates[0]),
          lng: double.tryParse(coordinates[1]),
        );
      } else {
        weatherBody = WeatherBody(placename: 'Nairobi');
      }
    }

    final result = await _getWeatherUseCase.call(weatherBody);
    emit(
      result.fold(
        (failure) =>
            const GetWeatherFailed(errorMessage: 'Something went wrong'),
        (data) => GetWeatherSuccess(weatherResponse: data),
      ),
    );
  }
}
