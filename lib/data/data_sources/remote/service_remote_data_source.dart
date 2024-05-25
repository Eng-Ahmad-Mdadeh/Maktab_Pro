import 'package:dartz/dartz.dart';
import 'package:maktab/core/classes/exception/app_exception.dart';
import 'package:maktab/core/network/api_endpoints.dart';
import 'package:maktab/data/data_sources/remote/base_remote_data_source.dart';
import 'package:maktab/data/models/response/response_model.dart' as r;

class ServiceRemoteDataSource extends BaseRemoteDataSource<r.Response> {
  ServiceRemoteDataSource()
      : super(ApiEndpoints.offices + ApiEndpoints.services);

  Future<Either<AppException, r.Response>> addToOffice(officeId, data) async {
    return postData(
      endpoint: '${ApiEndpoints.addToAds}/$officeId',
      data: data,
    );
  }

  Future<Either<AppException, r.Response>> updateToOffice(
      officeId, data) async {
    return postData(
      endpoint: '${ApiEndpoints.updateToAds}/$officeId',
      data: data,
    );
  }

  Future<Either<AppException, r.Response>> deleteFromOffice(
      officeId, data) async {
    return deleteData(
      endpoint: '${ApiEndpoints.delete}/$officeId',
      data: data,
    );
  }
}
