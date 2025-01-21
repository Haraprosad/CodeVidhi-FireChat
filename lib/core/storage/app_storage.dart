import 'package:codevidhi_firechat/core/storage/secure_storage_manager.dart';
import 'package:codevidhi_firechat/core/storage/preferences_manager.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AppStorage {
  final SecureStorageManager _secureStorage;
  final PreferencesManager _preferences;

  AppStorage(this._secureStorage, this._preferences);

  SecureStorageManager get secure => _secureStorage;
  PreferencesManager get preferences => _preferences;

  // Cleanup method
  Future<void> clearAllData() async {
    await _secureStorage.deleteAllSecureData();
    await _preferences.clearAll();
  }
}
