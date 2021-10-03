import 'package:horizon_client/horizon_client.dart';
import 'package:horizon_client/horizon_client.dart';

void main() async {
  var client = HorizonClient(2050);
  await client.listen();
  client.telemetryStream.listen((event) {
    print('Speed: ${event.speed} m/s, Gear: ${event.gear}, Distance travelled: ${event.distanceTraveled}');
    // print("\x1B[2J\x1B[0;0H"); // clear entire screen, move cursor to 0;0
  });
}
