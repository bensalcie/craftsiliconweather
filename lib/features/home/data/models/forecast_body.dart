import 'dart:convert';

ForecastBody forecastBodyFromJson(String str) =>
    ForecastBody.fromJson(json.decode(str));

String forecastBodyToJson(ForecastBody data) => json.encode(data.toJson());

class ForecastBody {
  double lat;
  double lon;
  int cnt;
  String? metric = 'metric';

  ForecastBody({
    required this.lat,
    required this.lon,
    required this.cnt,
    this.metric,
  });

  factory ForecastBody.fromJson(Map<String, dynamic> json) => ForecastBody(
      lat: json["lat"]?.toDouble(),
      lon: json["lon"]?.toDouble(),
      cnt: json["cnt"],
      metric: json['units']);

  Map<String, dynamic> toJson() =>
      {"lat": lat, "lon": lon, "cnt": cnt, "units": metric};
}
