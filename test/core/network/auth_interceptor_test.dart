import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maktab_lessor/core/network/api_endpoints.dart';
import 'package:maktab_lessor/core/network/auth_interceptor.dart';

class TestAdapter implements HttpClientAdapter {
  final Future<ResponseBody> Function(RequestOptions options) respond;
  TestAdapter(this.respond);

  @override
  Future<ResponseBody> fetch(RequestOptions options, Stream<Uint8List>? requestStream,
      Future<void>? cancelFuture) async {
    if (requestStream != null) await requestStream.drain<void>();
    return respond(options);
  }

  @override
  void close({bool force = false}) {}
}

ResponseBody jsonResponse(int status, Map<String, dynamic> data) => ResponseBody.fromString(
    jsonEncode(data), status, headers: {Headers.contentTypeHeader: [Headers.jsonContentType]});

void main() {
  late Dio api;
  late Dio refresh;
  String? token;
  late int refreshCalls;
  late int expiredSessions;
  late int expiresIn;

  setUp(() {
    token = 'old';
    refreshCalls = 0;
    expiredSessions = 0;
    expiresIn = 0;
    api = Dio(BaseOptions(baseUrl: ApiEndpoints.baseUrl));
    refresh = Dio(BaseOptions(baseUrl: ApiEndpoints.baseUrl));
    api.interceptors.add(AuthInterceptor(
      dio: api, refreshDio: refresh,
      getToken: () async => token,
      saveToken: (old, replacement, ttl) async {
        if (token != old) return false;
        token = replacement;
        expiresIn = ttl;
        return true;
      },
      onSessionExpired: (old) async {
        if (token == old) {
          token = null;
          expiredSessions++;
        }
      },
    ));
    api.httpClientAdapter = TestAdapter((options) async {
      if (options.headers['Authorization'] == 'Bearer new') {
        return jsonResponse(200, {'status': true});
      }
      return jsonResponse(401, {'code': 'TOKEN_EXPIRED', 'action': 'REFRESH_TOKEN'});
    });
    refresh.httpClientAdapter = TestAdapter((options) async {
      refreshCalls++;
      expect(options.path, ApiEndpoints.refresh);
      expect(options.data, isNull);
      expect(options.headers['Authorization'], 'Bearer old');
      return jsonResponse(200, {'success': true, 'code': 'TOKEN_REFRESHED',
        'data': {'access_token': 'new', 'expires_in': 123}});
    });
  });

  tearDown(() { api.close(); refresh.close(); });

  test('valid token needs no refresh', () async {
    token = 'new';
    expect((await api.get<dynamic>('profile')).statusCode, 200);
    expect(refreshCalls, 0);
  });

  test('refresh replaces token and uses returned lifetime', () async {
    expect((await api.get<dynamic>('profile')).statusCode, 200);
    expect(token, 'new');
    expect(expiresIn, 123);
    expect(refreshCalls, 1);
  });

  test('concurrent expired requests share one refresh', () async {
    final gate = Completer<void>();
    refresh.httpClientAdapter = TestAdapter((options) async {
      refreshCalls++;
      await gate.future;
      return jsonResponse(200, {'success': true, 'code': 'TOKEN_REFRESHED',
        'data': {'access_token': 'new', 'expires_in': 60}});
    });
    final requests = Future.wait(List.generate(5, (_) => api.get<dynamic>('profile')));
    await Future<void>.delayed(const Duration(milliseconds: 50));
    gate.complete();
    final responses = await requests;
    expect(responses.every((r) => r.statusCode == 200), isTrue);
    expect(refreshCalls, 1);
  });

  test('multipart request can be replayed after refresh', () async {
    final response = await api.post<dynamic>('offices', data: FormData.fromMap({
      'title': 'office', 'file': MultipartFile.fromBytes([1, 2, 3], filename: 'test.bin'),
    }));
    expect(response.statusCode, 200);
    expect(refreshCalls, 1);
  });

  for (final code in ['TOKEN_REVOKED', 'INVALID_TOKEN', 'TOKEN_MISSING', 'UNAUTHORIZED']) {
    test('$code requires login without refresh', () async {
      api.httpClientAdapter = TestAdapter((_) async => jsonResponse(401, {'code': code}));
      await expectLater(api.get<dynamic>('profile'), throwsA(isA<DioException>()));
      expect(token, isNull);
      expect(expiredSessions, 1);
      expect(refreshCalls, 0);
    });
  }

  test('expired refresh window clears session', () async {
    refresh.httpClientAdapter = TestAdapter((_) async => jsonResponse(401, {'code': 'SESSION_EXPIRED'}));
    await expectLater(api.get<dynamic>('profile'), throwsA(isA<DioException>()));
    expect(token, isNull);
    expect(expiredSessions, 1);
  });

  for (final status in [401, 500]) {
    test('unexpected refresh error $status preserves session and does not recurse', () async {
      refresh.httpClientAdapter = TestAdapter((_) async {
        refreshCalls++;
        return jsonResponse(status, {'code': 'TOKEN_EXPIRED'});
      });
      await expectLater(api.get<dynamic>('profile'), throwsA(isA<DioException>()));
      expect(token, 'old');
      expect(refreshCalls, 1);
      expect(expiredSessions, 0);
    });
  }

  test('network timeout preserves session', () async {
    refresh.httpClientAdapter = TestAdapter((options) async {
      throw DioException(requestOptions: options, type: DioExceptionType.connectionTimeout);
    });
    await expectLater(api.get<dynamic>('profile'), throwsA(isA<DioException>()));
    expect(token, 'old');
    expect(expiredSessions, 0);
  });

  test('legacy API-key error is not a successful refresh', () async {
    refresh.httpClientAdapter = TestAdapter((_) async => jsonResponse(200,
        {'status': false, 'errNum': '401', 'message': 'Unauthenticated API'}));
    await expectLater(api.get<dynamic>('profile'), throwsA(isA<DioException>()));
    expect(token, 'old');
    expect(expiredSessions, 0);
  });

  test('retried request cannot initiate another refresh', () async {
    api.httpClientAdapter = TestAdapter((_) async => jsonResponse(401,
        {'code': 'TOKEN_EXPIRED', 'action': 'REFRESH_TOKEN'}));
    await expectLater(api.get<dynamic>('profile'), throwsA(isA<DioException>()));
    expect(refreshCalls, 1);
  });

  test('logout during refresh cannot restore old session', () async {
    refresh.httpClientAdapter = TestAdapter((_) async {
      token = null;
      return jsonResponse(200, {'success': true, 'code': 'TOKEN_REFRESHED',
        'data': {'access_token': 'new', 'expires_in': 60}});
    });
    await expectLater(api.get<dynamic>('profile'), throwsA(isA<DioException>()));
    expect(token, isNull);
  });

  test('third-party requests never receive application credentials', () async {
    api.httpClientAdapter = TestAdapter((options) async {
      expect(options.headers.containsKey('Authorization'), isFalse);
      expect(options.headers.containsKey('apiKey'), isFalse);
      return jsonResponse(200, {});
    });
    await api.get<dynamic>('https://maps.googleapis.com/maps/api/test',
        options: Options(headers: {'Authorization': 'Bearer old', 'apiKey': 'test'}));
    expect(refreshCalls, 0);
  });
}
