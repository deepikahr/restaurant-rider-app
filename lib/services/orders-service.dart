import 'package:delivery_app/pages/live-tasks/order-delivered.dart';
import 'package:http/http.dart' show Client;
import 'package:shared_preferences/shared_preferences.dart';
import 'constant.dart';
import 'dart:convert';
import 'common.dart';

class OrdersService {
  static final Client client = Client();

  static Future<dynamic> getAssignedOrdersListToDeliveryBoy(orderStatus) async {
    String token;
    await Common.getToken().then((onValue) {
      token = 'bearer ' + onValue;
    });
    final response = await client.get(
        API_ENDPOINT + 'deliveryoptions/delivery/assigned/$orderStatus',
        headers: {'Content-Type': 'application/json', 'Authorization': token});
    // print("live  ${json.decode(response.body));
    return json.decode(response.body);
  }

  // get detail of earing from orders in COD and Total delivered orders that day
  static Future<dynamic> getDeliveredOrdersEaringHistory(
      date, month, year) async {
    String token;
    await Common.getToken().then((onValue) {
      token = 'bearer ' + onValue;
    });
    // print(token);
    final response = await client.get(
        API_ENDPOINT + 'deliveryoptions/deliveryboy/details/$date/$month/$year',
        headers: {'Content-Type': 'application/json', 'Authorization': token});
    return json.decode(response.body);
  }

  static Future<dynamic> orderDelivered(body, id) async {
    String token;
    await Common.getToken().then((onValue) {
      token = 'bearer ' + onValue;
    });
    // print("$token");
    // print(body);
    final response = await client.put(API_ENDPOINT + 'orders/$id',
        body: body,
        headers: {'Content-Type': 'application/json', 'Authorization': token});
    // print(json.decode(response.body));
    return json.decode(response.body);
  }

  static Future<dynamic> getUserInfo() async {
    String token;
    await Common.getToken().then((onValue) {
      token = 'bearer ' + onValue;
    });
    // print("$token");

    final response = await client.get(API_ENDPOINT + 'users/me', headers: {
      'Content-Type': 'application/json',
      'Authorization': token,
    });

    return json.decode(response.body);
  }
}
