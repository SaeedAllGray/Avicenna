import 'package:avicenna_app/presentation/constants/api_constant.dart';
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
    return await _secureStorage.read(key: ApiConstants.TOKEN);
  }

  Future<void> setToken(String value) async {
    await _secureStorage.write(key: ApiConstants.TOKEN, value: value);
  }

  Future<void> saveUser(String value) async {
    await _secureStorage.write(key: ApiConstants.USER, value: value);
  }

  Future<String?> getUser() async {
    return await _secureStorage.read(key: ApiConstants.USER);
  }

  // Add more methods as needed for your use case

  // Example method
  Future<void> clearStorage() async {
    await _secureStorage.deleteAll();
  }

  Future<String?> getType() async {
    return await _secureStorage.read(key: ApiConstants.TYPE);
  }

  Future<void> setType(String value) async {
    await _secureStorage.write(key: ApiConstants.TYPE, value: value);
  }
}
