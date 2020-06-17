import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  final String url;

  NetworkHelper({this.url});

  Future getWeatherData() async {
    http.Response apiResponse = await http.get(url);

    if (apiResponse.statusCode == 200) {
      return jsonDecode(apiResponse.body);
    }
    else {
      print(apiResponse.statusCode);
    }
  }
}