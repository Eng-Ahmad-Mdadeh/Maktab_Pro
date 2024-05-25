import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

class HiveHelper {
  static Box<dynamic>? _box;

  static Future<void> initHive() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);
  }

  static Future<void> openBox(boxName) async {
    _box = await Hive.openBox(boxName);
  }

  static Future<void> closeBox() async {
    await _box!.close();
  }

  static Future<void> saveData(key, data) async {
    await _box!.put(key, data);
  }

  static Future<dynamic> getData(key) async {
    return _box!.get(key);
  }

  static Future<dynamic> removeData(key) async {
    return _box!.delete(key);
  }

  static openUserBox(String userBox) {}
}
