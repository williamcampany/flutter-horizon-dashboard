import 'dart:async';
import 'dart:io';

import 'dart:typed_data';

import 'package:horizon_client/src/horizon_data_frame.dart';

class HorizonClient {

  final int port;
  late RawDatagramSocket _socket;
  final StreamController<HorizonDataFrame> _telemetryStreamController = StreamController.broadcast();
  Stream<HorizonDataFrame> get telemetryStream => _telemetryStreamController.stream;
  HorizonClient(this.port);

  Future<bool> listen() async {
    try {
      _socket = await RawDatagramSocket.bind(InternetAddress.anyIPv4, port);
      _socket.listen(_listen);
      return true;
    } catch (e) {
      print("Error: $e");
      return false;
    }
  }

  void _listen(RawSocketEvent event) {
    switch (event) {
      case RawSocketEvent.closed:
        print("Socket closed.");
        break;
      case RawSocketEvent.read:
        _read(_socket.receive()!);
        break;
      case RawSocketEvent.readClosed:
        print("Socket closed read channel");
        break;
      default: break;
    }
  }

  void _read(Datagram datagram) {
    var buffer = ByteData.sublistView(datagram.data);
    _telemetryStreamController.sink.add(
      HorizonDataFrame.createFrom(buffer)
    );
  }

}