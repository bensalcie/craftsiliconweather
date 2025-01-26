part of 'search_weather_bloc.dart';

class SearchWeatherState extends Equatable {
  const SearchWeatherState();

  @override
  List<Object?> get props => [];
}

class SearchWeatherInitial extends SearchWeatherState {}

class SearchWeatherLoading extends SearchWeatherState {}

class SearchWeatherSuccess extends SearchWeatherState {
  final WeatherResponse weatherResponse;

  const SearchWeatherSuccess({required this.weatherResponse});

  @override
  List<Object?> get props => [weatherResponse];
}

class SearchWeatherFailed extends SearchWeatherState {
  final String errorMessage;

  const SearchWeatherFailed({required this.errorMessage});
}
