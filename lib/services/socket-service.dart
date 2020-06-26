import 'package:socket_io_client/socket_io_client.dart' as io;

import 'constant.dart';

class SocketService {
  var socket = io.io(BASE_URL, <String, dynamic>{
    'transports': ['websocket']
  });

  socketInitialize() {
    socket.on('connect', (data) {
      print('connect $data');
    });
  }

  emitBeforeDisconnect(userId) {
    socket.emit('onExit', {'id': userId});
  }

  socketDisconnect() {
    socket.disconnect();
  }

  sendLocationDataThroughSocket(
      {String latitude,
      String longitude,
      String deliveryBoyId,
      String deliveryBoyName,
      bool status,
      bool alloted}) {
    var locationData;
    if (deliveryBoyName != null) {
      locationData = {
        "latitude": latitude,
        "longitude": longitude,
        "deliveryBoyId": deliveryBoyId,
        "name": deliveryBoyName,
        "status": status,
        "alloted": alloted
      };
    } else {
      locationData = {
        "latitude": latitude,
        "longitude": longitude,
        "deliveryBoyId": deliveryBoyId,
      };
    }

    socket.emit("locationUpdate", locationData);
  }
}
