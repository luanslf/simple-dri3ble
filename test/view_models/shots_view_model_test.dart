import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:simple_dri3ble/interfaces/repositories/shots_respository_interface.dart';
import 'package:simple_dri3ble/interfaces/services/local_storage_service_interface.dart';
import 'package:simple_dri3ble/models/shot_model.dart';
import 'package:simple_dri3ble/services/io_connection_checker_service.dart';
import 'package:simple_dri3ble/view_models/shots_view_model.dart';

class ShotsRepositoryMock extends Mock implements IShotsRepository {}

class LocalStorageMock extends Mock implements ILocalStorageService {}

main() {
  final shotsMock = ShotsRepositoryMock();
  final storageMock = LocalStorageMock();

  final shotsViewModel = ShotsViewModel(
    "shots",
    shotsMock,
    storageMock,
    IOConnectionCheckerService(),
  );

  group("Shots ViewModel Test", () {
    test("init state of shots is null", () {
      expect(shotsViewModel.shots.value, isNull);
    });
    test("shots empty when access token is empty", () async {
      Future future = Future<List<ShotModel>>.value(null);
      when(shotsMock.getShots("")).thenAnswer((_) => future);
      await shotsViewModel.getShots("");
      expect(shotsViewModel.shots.value, isA<List<ShotModel>>());
    });
    test("shots is list of shots models when token is valid", () async {
      Future future = Future<List<ShotModel>>.value([
        ShotModel.fromJson({
          "id": 10,
          "title": "title",
          "description": "description",
          "images": {"0": ""}
        })
      ]);
      when(shotsMock.getShots("123")).thenAnswer((_) => future);
      await shotsViewModel.getShots("123");
      expect(shotsViewModel.shots.value, isA<List<ShotModel>>());
    });
  });
}
