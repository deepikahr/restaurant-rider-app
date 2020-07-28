import 'package:http/http.dart' show Client;
import 'package:shared_preferences/shared_preferences.dart';
import 'constant.dart';
import 'dart:convert';

class AuthService {
  static final Client client = Client();
  static Future<Map<String, dynamic>> login(Map<String, dynamic> body) async {
    final response =
        await client.post(Constants.apiUrl + 'auth/local', body: body);
    return json.decode(response.body);
  }

  static Future<Map<String, dynamic>> getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String authToken = prefs.getString('token');
    final response =
        await client.get(Constants.apiUrl + 'api/users/me', headers: {
      'Content-Type': 'application/json',
      'Authorization': 'bearer ' + authToken,
    });

    return json.decode(response.body);
  }

  static Future<Map<String, dynamic>> verifyTokenOTP(String token) async {
    final response = await client
        .get(Constants.apiEndPoint + 'users/verify/token', headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ' + token
    });

    return json.decode(response.body);
  }

  static Future<dynamic> getAdminSettings() async {
    final response = await client.get(Constants.apiEndPoint + 'adminSettings/');
    return json.decode(response.body);
  }
}
