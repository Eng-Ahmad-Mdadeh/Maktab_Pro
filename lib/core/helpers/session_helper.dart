import 'package:flutter/foundation.dart';

class SessionHelper {
  // Recreate the widget-scoped blocs to discard the previous user's state.
  static final revision = ValueNotifier<int>(0);

  static void clearSession() {
    revision.value++;
  }
}
