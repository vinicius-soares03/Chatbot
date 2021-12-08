import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tela_login/models/forecast.dart';
import 'package:tela_login/models/weather.dart';


class API {
  static Future<List<ForeCast?>?> callAPI() async {
    const String url =
        'https://api.hgbrasil.com/weather?key=78e4d8f1&city_name=SaoPau';
    var response = await http.get(Uri.parse(url));

    var weather = Weather.fromJson(jsonDecode(response.body)["results"]);

    return weather.forecasts;
  }
}
