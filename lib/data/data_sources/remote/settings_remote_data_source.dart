import 'package:dartz/dartz.dart';
import 'package:maktab_lessor/core/classes/exception/app_exception.dart';
import 'package:maktab_lessor/core/network/api_endpoints.dart';
import 'package:maktab_lessor/data/data_sources/remote/base_remote_data_source.dart';
import 'package:maktab_lessor/data/models/response/response_model.dart' as r;

class SettingsRemoteDataSource extends BaseRemoteDataSource<r.Response> {
  SettingsRemoteDataSource() : super(ApiEndpoints.settings);

  Future<Either<AppException, r.Response>> getSearchData() async {
    return fetchData(
      endpoint: ApiEndpoints.searchData,
    );
  }

  Future<Either<AppException, r.Response>> getGeneralSettings() async {
    return fetchData(endpoint:  ApiEndpoints.general);
  }
}
