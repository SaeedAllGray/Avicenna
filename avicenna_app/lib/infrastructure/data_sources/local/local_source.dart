import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalSource {
  // Private constructor to prevent external instantiation
  LocalSource._privateConstructor();

  // The single instance of the class
  static final LocalSource _instance = LocalSource._privateConstructor();

  // FlutterSecureStorage instance
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  // Public method to access the singleton instance
  factory LocalSource.getInstance() {
    return _instance;
  }

  // Methods for reading and writing data
  Future<String?> getToken() async {
    return await _secureStorage.read(key: 'token');
  }

  Future<void> setToken(String value) async {
    await _secureStorage.write(key: 'token', value: value);
  }

  // Add more methods as needed for your use case

  // Example method
  Future<void> clearStorage() async {
    await _secureStorage.deleteAll();
  }
}
