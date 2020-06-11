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

  sendLocationDataThroughSocket(
      {String latitude,
      String longitude,
      String deliveryBoyId,
      String deliveryBoyName,
      bool status,
      bool alloted}) {
    var locationData = {
      "latitude": latitude,
      "longitude": longitude,
      "deliveryBoyId": deliveryBoyId,
      "name": deliveryBoyName,
      "status": status,
      "alloted": alloted
    };
    socket.emit("locationUpdate", locationData);
  }

  socketDisconnect() {
    socket.disconnect();
  }
}
