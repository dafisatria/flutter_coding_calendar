import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Network {
  final String _url = 'http://127.0.0.1:8000/api';
  var token;

  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    token = jsonDecode(localStorage.getString('token') ?? 'kosong')['token'];
  }

  auth(data, apiURL) async {
    var fullUrl = _url + apiURL;
    return await http.post(Uri.parse(fullUrl),
        body: jsonEncode(data), headers: _setHeaders());
  }

  getData(apiURL) async {
    var fullUrl = _url + apiURL;
    await _getToken();
    return await http.get(
      Uri.parse(fullUrl),
      headers: _setHeaders(),
    );
  }

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

  create_event(apiURL) async {
    var fullUrl = _url + apiURL;
    await _getToken();
    return await http.post(
      Uri.parse(fullUrl),
      headers: _setHeaders(),
    );
  }
  
}
