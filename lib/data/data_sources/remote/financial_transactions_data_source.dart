import 'package:dartz/dartz.dart';
import 'package:maktab_lessor/core/classes/exception/app_exception.dart';
import 'package:maktab_lessor/core/network/api_endpoints.dart';
import 'package:maktab_lessor/data/data_sources/remote/base_remote_data_source.dart';
import 'package:maktab_lessor/data/models/response/response_model.dart' as r;

class FinancialTransactionsRemoteDataSource
    extends BaseRemoteDataSource<r.Response> {
  FinancialTransactionsRemoteDataSource() : super('');

  Future<Either<AppException, r.Response>> getReceiveMoneyMethod() async {
    return fetchData(endpoint: ApiEndpoints.receivingMoneyMethod);
  }

  Future<Either<AppException, r.Response>> setBankMethod(data) async {
    return postData(
      endpoint: ApiEndpoints.receivingMoneyMethod + ApiEndpoints.bankMethod,
      data: data,
    );
  }

  Future<Either<AppException, r.Response>> setSTCMethod(data) async {
    return postData(
      endpoint: ApiEndpoints.receivingMoneyMethod + ApiEndpoints.stcMethod,
      data: data,
    );
  }

  Future<Either<AppException, r.Response>> deleteReceiveMoneyMethod() async {
    return deleteData(
      endpoint: ApiEndpoints.receivingMoneyMethod.split('/').first,
    );
  }

  Future<Either<AppException, r.Response>> getBankAccounts() async {
    return fetchData(
      endpoint: ApiEndpoints.bankAccounts,
    );
  }

  Future<Either<AppException, r.Response>> verifyNationalID(data) async {
    return postData(
      endpoint: ApiEndpoints.verifyNationalID,
      data: data,
    );
  }

  Future<Either<AppException, r.Response>> verifyResidenceID(data) async {
    return postData(
      endpoint: ApiEndpoints.verifyResidenceID,
      data: data,
    );
  }
}
