

import 'package:flutter/foundation.dart';
import 'package:money_transfers/services/notification_services.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;



class SocketServices{

  late io.Socket socket;
  bool show = false;

  NotificationService notificationService = NotificationService() ;



  void connectToSocket() {


    socket = io.io(
        "http://192.168.10.18:3000",
        io.OptionBuilder()
            .setTransports(['websocket'])
            .enableAutoConnect()
            .build());

    socket.onConnect(
            (data) => debugPrint("=============================> Connection $data"));
    socket.onConnectError(
            (data) => print("============================>Connection Error $data"));

    socket.connect();

    socket.on('user-notification::65aa15210b9179adf1c4b6ae', (data) {
      print("================> get Data on socket: $data");
      notificationService.showNotification(data) ;
    });
  }




}