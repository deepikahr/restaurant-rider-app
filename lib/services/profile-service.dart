import 'package:http/http.dart' show Client;
import 'constant.dart';
import 'dart:convert';
import 'common.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class ProfileService {
  static final Client client = Client();

  static Future<bool> validateToken() async {
    String token;
    await Common.getToken().then((onValue) {
      token = 'bearer ' + onValue;
    });
    final response = await client.get(
        Constants.apiEndPoint + 'users/verify/token',
        headers: {'Content-Type': 'application/json', 'Authorization': token});
    return json.decode(response.body);
  }

  static Future<Map<String, dynamic>> getUserInfo() async {
    String token;
    await Common.getToken().then((onValue) {
      token = 'bearer ' + onValue;
    });
    final response = await client.get(Constants.apiEndPoint + 'users/me',
        headers: {'Content-Type': 'application/json', 'Authorization': token});
    return json.decode(response.body);
  }

  static Future<Map<String, dynamic>> setUserInfo(
      String id, Map<String, dynamic> body) async {
    String token;
    await Common.getToken().then((onValue) {
      token = 'bearer ' + onValue;
    });

    final response = await client.put(Constants.apiEndPoint + 'users/$id',
        headers: {'Content-Type': 'application/json', 'Authorization': token},
        body: json.encode(body));
    return json.decode(response.body);
  }

  static Future<Map<String, dynamic>> setUserProfileInfo(
      String id, Map<String, dynamic> body) async {
    String token;
    await Common.getToken().then((onValue) {
      token = 'bearer ' + onValue;
    });
    final response = await client.put(
        Constants.apiEndPoint + 'users/userProfile/$id',
        headers: {'Content-Type': 'application/json', 'Authorization': token},
        body: json.encode(body));
    return json.decode(response.body);
  }

  static Future<Map<String, dynamic>> deleteUserProfilePic() async {
    String token;
    await Common.getToken().then((onValue) {
      token = 'bearer ' + onValue;
    });
    final response = await client.delete(
        Constants.apiEndPoint + 'users/profile/delete',
        headers: {'Content-Type': 'application/json', 'Authorization': token});
    return json.decode(response.body);
  }

  static Future<Map<String, dynamic>> uploadProfileImage(
      image, stream, id) async {
    var length = await image.length();
    String uri = Constants.apiEndPoint + 'users/upload/to/cloud';
    var request = new http.MultipartRequest("POST", Uri.parse(uri));
    var multipartFile = new http.MultipartFile('file', stream, length,
        filename: basename(image.path));
    request.files.add(multipartFile);
    var response = await request.send();
    response.stream.transform(utf8.decoder).listen((value) {
      var profileImageRes;
      if (value.substring(value.length - 1, value.length) == "}") {
        profileImageRes = value;
      } else {
        profileImageRes = value + "}";
      }

      if (value.length > 3) {
        var profileValue = json.decode(profileImageRes);

        ProfileService.setUserProfileInfo(id, {
          'publicId': profileValue['public_id'],
          'logo': profileValue['url']
        });
      }
    });
  }

  static Future<List<dynamic>> getAddressList() async {
    String token;
    await Common.getToken().then((onValue) {
      token = 'bearer ' + onValue;
    });
    final response = await client.get(
        Constants.apiEndPoint + 'users/newaddress/address',
        headers: {'Content-Type': 'application/json', 'Authorization': token});
    return json.decode(response.body);
  }

  static Future<Map<String, dynamic>> addAddress(
      Map<String, dynamic> body) async {
    String token;
    await Common.getToken().then((onValue) {
      token = 'bearer ' + onValue;
    });
    final response = await client.post(
        Constants.apiEndPoint + 'users/add/address',
        headers: {'Content-Type': 'application/json', 'Authorization': token},
        body: json.encode(body));
    return json.decode(response.body);
  }

  static Future<Map<String, dynamic>> placeOrder(
      Map<String, dynamic> body) async {
    String token;
    await Common.getToken().then((onValue) {
      token = 'bearer ' + onValue;
    });
    final response = await client.post(Constants.apiEndPoint + 'orders',
        headers: {'Content-Type': 'application/json', 'Authorization': token},
        body: json.encode(body));
    return json.decode(response.body);
  }

  static Future<Map<String, dynamic>> getOrderById(String id) async {
    String token;
    await Common.getToken().then((onValue) {
      token = 'bearer ' + onValue;
    });
    final response = await client.get(Constants.apiEndPoint + 'orders/$id',
        headers: {'Content-Type': 'application/json', 'Authorization': token});
    return json.decode(response.body);
  }

  static Future<List<dynamic>> getNonDeliveredOrdersList() async {
    String token;
    await Common.getToken().then((onValue) {
      token = 'bearer ' + onValue;
    });
    final response = await client
        .get(Constants.apiEndPoint + 'orders/userorder/pending', headers: {
      'Content-Type': 'application/json',
      'Authorization': token
    }).catchError((onError) {});
    return json.decode(response.body);
  }

  static Future<List<dynamic>> getDeliveredOrdersList() async {
    String token;
    await Common.getToken().then((onValue) {
      token = 'bearer ' + onValue;
    });
    final response = await client.get(
        Constants.apiEndPoint + 'orders/userorder/history',
        headers: {'Content-Type': 'application/json', 'Authorization': token});
    return json.decode(response.body);
  }

  static Future<List<dynamic>> getFavouritList() async {
    String token;
    await Common.getToken().then((onValue) {
      token = 'bearer ' + onValue;
    });
    final response = await client.get(Constants.apiEndPoint + 'favourites',
        headers: {'Content-Type': 'application/json', 'Authorization': token});
    return json.decode(response.body);
  }

  static Future<bool> removeFavouritById(String id) async {
    String token;
    await Common.getToken().then((onValue) {
      token = 'bearer ' + onValue;
    });
    await client.delete(Constants.apiEndPoint + 'favourites/$id',
        headers: {'Content-Type': 'application/json', 'Authorization': token});
    return Future(() => true);
  }

  static Future<Map<String, dynamic>> checkFavourite(String productId) async {
    String token;
    await Common.getToken().then((onValue) {
      token = 'bearer ' + onValue;
    });
    Map<String, dynamic> body = {'product': productId};
    final response = await client.post(
        Constants.apiEndPoint + 'favourites/check/product',
        headers: {'Content-Type': 'application/json', 'Authorization': token},
        body: json.encode(body));
    return json.decode(response.body);
  }

  static Future<Map<String, dynamic>> addToFavourite(
      String productId, String restaurantId, String locationId) async {
    String token;
    await Common.getToken().then((onValue) {
      token = 'bearer ' + onValue;
    });
    Map<String, dynamic> body = {
      'product': productId,
      'restaurantID': restaurantId,
      'location': locationId
    };
    var response;
    await client
        .post(Constants.apiEndPoint + 'favourites',
            headers: {
              'Content-Type': 'application/json',
              'Authorization': token
            },
            body: json.encode(body))
        .then((onValue) {
      response = onValue;
    }).catchError((onError) {
      response = onError;
    });
    return json.decode(response.body);
  }

  static Future<Map<String, dynamic>> postProductRating(
      Map<String, dynamic> body) async {
    String token;
    await Common.getToken().then((onValue) {
      token = 'bearer ' + onValue;
    });
    final response = await client.post(Constants.apiEndPoint + 'productRatings',
        headers: {'Content-Type': 'application/json', 'Authorization': token},
        body: json.encode(body));
    return json.decode(response.body);
  }
}
