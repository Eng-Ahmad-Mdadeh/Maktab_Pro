import 'package:dartz/dartz.dart';
import 'package:maktab/core/classes/exception/app_exception.dart';
import 'package:maktab/core/network/api_endpoints.dart';
import 'package:maktab/data/data_sources/remote/base_remote_data_source.dart';
import 'package:maktab/data/models/response/response_model.dart' as r;

class PriceRemoteDataSource extends BaseRemoteDataSource<r.Response> {
  PriceRemoteDataSource() : super(ApiEndpoints.offices + ApiEndpoints.prices);

  Future<Either<AppException, r.Response>> getAllPrices() async {
    return fetchData(endpoint: ApiEndpoints.all);
  }

  Future<Either<AppException, r.Response>> getPriceById(id) async {
    return fetchData(endpoint: '${ApiEndpoints.getById}/ $id');
  }

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
