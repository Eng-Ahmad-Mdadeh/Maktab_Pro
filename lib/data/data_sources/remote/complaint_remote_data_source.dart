import 'package:dartz/dartz.dart';
import 'package:maktab_lessor/core/classes/exception/app_exception.dart';
import 'package:maktab_lessor/core/network/api_endpoints.dart';
import 'package:maktab_lessor/data/data_sources/remote/base_remote_data_source.dart';
import 'package:maktab_lessor/data/models/response/response_model.dart' as r;

class ComplaintRemoteDataSource extends BaseRemoteDataSource<r.Response> {
  ComplaintRemoteDataSource() : super(ApiEndpoints.reports);

  Future<Either<AppException, r.Response>> getComplaints() async {
    return fetchAllData();
  }

  Future<Either<AppException, r.Response>> getReportsByAdsId(id) async {
    return fetchDataWithId(id);
  }

  Future<Either<AppException, r.Response>> createReport(data) async {
    return postData(
      endpoint: ApiEndpoints.save,
      data: data,
    );
  }

  Future<Either<AppException, r.Response>> deleteReport(adsId) async {
    return deleteData(endpoint: '/$adsId');
  }
}
