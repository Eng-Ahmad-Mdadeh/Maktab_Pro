import 'package:dartz/dartz.dart';
import 'package:maktab/core/classes/exception/app_exception.dart';
import 'package:maktab/core/network/api_endpoints.dart';
import 'package:maktab/data/data_sources/remote/base_remote_data_source.dart';
import 'package:maktab/data/models/response/response_model.dart' as r;

class LanguageRemoteDataSource extends BaseRemoteDataSource<r.Response> {
  LanguageRemoteDataSource() : super(ApiEndpoints.languages);

  Future<Either<AppException, r.Response>> getLanguages() async {
    return fetchAllData();
  }
}
