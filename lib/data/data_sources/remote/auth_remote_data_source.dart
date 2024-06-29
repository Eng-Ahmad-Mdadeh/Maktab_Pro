import 'package:dartz/dartz.dart';
import 'package:maktab_lessor/core/classes/exception/api_exceptions.dart';
import 'package:maktab_lessor/core/network/api_endpoints.dart';
import 'package:maktab_lessor/data/data_sources/remote/base_remote_data_source.dart';
import '../../models/response/response_model.dart' as r;

class AuthRemoteDataSource extends BaseRemoteDataSource<r.Response> {
  AuthRemoteDataSource() : super('');

  Future<Either<ApiException, r.Response>> login(data) async {
    return postData(
      endpoint: ApiEndpoints.login,
      data: data,
    );
  }

  Future<Either<ApiException, r.Response>> checkCode(data) async {
    return postData(
      endpoint: ApiEndpoints.checkCode,
      data: data,
    );
  }

  Future<Either<ApiException, r.Response>> changeCode(data) async {
    return postData(
      endpoint: ApiEndpoints.changeCode,
      data: data,
    );
  }

  Future<Either<ApiException, r.Response>> logout() async {
    return postData(
      endpoint: ApiEndpoints.logout,
    );
  }
}
