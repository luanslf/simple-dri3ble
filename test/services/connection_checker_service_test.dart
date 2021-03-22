import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:simple_dri3ble/interfaces/services/connection_checker_service_interface.dart';

class ConnectionCheckerServiceMock extends Mock
    implements IConnectionCheckerService {}

main() {
  final mock = ConnectionCheckerServiceMock();

  group("Connection Checker Service Test", () {
    test("has no internet", () async {
      Future future = Future<bool>.value(false);
      when(mock.isConnectionAvailable()).thenAnswer((_) => future);
      bool hasInternet = await mock.isConnectionAvailable();
      expect(hasInternet, false);
    });
    test("has internet", () async {
      Future future = Future<bool>.value(true);
      when(mock.isConnectionAvailable()).thenAnswer((_) => future);
      bool hasInternet = await mock.isConnectionAvailable();
      expect(hasInternet, true);
    });
  });
}
