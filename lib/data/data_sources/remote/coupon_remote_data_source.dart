import 'package:dartz/dartz.dart';
import 'package:maktab_lessor/core/classes/exception/app_exception.dart';
import 'package:maktab_lessor/core/network/api_endpoints.dart';
import 'package:maktab_lessor/data/data_sources/remote/base_remote_data_source.dart';
import 'package:maktab_lessor/data/models/response/response_model.dart' as r;

import '../../../core/classes/exception/api_exceptions.dart';

class CouponRemoteDataSource extends BaseRemoteDataSource<r.Response> {
  CouponRemoteDataSource() : super(ApiEndpoints.coupons);

  Future<Either<AppException, r.Response>> getAllCoupons() async {
    return fetchAllData();
  }

  Future<Either<AppException, r.Response>> getCouponById(id) async {
    return fetchDataWithId(id);
  }

  Future<Either<ApiException, r.Response>> createCoupon(data) async {
    return postData(endpoint: ApiEndpoints.create, data: data);
  }

  Future<Either<AppException, r.Response>> updateCoupon(id, data) async {
    return postData(
      endpoint: '${ApiEndpoints.update}/$id',
      data: data,
    );
  }

  Future<Either<AppException, r.Response>> setOfficePrices(id, data) async {
    return postData(
      endpoint: '${ApiEndpoints.setAdsPrice}/$id',
      data: data,
    );
  }

  Future<Either<AppException, r.Response>> updateStatus(
    id,
  ) async {
    return postData(
      endpoint: '${ApiEndpoints.updateStatus}/$id',
    );
  }

  Future<Either<AppException, r.Response>> deleteByOfficePrice(id, data) async {
    return postData(
      endpoint: '${ApiEndpoints.deleteAdsPrice}/$id',
      data: data,
    );
  }

  Future<Either<AppException, r.Response>> deleteCoupon(id) async {
    return deleteData(   endpoint: '${ApiEndpoints.delete}/$id',);

  }
}
