import 'dart:developer';
import 'dart:io';

class NetworkInfo {
  static Future<bool> checkInternet() async {
    try {
      var result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (e) {
      if (e.osError?.errorCode == 7) {
        return false;
      } else {
        log('SocketException: $e');
        return false;
      }
    } catch (e) {
      log('Unexpected error: $e');
      return false;
    }
    return false;
  }
}
