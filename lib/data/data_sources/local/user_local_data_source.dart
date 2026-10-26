import 'package:hive/hive.dart';

class UserLocalDataSource {
  final String tokenBox = 'token';
  Future<void> _pending = Future.value();

  // Serialize storage operations so logout cannot race a refresh write.
  Future<T> _withBox<T>(Future<T> Function(Box<dynamic> box) action) {
    final result = _pending.then((_) async {
      final box = await Hive.openBox<dynamic>(tokenBox);
      return action(box);
    });
    _pending = result.then<void>((_) {}, onError: (Object _) {});
    return result;
  }

  Future<void> setUserToken(String token) => _withBox((box) async {
    await box.put(tokenBox, token);
    await box.delete('expiresAt');
  });

  Future<String?> getUserToken() => _withBox((box) async => box.get(tokenBox) as String?);

  Future<bool> replaceUserToken(String oldToken, String token, int expiresIn) => _withBox((box) async {
    if (box.get(tokenBox) != oldToken) return false;
    await box.putAll({
      tokenBox: token,
      'expiresAt': DateTime.now().add(Duration(seconds: expiresIn)).millisecondsSinceEpoch,
    });
    return true;
  });

  Future<bool> removeUserTokenIfMatches(String token) => _withBox((box) async {
    if (box.get(tokenBox) == null || box.get(tokenBox) != token) return false;
    await box.clear();
    return true;
  });

  Future<void> removeUserToken() => _withBox((box) async { await box.clear(); });
}
