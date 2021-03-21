import 'dart:io';

import 'package:simple_dri3ble/interfaces/services/connection_checker_service_interface.dart';

class IOConnectionCheckerService implements IConnectionCheckerService {
  @override
  Future<bool> isConnectionAvailable() async {
    bool isConnectionAvailable;
    try {
      final result = await InternetAddress.lookup('google.com');
      isConnectionAvailable =
          result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (e) {
      print(e);
      isConnectionAvailable = false;
    }
    return isConnectionAvailable;
  }
}
