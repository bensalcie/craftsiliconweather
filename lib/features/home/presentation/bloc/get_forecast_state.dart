part of 'get_forecast_bloc.dart';

class GetForecastState extends Equatable {
  const GetForecastState();

  @override
  List<Object?> get props => [];
}

class GetForecastInitial extends GetForecastState {}

class GetForecastLoading extends GetForecastState {}

class GetForecastSuccess extends GetForecastState {
  final ForecastResponse forecastRepsonse;

  const GetForecastSuccess({required this.forecastRepsonse});

  @override
  List<Object?> get props => [forecastRepsonse];
}

class GetForecastFailed extends GetForecastState {
  final String errorMessage;

  const GetForecastFailed({required this.errorMessage});
}
