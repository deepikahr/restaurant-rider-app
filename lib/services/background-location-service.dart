import 'package:background_location/background_location.dart';
import 'package:delivery_app/services/auth-service.dart';
import 'package:delivery_app/services/common.dart';
import 'package:delivery_app/services/socket-service.dart';

class BackgroundLocationService {
  SocketService _socketService = SocketService();

  initialize({String deliveryBoyId}) {
    _socketService.socketInitialize();
    startBackgroundService();
    getLocation();
  }

  startBackgroundService() {
    BackgroundLocation.startLocationService();
  }

  disconnectSocket() {
    BackgroundLocation.stopLocationService();
    _socketService.socketDisconnect();
  }

  getLocation() {
    Common.getToken().then((token) {
      if (token != null) {
        AuthService.getDeliveryBoyStatus(token).then((response) {
          if (response['response_code'] == 200) {
//            print('response : ${response['response_data']}');
//            print('status : ${response['response_data']['data']['status']}');
//            print('alloted : ${response['response_data']['data']['alloted']}');
//            print('status : ${response['response_data']['data']['_id']}');
            BackgroundLocation.getLocationUpdates((location) {
              Future.delayed(Duration(seconds: 2));
              _socketService.sendLocationDataThroughSocket(
                  status: response['response_data']['data']['status'],
                  alloted: response['response_data']['data']['alloted'],
                  deliveryBoyId: response['response_data']['data']['_id'],
                  latitude: location.latitude.toString(),
                  longitude: location.longitude.toString());
            });
          }
        });
      }
    });
  }
}

class Location {
  final String latitude;
  final String longitude;

  Location({this.latitude, this.longitude});
}
