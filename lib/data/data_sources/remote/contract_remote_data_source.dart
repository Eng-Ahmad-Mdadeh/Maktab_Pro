import 'package:dartz/dartz.dart';
import 'package:maktab/core/classes/exception/app_exception.dart';
import 'package:maktab/core/network/api_endpoints.dart';
import 'package:maktab/data/data_sources/remote/base_remote_data_source.dart';
import 'package:maktab/data/models/response/response_model.dart' as r;

class ContractRemoteDataSource extends BaseRemoteDataSource<r.Response> {
  ContractRemoteDataSource() : super(ApiEndpoints.contracts);

  Future<Either<AppException, r.Response>> getContract() async {
    return fetchAllData();
  }

  Future<Either<AppException, r.Response>> getContractById(id) async {
    return fetchDataWithId(id);
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
