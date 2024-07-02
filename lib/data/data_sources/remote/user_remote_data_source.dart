import 'package:dartz/dartz.dart';
import 'package:maktab_lessor/core/classes/exception/app_exception.dart';
import 'package:maktab_lessor/core/network/api_endpoints.dart';
import 'package:maktab_lessor/data/data_sources/remote/base_remote_data_source.dart';
import '../../models/response/response_model.dart' as r;

class UserRemoteDataSource extends BaseRemoteDataSource<r.Response> {
  UserRemoteDataSource() : super('');

  Future<Either<AppException, r.Response>> getStatistics() async {
    return fetchData(endpoint: ApiEndpoints.statistics);
  }

  Future<Either<AppException, r.Response>> getUserTypes() async {
    return fetchData(endpoint: ApiEndpoints.userTypes);
  }

  Future<Either<AppException, r.Response>> getUserAgreement() async {
    return fetchData(endpoint: ApiEndpoints.userAgreement);
  }

  Future<Either<AppException, r.Response>> getUnitSettings() async {
    return fetchData(endpoint: ApiEndpoints.officeSettings);
  }

  Future<Either<AppException, r.Response>> setUnitSettings(data) async {
    return postData(endpoint: ApiEndpoints.officeSettings, data: data);
  }
}
