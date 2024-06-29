import 'dart:developer';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:maktab_lessor/core/classes/exception/api_exceptions.dart';
import 'package:maktab_lessor/core/network/api_endpoints.dart';
import 'package:maktab_lessor/core/services/service_locator.dart';
import 'package:maktab_lessor/data/data_sources/local/user_local_data_source.dart';


class NetworkHelper {
  late Dio _dio;

  static final NetworkHelper _instance = NetworkHelper._internal();

  factory NetworkHelper() {
    return _instance;
  }

  NetworkHelper._internal() {
    final BaseOptions options = BaseOptions(
      baseUrl: ApiEndpoints.baseUrl,
      connectTimeout: const Duration(milliseconds: 5000),
      receiveTimeout: const Duration(milliseconds: 5000),
    );

    _dio = Dio(options);

    _dio.options.headers.addAll({
      'apiKey': 'XTK4qAkmbzrynAmh80rpCOqcZGXz6nNc',
      'Accept': 'application/json',
    });
  }

  Dio get dio => _dio;

  Future<dynamic> get(String url, {Map<String, dynamic>? queryParams, bool googleApi = false}) async {
    String? token = await getToken();
    return _performRequest(googleApi: googleApi,() => _dio.get(
          url,
          queryParameters: queryParams,
          options: Options(headers: {'Authorization': 'Bearer $token'}),
        ));
  }

  Future<dynamic> post(String url,
      {dynamic data, List<Map<String, dynamic>>? files}) async {
    String? token = await getToken();
    FormData formData = FormData();
    if (data != null) {
      formData = FormData.fromMap(data as Map<String, dynamic>);
    }
    if (files != null && files.isNotEmpty) {
      List<MapEntry<String, MultipartFile>> multipartFiles =
          await convertFiles(files);
      formData.files.addAll(multipartFiles);
    }
    return _performRequest(() => _dio.post(
          url,
          options: Options(
            headers: {
              'Content-Type': 'multipart/form-data',
              'Authorization': 'Bearer $token'
            },
          ),
          data: formData,
        ));
  }

  Future<dynamic> patch(String url, dynamic data, {List<String>? files}) async {
    FormData formData = FormData.fromMap(data);
    return _performRequest(() => _dio.patch(url, data: formData));
  }

  Future<dynamic> delete(String url, {dynamic data}) async {
    String? token = await getToken();
    log("REQUEST DATA");
    log(data.toString());
    log("REQUEST URL");
    log(url.toString());
    return _performRequest(() => _dio.delete(
          url,
          options: Options(
            headers: {
              'Content-Type': 'multipart/form-data',
              'Authorization': 'Bearer $token'
            },
          ),
          data: data,
        ));
  }

  Future<Either<Exception, dynamic>> _performRequest(Future<Response> Function() request, {bool googleApi = false}) async {
    if (!(await Connectivity().checkConnectivity()).contains(ConnectivityResult.none)) {
      try {
        Response response = await request();
        log("RESPONSE RESULT");
        log(response.data.toString());
        if(googleApi) return Right(response.data);
        if((bool.tryParse(response.data['status'].toString())??false)) {
          return Right(response.data);
        }else{
          return Left(_handleError(response.data['errNum']??0, response.data['message']??''));
        }
      } catch (e) {
        // print("eeeeeeeeee: $e");
        // rethrow;
        if(e is DioException){
          return Left(_handleError(e.response?.statusCode, e.message));
        }
        rethrow;
        // return Left(ApiException('أعد المحاولة'));
      }
    } else {
      return Left(NoInternetConnectionException());
    }
  }

  Future<String?> getToken() async {
    return await locator<UserLocalDataSource>().getUserToken();
  }

  ApiException _handleError(statusCode, message) {
    switch (statusCode) {
      case "400":
        return BadRequestException(message);
      case "401":
        return UnauthorizedException(message);
      case "403":
        return ForbiddenException(message);
      case "404":
        return NotFoundException(message);
      case "500":
        return InternalServerErrorException(message);
      default:
        return ApiException(message);
    }
  }

  Future<List<MapEntry<String, MultipartFile>>> convertFiles(
      List<Map<String, dynamic>> files) async {
    List<MapEntry<String, MultipartFile>> entryList = [];
    File file;
    for (Map<String, dynamic> f in files) {
      if (f['path'] is String) {
        file = File(f['path']);
        if (await file.exists()) {
          MultipartFile multipartFile = await MultipartFile.fromFile(
            file.path,
            filename: file.uri.pathSegments.last,
          );
          entryList.add(MapEntry(f['field_name'], multipartFile));
        }
      } else if (f['path'] is List) {
        for (String filePath in f['path']) {
          file = File(filePath);
          if (await file.exists()) {
            MultipartFile multipartFile = await MultipartFile.fromFile(
              file.path,
              filename: file.uri.pathSegments.last,
            );
            entryList.add(MapEntry(f['field_name'], multipartFile));
          }
        }
      }
    }
    return entryList;
  }
}
