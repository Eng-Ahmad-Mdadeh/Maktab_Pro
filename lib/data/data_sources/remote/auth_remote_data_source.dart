import 'package:dartz/dartz.dart';
import 'package:maktab/core/classes/exception/app_exception.dart';
import 'package:maktab/core/network/api_endpoints.dart';
import 'package:maktab/data/data_sources/remote/base_remote_data_source.dart';
import '../../models/response/response_model.dart' as r;

class AuthRemoteDataSource extends BaseRemoteDataSource<r.Response> {
  AuthRemoteDataSource() : super('');

  Future<Either<AppException, r.Response>> login(data) async {
    return postData(
      endpoint: ApiEndpoints.login,
      data: data,
    );
  }

  Future<Either<AppException, r.Response>> checkCode(data) async {
    return postData(
      endpoint: ApiEndpoints.checkCode,
      data: data,
    );
  }

  Future<Either<AppException, r.Response>> changeCode(data) async {
    return postData(
      endpoint: ApiEndpoints.changeCode,
      data: data,
    );
  }

  Future<Either<AppException, r.Response>> logout() async {
    return postData(
      endpoint: ApiEndpoints.logout,
    );
  }
}
