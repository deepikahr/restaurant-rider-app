import 'package:http/http.dart' show Client;
import 'package:shared_preferences/shared_preferences.dart';
import 'constant.dart';
import 'dart:convert';

class AuthService {
  static final Client client = Client();
  static Future<Map<String, dynamic>> login(Map<String, dynamic> body) async {
    final response = await client.post(BASE_URL + 'auth/local', body: body);
    return json.decode(response.body);
  }

  static Future<Map<String, dynamic>> getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String authToken = prefs.getString('token');
    final response = await client.get(BASE_URL + 'api/users/me', headers: {
      'Content-Type': 'application/json',
      'Authorization': 'bearer ' + authToken,
    });

    return json.decode(response.body);
  }

  static Future<Map<String, dynamic>> verifyTokenOTP(String token) async {
    final response = await client.get(API_ENDPOINT + 'users/verify/token',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ' + token
        });

    return json.decode(response.body);
  }
}
