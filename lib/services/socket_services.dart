import 'package:flutter/foundation.dart';
import 'package:money_transfers/helper/shared_preference_helper.dart';
import 'package:money_transfers/services/notification_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

import '../global/api_url.dart';

class SocketServices {
  late io.Socket socket;
  bool show = false;

  NotificationService notificationService = NotificationService();
  SharedPreferenceHelper sharedPreferenceHelper = SharedPreferenceHelper();


  void connectToSocket() {
    socket = io.io(
        ApiUrl.baseUrl,
        io.OptionBuilder()
            .setTransports(['websocket'])
            .enableAutoConnect()
            .build());

    socket.onConnect((data) =>
        debugPrint("=============================> Connection $data"));
    socket.onConnectError(
        (data) => print("============================>Connection Error $data"));

    socket.connect();

    socket.on('user-notification::${SharedPreferenceHelper.id}', (data) {
      print("================> get Data on socket: $data");
      notificationService.showNotification(data);
    });
  }
}
