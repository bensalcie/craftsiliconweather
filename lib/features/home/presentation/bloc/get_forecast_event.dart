part of 'get_forecast_bloc.dart';

class GetForecastEvent extends Equatable {
  const GetForecastEvent();

  @override
  List<Object> get props => [];
}

class GetForecast extends GetForecastEvent {
  final ForecastBody forecastBody;
  const GetForecast({required this.forecastBody});

  @override
  List<Object> get props => [forecastBody];
}
