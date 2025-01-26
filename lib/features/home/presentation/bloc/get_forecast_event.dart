part of 'get_forecast_bloc.dart';

class GetForecastEvent extends Equatable {
  const GetForecastEvent();

  @override
  List<Object> get props => [];
}

class GetForecast extends GetForecastEvent {
  final ForecastBody weatherBody;

  const GetForecast({required this.weatherBody});

  @override
  List<Object> get props => [weatherBody];
}
