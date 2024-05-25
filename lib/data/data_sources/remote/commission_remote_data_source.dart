import 'package:dartz/dartz.dart';
import 'package:maktab/core/classes/exception/app_exception.dart';
import 'package:maktab/core/network/api_endpoints.dart';
import 'package:maktab/data/data_sources/remote/base_remote_data_source.dart';
import 'package:maktab/data/models/response/response_model.dart' as r;

class CommissionRemoteDataSource extends BaseRemoteDataSource<r.Response> {
  CommissionRemoteDataSource() : super(ApiEndpoints.commissions);

  Future<Either<AppException, r.Response>> getCommissionsLessor() async {
    return fetchData(endpoint: ApiEndpoints.lessor);
  }
}
