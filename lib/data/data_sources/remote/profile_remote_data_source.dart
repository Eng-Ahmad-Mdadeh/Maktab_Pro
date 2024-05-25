import 'package:dartz/dartz.dart';
import 'package:maktab/core/classes/exception/app_exception.dart';
import 'package:maktab/core/network/api_endpoints.dart';
import 'package:maktab/data/data_sources/remote/base_remote_data_source.dart';
import '../../models/response/response_model.dart' as r;

class ProfileRemoteDataSource extends BaseRemoteDataSource<r.Response> {
  ProfileRemoteDataSource() : super(ApiEndpoints.profile);

  Future<Either<AppException, r.Response>> getProfile() async {
    return fetchAllData();
  }

  Future<Either<AppException, r.Response>> updateProfile(data, files) async {
    return postData(
      data: data,
      files: files,
    );
  }
}
