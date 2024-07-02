import 'package:dartz/dartz.dart';
import 'package:maktab_lessor/core/classes/exception/app_exception.dart';
import 'package:maktab_lessor/core/network/api_endpoints.dart';
import 'package:maktab_lessor/data/data_sources/remote/base_remote_data_source.dart';
import '../../../core/classes/exception/api_exceptions.dart';
import '../../models/response/response_model.dart' as r;

class ProfileRemoteDataSource extends BaseRemoteDataSource<r.Response> {
  ProfileRemoteDataSource() : super(ApiEndpoints.profile);

  Future<Either<ApiException, r.Response>> getProfile() async {
    return fetchAllData();
  }

  Future<Either<AppException, r.Response>> updateProfile(data, files) async {
    return postData(
      data: data,
      files: files,
    );
  }

  Future<Either<AppException, r.Response>> deleteAccount() async {
    return postData(
        endpoint: ApiEndpoints.deleteAccount
    );
  }
}
