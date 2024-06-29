import 'package:maktab_lessor/core/helpers/hive_helper.dart';

class UserLocalDataSource {
  final String tokenBox = 'token';

  Future<void> setUserToken(String token) async {
    try {
      await HiveHelper.openBox(tokenBox);
      await HiveHelper.saveData(tokenBox, token);
      await HiveHelper.closeBox();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<String?> getUserToken() async {
    try {
      await HiveHelper.openBox(tokenBox);
      String? token = await HiveHelper.getData(tokenBox);
      await HiveHelper.closeBox();
      return token;
    } catch (e) {
      return null;
    }
  }

  Future<void> removeUserToken() async {
    try {
      await HiveHelper.openBox(tokenBox);
      await HiveHelper.removeData(tokenBox);
      await HiveHelper.closeBox();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
