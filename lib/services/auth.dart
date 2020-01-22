import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart';

import 'constant.dart';

var SignUpdata;
String errorMsg;
String errMsg;
String frgtpassMsg;
String deleteKey = null;
var profileValue;
var loginData;
bool otpError = false;
String userId;
var id;
int mobileNo;
String otpToken;
String verifyMsg;
bool sentMail = false;
bool otpSent = false;
bool resetPass = false;
bool isRegistered = false;
bool accountUpdate = true;
bool isLoggedIn = false;
bool forgotPass = false;
bool errorFound = false;
bool otpVer = false;
bool errorFnd = false;
String localToken;

// registration
getUserInfo() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String authToken = prefs.getString('token');
  return await http.get(BASE_URL + 'api/users/me', headers: {
    'Content-Type': 'application/json',
    'Authorization': 'bearer ' + authToken,
  });
}

updateUserInfo(name, email, phone, userId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String authToken = prefs.getString('token');
  final Map<String, dynamic> authData = {
    'name': name,
    'email': email,
    'phone': phone,
  };
  var data = json.encode(authData);
  prefs.setString('name', authData['name']);
  prefs.setString('email', authData['email']);
  prefs.setString('profileImage', authData['imageUrl']);
  prefs.setString('contactNumber', authData['contactNumber']);
  return await http.put(BASE_URL + 'api/users/$userId', body: data, headers: {
    'Content-Type': 'application/json',
    'Authorization': 'bearer ' + authToken,
  });
}

updateUserAllInfo(name, email, phone, userId, image, stream, gender) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String authToken = prefs.getString('token');
  var length = await image.length();
  String uri = BASE_URL + 'users/upload/to/cloud';
  var request = new http.MultipartRequest("POST", Uri.parse(uri));
  var multipartFile = new http.MultipartFile('file', stream, length,
      filename: basename(image.path));
  request.files.add(multipartFile);
  var response = await request.send();
  response.stream.transform(utf8.decoder).listen((value) {
    var profileImageRes = value + '}';
    if (value.length > 3) {
      profileValue = json.decode(profileImageRes);
      if (response.statusCode == 200) {
        var userData = {
          'name': name,
          'email': email,
          'contactNumber': phone,
          'publicId': profileValue['public_id'],
          'imageUrl': profileValue['url'],
          'deleteId': deleteKey,
        };
        prefs.setString('name', userData['name']);
        prefs.setString('email', userData['email']);
        prefs.setString('profileImage', userData['imageUrl']);
        prefs.setString('contactNumber', userData['contactNumber']);
        return http.put(BASE_URL + 'api/users/$userId',
            body: json.encode(userData),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'bearer ' + authToken,
            }).then((response) {
          var res = json.decode(response.body);
          final int statusCode = response.statusCode;
          userData = res;
          if (statusCode != 200 || json == null) {
            throw new Exception("Error while fetching data");
          } else {
            accountUpdate = true;
          }
        });
      }
    }
  });
  prefs.setString('deleteId', profileValue['url']);
  deleteKey = prefs.getString('deleteId');
}
