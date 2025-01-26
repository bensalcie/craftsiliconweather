class WeatherBody {
  double? _lng;
  double? _lat;
  String? _placename;
  String? metric = 'metric';

  WeatherBody({
    double? lng,
    double? lat,
    String? placename,
  }) {
    _lng = lng;
    _lat = lat;
    _placename = placename;
    metric = 'metric';
  }

  WeatherBody.fromJson(Map<String, dynamic> json) {
    _lat = json['lat'];
    _lng = json['lng'];
    _placename = json['q'];
    metric = json['units'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['q'] = _placename;
    data['units'] = metric;
    data['lat'] = _lat;
    data['lon'] = _lng;
    return data;
  }
}
