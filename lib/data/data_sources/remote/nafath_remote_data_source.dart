import 'package:dartz/dartz.dart';
import 'package:maktab_lessor/core/classes/exception/app_exception.dart';
import 'package:maktab_lessor/core/network/api_endpoints.dart';
import 'package:maktab_lessor/data/data_sources/remote/base_remote_data_source.dart';

import '../../models/response/response_model.dart' as r;

class NafathRemoteDataSource extends BaseRemoteDataSource<r.Response> {
  NafathRemoteDataSource() : super(ApiEndpoints.nafath);

  Future<Either<AppException, r.Response>> sendRequest(data) async {
    return postData(
      endpoint: ApiEndpoints.sendRequest,
      data: {"national_id": data},
    );
  }

  Future<Either<AppException, r.Response>> requestStatus() async {
    return fetchData(
      endpoint: ApiEndpoints.requestStatus,
    );
  }
}
