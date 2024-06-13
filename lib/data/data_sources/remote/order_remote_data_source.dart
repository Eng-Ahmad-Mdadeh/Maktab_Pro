import 'package:dartz/dartz.dart';
import 'package:maktab/core/classes/exception/app_exception.dart';
import 'package:maktab/core/network/api_endpoints.dart';
import 'package:maktab/data/data_sources/remote/base_remote_data_source.dart';
import 'package:maktab/data/models/response/response_model.dart' as r;

class OrderRemoteDataSource extends BaseRemoteDataSource<r.Response> {
  OrderRemoteDataSource() : super(ApiEndpoints.orders);

  Future<Either<AppException, r.Response>> getAllOrders([int? page]) async {
    return fetchAllData(page);
  }

  Future<Either<AppException, r.Response>> getOrdersWithoutPage() async {
    return fetchData(endpoint: ApiEndpoints.allWithoutPagenation);
  }

  Future<Either<AppException, r.Response>> getOrderById(id) async {
    return fetchData(endpoint: '/$id');
  }

  Future<Either<AppException, r.Response>> setPending() async {
    return postData(endpoint: ApiEndpoints.pending);
  }

  Future<Either<AppException, r.Response>> setCancel(int id) async {
    return postData(endpoint: '${ApiEndpoints.cancel}/$id');
  }
}
