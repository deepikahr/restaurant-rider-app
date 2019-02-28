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
}
