part of 'get_weather_bloc.dart';

class GetWeatherEvent extends Equatable {
  const GetWeatherEvent();

  @override
  List<Object> get props => [];
}

class GetWeather extends GetWeatherEvent {
  final WeatherBody weatherBody;
  final bool isSearchPage;

  const GetWeather({required this.weatherBody, required this.isSearchPage});

  @override
  List<Object> get props => [weatherBody, isSearchPage];
}
