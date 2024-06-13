import 'package:dartz/dartz.dart';
import 'package:maktab/core/classes/exception/app_exception.dart';
import 'package:maktab/core/network/api_endpoints.dart';
import 'package:maktab/data/data_sources/remote/base_remote_data_source.dart';
import 'package:maktab/data/models/response/response_model.dart' as r;

class CalendarRemoteDataSource extends BaseRemoteDataSource<r.Response> {
  CalendarRemoteDataSource() : super(ApiEndpoints.calendars);

  Future<Either<AppException, r.Response>> getAllCalendars() async {
    return fetchAllData();
  }

  Future<Either<AppException, r.Response>> setOfficeCalendars(data) async {
    return postData(
      endpoint: ApiEndpoints.office,
      data: data,
    );
  }

  Future<Either<AppException, r.Response>> deleteCalendarFromOffice(
      officeId, data) async {
    return postData(
      endpoint: '${ApiEndpoints.deleteOffice}/$officeId',
      data: data,
    );
  }
}
