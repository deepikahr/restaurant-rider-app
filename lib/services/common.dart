import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:convert';

class Common {
  static void showSnackbar(scaffoldKey, message) {
    final snackBar = SnackBar(
      content: Text(message.toString()),
      duration: Duration(milliseconds: 3000),
    );
    scaffoldKey.currentState.showSnackBar(snackBar);
  }

  // set token in storage
  static Future<bool> setToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('token', token);
  }

  //get token from storage
  static Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return Future(() => prefs.getString('token'));
  }

  // remove token from storage
  static Future<bool> removeToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove('token');
  }
}
