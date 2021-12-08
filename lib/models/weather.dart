import 'package:tela_login/models/forecast.dart';

class Weather {
  String? city;
  String? date;
  String? weekday;
  int? max;
  int? min;
  String? description;
  String? condition;
  List<ForeCast?>? forecasts;

  Weather(
      {this.city,
      this.date,
      this.weekday,
      this.max,
      this.min,
      this.description,
      this.condition,
      this.forecasts});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
        city: json["city"],
        date: json["date"],
        weekday: json["weekday"],
        max: json["max"],
        min: json["min"],
        description: json["description"],
        condition: json["condition"],
        forecasts: json["forecast"] != null
            ? (json["forecast"] as List)
                .map((e) => ForeCast.fromJson(e))
                .toList()
            : []);
  }
}
