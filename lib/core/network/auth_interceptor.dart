import 'package:dio/dio.dart';

import 'api_endpoints.dart';

/// The application uses the business-user guard, matching its login endpoint.
class AuthInterceptor extends Interceptor {
  final Dio dio;
  final Dio refreshDio;
  final Future<String?> Function() getToken;
  final Future<bool> Function(String oldToken, String token, int expiresIn) saveToken;
  final Future<void> Function(String token) onSessionExpired;
  Future<String>? _refreshFuture;
  static const _retried = 'jwtRefreshRetried';
  static const _body = 'jwtRequestBody';
  static const _permanentCodes = {
    'TOKEN_REVOKED', 'INVALID_TOKEN', 'TOKEN_MISSING',
    'SESSION_EXPIRED', 'UNAUTHORIZED',
  };

  AuthInterceptor({
    required this.dio,
    required this.refreshDio,
    required this.getToken,
    required this.saveToken,
    required this.onSessionExpired,
  });

  bool _isProtected(RequestOptions options) {
    final base = Uri.parse(ApiEndpoints.baseUrl);
    return options.uri.origin == base.origin &&
        options.uri.path.startsWith(base.path) &&
        !{ApiEndpoints.login, ApiEndpoints.checkCode, ApiEndpoints.changeCode,
          ApiEndpoints.refresh}.contains(options.uri.path.substring(base.path.length));
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    try {
      // Never send application credentials to third-party APIs (e.g. Maps).
      if (options.uri.origin != Uri.parse(ApiEndpoints.baseUrl).origin) {
        options.headers.remove('Authorization');
        options.headers.remove('apiKey');
      } else if (_isProtected(options)) {
        final token = await getToken();
        options.headers.remove('Authorization');
        if (token != null && token.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $token';
        }
      }
      if (options.data is FormData && options.extra[_retried] != true) {
        options.extra[_body] = (options.data as FormData).clone();
      }
      handler.next(options);
    } catch (error, stackTrace) {
      handler.reject(DioException(requestOptions: options, error: error, stackTrace: stackTrace));
    }
  }

  @override
  void onError(DioException error, ErrorInterceptorHandler handler) async {
    final options = error.requestOptions;
    final data = error.response?.data;
    if (!_isProtected(options) || error.response?.statusCode != 401 || data is! Map) {
      handler.next(error);
      return;
    }
    final authorization = options.headers['Authorization'];
    final token = authorization is String && authorization.startsWith('Bearer ')
        ? authorization.substring(7) : '';
    try {
      if (_permanentCodes.contains(data['code'])) {
        await onSessionExpired(token);
      } else if (data['code'] == 'TOKEN_EXPIRED' &&
          data['action'] == 'REFRESH_TOKEN' && options.extra[_retried] != true) {
        options.extra[_retried] = true;
        final current = await getToken();
        if (current == null || current.isEmpty) {
          handler.next(error);
          return;
        }
        // A delayed response may refer to a token already refreshed by another request.
        final newToken = current != token ? current : await _refresh(token);
        if (await getToken() != newToken) {
          handler.next(error);
          return;
        }
        options.headers['Authorization'] = 'Bearer $newToken';
        if (options.extra[_body] is FormData) {
          options.data = (options.extra[_body] as FormData).clone();
        }
        handler.resolve(await dio.fetch<dynamic>(options));
        return;
      }
      handler.next(error);
    } on DioException catch (refreshError) {
      handler.next(refreshError);
    } catch (failure, stackTrace) {
      handler.next(DioException(requestOptions: options, error: failure, stackTrace: stackTrace));
    }
  }

  Future<String> _refresh(String token) async {
    if (_refreshFuture != null) return _refreshFuture!;
    final future = _performRefresh(token);
    _refreshFuture = future;
    try {
      return await future;
    } finally {
      _refreshFuture = null;
    }
  }

  Future<String> _performRefresh(String token) async {
    try {
      final response = await refreshDio.post<dynamic>(ApiEndpoints.refresh,
          options: Options(headers: {'Authorization': 'Bearer $token'}));
      final body = response.data;
      final data = body is Map ? body['data'] : null;
      if (body is! Map || body['success'] != true || body['code'] != 'TOKEN_REFRESHED' ||
          data is! Map || data['access_token'] is! String ||
          (data['access_token'] as String).isEmpty || data['expires_in'] is! int ||
          (data['expires_in'] as int) <= 0) {
        throw DioException(requestOptions: response.requestOptions, response: response,
            error: 'Unexpected token refresh response');
      }
      final newToken = data['access_token'] as String;
      if (!await saveToken(token, newToken, data['expires_in'] as int)) {
        throw DioException(requestOptions: response.requestOptions, error: 'Session changed during refresh');
      }
      return newToken;
    } on DioException catch (error) {
      final body = error.response?.data;
      if (error.response?.statusCode == 401 && body is Map && _permanentCodes.contains(body['code'])) {
        await onSessionExpired(token);
      }
      rethrow;
    }
  }
}
