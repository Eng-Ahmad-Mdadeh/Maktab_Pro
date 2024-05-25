import 'package:maktab/core/helpers/hive_helper.dart';
import 'service_locator.dart' as di;

class AppServices {
  static initialServices() async {
    await di.setup();
    await HiveHelper.initHive();
  }
}
