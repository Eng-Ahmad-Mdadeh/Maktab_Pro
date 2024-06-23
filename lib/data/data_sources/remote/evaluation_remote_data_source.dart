import 'package:dartz/dartz.dart';
import 'package:maktab/core/classes/exception/app_exception.dart';
import 'package:maktab/core/network/api_endpoints.dart';
import 'package:maktab/data/data_sources/remote/base_remote_data_source.dart';
import 'package:maktab/data/models/response/response_model.dart' as r;

class EvaluationRemoteDataSource extends BaseRemoteDataSource<r.Response> {
  EvaluationRemoteDataSource() : super(ApiEndpoints.evaluations);

  Future<Either<AppException, r.Response>> getEvaluations() async {
    return fetchAllData();
  }

  Future<Either<AppException, r.Response>> getMyEvaluations() async {
    return fetchData(endpoint: ApiEndpoints.getMy);
  }

  Future<Either<AppException, r.Response>> addToOffice(data) async {
    return postData(
      endpoint: ApiEndpoints.saveToAds,
      data: data,
    );
  }

  Future<Either<AppException, r.Response>> deleteFromOffice(
      officeId, data) async {
    return deleteData(
      endpoint: '${ApiEndpoints.deleteByAds}/$officeId',
      data: data,
    );
  }
}
