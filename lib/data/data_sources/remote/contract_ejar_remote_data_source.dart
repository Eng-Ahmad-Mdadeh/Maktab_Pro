import 'package:dartz/dartz.dart';
import 'package:maktab_lessor/core/classes/exception/app_exception.dart';
import 'package:maktab_lessor/core/network/api_endpoints.dart';
import 'package:maktab_lessor/data/data_sources/remote/base_remote_data_source.dart';
import 'package:maktab_lessor/data/models/response/response_model.dart' as r;

class ContractEjarRemoteDataSource extends BaseRemoteDataSource<r.Response> {
  ContractEjarRemoteDataSource(String baseEndpoint)
      : super(ApiEndpoints.contractEjars);

  Future<Either<AppException, r.Response>> getAllContracts() async {
    return fetchAllData();
  }

  Future<Either<AppException, r.Response>> getContractById(contractId) async {
    return fetchData(endpoint: '/$contractId');
  }

  Future<Either<AppException, r.Response>> createContract(data) async {
    return postData(endpoint: ApiEndpoints.create, data: data);
  }

  Future<Either<AppException, r.Response>> updateContract(id, data) async {
    return postData(
      endpoint: '${ApiEndpoints.update}/$id',
      data: data,
    );
  }

  Future<Either<AppException, r.Response>> deleteContract(id) async {
    return deleteData(endpoint: '/$id');
  }
}
