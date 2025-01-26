part of 'search_weather_bloc.dart';

class SearchWeatherEvent extends Equatable {
  const SearchWeatherEvent();

  @override
  List<Object> get props => [];
}

class SearchWeather extends SearchWeatherEvent {
  final WeatherBody weatherBody;
  final bool isSearchPage;

  const SearchWeather({required this.weatherBody, required this.isSearchPage});

  @override
  List<Object> get props => [weatherBody, isSearchPage];
}
