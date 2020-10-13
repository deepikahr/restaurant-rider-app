import 'dart:async';
// import 'package:background_location/background_location.dart' as b;
import 'package:delivery_app/services/auth-service.dart';
import 'package:delivery_app/services/common.dart';
import 'package:delivery_app/services/socket_service.dart';
import 'package:location/location.dart';

class BackgroundLocationService {
  SocketService _socketService = SocketService();
  Location location = new Location();
  LocationData currentLocation;

  initialize() {
    _socketService.socketInitialize();
    updateDeliveryBoyLatLng();
  }

  disconnectSocket(userId) {
    _socketService.emitBeforeDisconnect(userId);
    _socketService.socketDisconnect();
  }

  updateDeliveryBoyLatLng() {
    Common.getToken().then((token) {
      if (token != null) {
        AuthService.getDeliveryBoyStatus(token).then((response) async {
          Timer.periodic(Duration(seconds: 10), (_) async {
            currentLocation = await location.getLocation();
            _socketService.sendLocationDataThroughSocket(
                deliveryBoyId: response['response_data']['data']['_id'],
                latitude: currentLocation.latitude.toString(),
                longitude: currentLocation.longitude.toString());
          });
        });
      }
    });
  }
}
