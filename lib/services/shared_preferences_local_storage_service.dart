import 'package:flutter/services.dart';
import 'package:simple_dri3ble/interfaces/services/local_storage_service_interface.dart';

class SharedPreferencesLocalStorageService implements ILocalStorageService {
  static const storageChannel = const MethodChannel('storage');

  @override
  Future<String> get(String key) async {
    return storageChannel.invokeMethod('get', {'key': key});
  }

  @override
  Future<bool> put(String key, String value) async {
    return storageChannel.invokeMethod('put', {'key': key, 'value': value});
  }

  @override
  Future<bool> delete(String key) async {
    return storageChannel.invokeMethod('delete', {'key': key});
  }
}
