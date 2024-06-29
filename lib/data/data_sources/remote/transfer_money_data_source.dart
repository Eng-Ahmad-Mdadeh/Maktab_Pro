import 'package:dartz/dartz.dart';
import 'package:maktab_lessor/core/classes/exception/app_exception.dart';
import 'package:maktab_lessor/core/network/api_endpoints.dart';
import 'package:maktab_lessor/data/data_sources/remote/base_remote_data_source.dart';
import 'package:maktab_lessor/data/models/response/response_model.dart' as r;

class TransferMoneyRemoteDataSource
    extends BaseRemoteDataSource<r.Response> {
  TransferMoneyRemoteDataSource() : super(ApiEndpoints.transfers);

  Future<Either<AppException, r.Response>> getAllTransfers(page) async {
    return fetchData(endpoint: '?page=$page');
  }
  Future<Either<AppException, r.Response>> getTransferById(id) async {
    return fetchData(endpoint: '/$id');
  }



}
