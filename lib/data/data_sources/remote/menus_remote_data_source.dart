import 'package:dartz/dartz.dart';
import 'package:maktab_lessor/core/classes/exception/app_exception.dart';
import 'package:maktab_lessor/core/network/api_endpoints.dart';
import 'package:maktab_lessor/data/data_sources/remote/base_remote_data_source.dart';
import 'package:maktab_lessor/data/models/response/response_model.dart' as r;

class MenusRemoteDataSource extends BaseRemoteDataSource<r.Response> {
  MenusRemoteDataSource() : super(ApiEndpoints.menus);

  Future<Either<AppException, r.Response>> getFooter() async {
    return fetchData(
      endpoint: ApiEndpoints.getFooter,
    );
  }
}
