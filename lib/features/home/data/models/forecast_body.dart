import 'dart:convert';

ForecastBody forecastBodyFromJson(String str) =>
    ForecastBody.fromJson(json.decode(str));

String forecastBodyToJson(ForecastBody data) => json.encode(data.toJson());

class ForecastBody {
  double? lat;
  double? lon;
  int? cnt;
  String? units;
  String? q;

  ForecastBody({
    this.units,
    this.lat,
    this.lon,
    this.cnt,
    this.q,
  });

  factory ForecastBody.fromJson(Map<String, dynamic> json) => ForecastBody(
      lat: json["lat"]?.toDouble(),
      lon: json["lon"]?.toDouble(),
      cnt: json["cnt"],
      units: json['units'],
      q: json['q']);

  Map<String, dynamic> toJson() =>
      {"lat": lat, "lon": lon, "cnt": cnt, "units": units, "q": q};
}
