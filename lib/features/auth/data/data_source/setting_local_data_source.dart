import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_task/core/exeptions/exeptions.dart';

abstract class SettingsBaseDataSource {
  Future<String?> getWebUrl();
  Future<void> saveWebUrl(String url);
}

class SettingsDataSourceImpl implements SettingsBaseDataSource {
  static const String _urlKey = 'SAVED_WEB_URL';
  final SharedPreferences sharedPreferences;

  SettingsDataSourceImpl({required this.sharedPreferences});

  @override
  Future<String?> getWebUrl() async {
    final url = sharedPreferences.getString(_urlKey);
    if (url == null || url.isEmpty) {
      throw NoDataException();
    }
    return url;
  }

  @override
  Future<void> saveWebUrl(String url) async {
    final success = await sharedPreferences.setString(_urlKey, url);
    if (!success) {
      throw ServerException();
    }
  }
}