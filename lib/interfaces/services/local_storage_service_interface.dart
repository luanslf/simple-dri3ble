abstract class ILocalStorageService {
  Future<bool> put(String key, String value);
  Future<String> get(String key);
  Future<bool> delete(String key);
  Future<bool> clear();
}
