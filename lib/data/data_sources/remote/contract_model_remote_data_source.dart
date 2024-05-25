import 'package:dartz/dartz.dart';
import 'package:maktab/core/classes/exception/app_exception.dart';
import 'package:maktab/core/network/api_endpoints.dart';
import 'package:maktab/data/data_sources/remote/base_remote_data_source.dart';
import 'package:maktab/data/models/response/response_model.dart' as r;

class ContractModelRemoteDataSource extends BaseRemoteDataSource<r.Response> {
  ContractModelRemoteDataSource() : super(ApiEndpoints.contractModels);

  Future<Either<AppException, r.Response>> getContractModels() async {
    return fetchAllData();
  }

  Future<Either<AppException, r.Response>> getReadyContractModels() async {
    return fetchData(endpoint: ApiEndpoints.ready);
  }

  Future<Either<AppException, r.Response>> getContractModelById(id) async {
    return fetchDataWithId(id);
  }

  Future<Either<AppException, r.Response>> createContractModel(data) async {
    return postData(endpoint: ApiEndpoints.create, data: data);
  }

  Future<Either<AppException, r.Response>> updateContractModel(id, data) async {
    return postData(
      endpoint: '${ApiEndpoints.update}/$id',
      data: data,
    );
  }

  Future<Either<AppException, r.Response>> deleteContractModel(id) async {
    return deleteData(endpoint: '/$id');
  }

  Future<Either<AppException, r.Response>> setContractModelStatus(id) async {
    return postData(
      endpoint: '${ApiEndpoints.setStatus}/id',
      data: id,
    );
  }
}
