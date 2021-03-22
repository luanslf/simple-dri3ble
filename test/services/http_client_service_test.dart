import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:simple_dri3ble/interfaces/services/http_client_service_interface.dart';

class HttpClientServiceMock extends Mock implements IHttpClientService {}

main() {
  final mock = HttpClientServiceMock();

  group("Http Client Service Test", () {
    test("throws an exception when url is empty", () async {
      Future future = Future<Exception>.value(Exception("empty url"));
      when(mock.get("")).thenAnswer((_) => future);
      final response = await mock.get("");
      expect(response, isA<Exception>());
    });
    test("throws an exception when url is invalid", () async {
      Future future = Future<Exception>.value(Exception("invalid url"));
      when(mock.get("invalid url")).thenAnswer((_) => future);
      final response = await mock.get("invalid url");
      expect(response, isA<Exception>());
    });
  });
}
