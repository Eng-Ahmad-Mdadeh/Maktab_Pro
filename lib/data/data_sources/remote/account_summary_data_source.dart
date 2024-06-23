import 'package:dartz/dartz.dart';
import 'package:maktab/core/network/api_endpoints.dart';

import '../../../core/classes/exception/app_exception.dart';
import 'base_remote_data_source.dart';
import '../../models/response/response_model.dart' as r;

class AccountSummaryDataSource extends BaseRemoteDataSource<r.Response> {
  AccountSummaryDataSource() : super(ApiEndpoints.accountStatements);

  Future<Either<AppException, r.Response>> getAccountSummaries(int page) async {
    return fetchAllData(page);
  }
}