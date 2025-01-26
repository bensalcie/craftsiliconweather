part of 'get_weather_bloc.dart';

class GetWeatherState extends Equatable {
  const GetWeatherState();

  @override
  List<Object?> get props => [];
}

class GetWeatherInitial extends GetWeatherState {}

class GetWeatherLoading extends GetWeatherState {}

class GetWeatherSuccess extends GetWeatherState {
  final WeatherResponse weatherResponse;

  const GetWeatherSuccess({required this.weatherResponse});

  @override
  List<Object?> get props => [weatherResponse];
}

class GetWeatherFailed extends GetWeatherState {
  final String errorMessage;

  const GetWeatherFailed({required this.errorMessage});
}
