import 'package:http/http.dart' show Client;
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

    return json.decode(response.body);
  }

  // get detail of earing from orders in COD and Total delivered orders that day
  static Future<dynamic> getDeliveredOrdersEaringHistory(
      date, month, year) async {
    String token;
    await Common.getToken().then((onValue) {
      token = 'bearer ' + onValue;
    });
    final response = await client.get(
        API_ENDPOINT + 'deliveryoptions/deliveryboy/details/$date/$month/$year',
        headers: {'Content-Type': 'application/json', 'Authorization': token});
    return json.decode(response.body);
  }
}
