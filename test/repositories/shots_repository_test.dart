import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:simple_dri3ble/interfaces/services/http_client_service_interface.dart';
import 'package:simple_dri3ble/repositories/dribbble_shots_repository.dart';

class HttpClientMock extends Mock implements IHttpClientService {}

main() {
  final mock = HttpClientMock();

  final shotsRepository = DribbbleShotsRepository(mock);

  group("Shots Repository Test", () {
    test("with empty access token", () async {
      Future future = Future<List>.value(null);
      when(mock.get("")).thenAnswer((_) => future);
      final shots = await shotsRepository.getShots("");
      expect(shots, isNull);
    });
  });
}
