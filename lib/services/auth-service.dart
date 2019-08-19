import 'package:http/http.dart' show Client;
import 'constant.dart';
import 'dart:convert';

class AuthService {
  static final Client client = Client();
  static Future<Map<String, dynamic>> login(Map<String, dynamic> body) async {
    final response = await client.post(BASE_URL + 'auth/local', body: body);
    print(json.decode(response.body));
    return json.decode(response.body);
  }
}
