import 'package:background_location/background_location.dart';
import 'package:delivery_app/services/auth-service.dart';
import 'package:delivery_app/services/common.dart';
import 'package:delivery_app/services/socket-service.dart';

class BackgroundLocationService {
  bool isCame = false;
  SocketService _socketService = SocketService();

  initialize({bool isAfterLogin}) {
    _socketService.socketInitialize();
    startBackgroundService();
    getLocation(isAfterLogin);
  }

  startBackgroundService() {
    BackgroundLocation.startLocationService();
  }

  disconnectSocket(userId) {
    _socketService.emitBeforeDisconnect(userId);
    BackgroundLocation.stopLocationService();
    _socketService.socketDisconnect();
  }

  getLocation(bool isAfterLogin) {
    Common.getToken().then((token) {
      if (token != null) {
        AuthService.getDeliveryBoyStatus(token).then((response) {
          BackgroundLocation.getLocationUpdates((location) {
            if (isAfterLogin) {
              for (int i = 0; i < 2; i++) {
                _socketService.sendLocationDataThroughSocket(
                    status: true,
                    alloted: response['response_data']['data']['alloted'],
                    deliveryBoyId: response['response_data']['data']['_id'],
                    deliveryBoyName: response['response_data']['data']['name'],
                    latitude: location.latitude.toString(),
                    longitude: location.longitude.toString());
              }
            } else {
              _socketService.sendLocationDataThroughSocket(
                  deliveryBoyId: response['response_data']['data']['_id'],
                  latitude: location.latitude.toString(),
                  longitude: location.longitude.toString());
              Future.delayed(Duration(seconds: 3));
            }
            isAfterLogin = false;
          });
        });
      }
    });
  }
}
