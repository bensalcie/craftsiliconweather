part of 'get_weather_bloc.dart';

class GetWeatherState extends Equatable {
  const GetWeatherState();

  @override
  List<Object?> get props => [];
}

class GetWeatherInitial extends GetWeatherState {}

class GetWeatherLoading extends GetWeatherState {}

class GetWeatherSuccess extends GetWeatherState {
  final WeatherResponse? weatherResponse;
  final String lastUpdated;

  const GetWeatherSuccess(
      {required this.weatherResponse, required this.lastUpdated});

  @override
  List<Object?> get props => [weatherResponse, lastUpdated];
}

class GetWeatherFailed extends GetWeatherState {
  final String errorMessage;

  const GetWeatherFailed({required this.errorMessage});
}

class GetLocalWeatherFailed extends GetWeatherState {
  final String errorMessage;

  const GetLocalWeatherFailed({required this.errorMessage});
}
