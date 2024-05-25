import 'package:dartz/dartz.dart';
import 'package:maktab/core/classes/exception/app_exception.dart';
import 'package:maktab/core/network/api_endpoints.dart';
import 'package:maktab/data/data_sources/remote/base_remote_data_source.dart';
import 'package:maktab/data/models/response/response_model.dart' as r;

class NotificationRemoteDataSource extends BaseRemoteDataSource<r.Response> {
  NotificationRemoteDataSource() : super(ApiEndpoints.notifications);

  Future<Either<AppException, r.Response>> getNotifications() async {
    return fetchAllData();
  }

  Future<Either<AppException, r.Response>> getNotificationById(id) async {
    return fetchDataWithId(id);
  }

  Future<Either<AppException, r.Response>> getViewedNotifications() async {
    return fetchData(
        endpoint: ApiEndpoints.notifications + ApiEndpoints.viewed);
  }

  Future<Either<AppException, r.Response>> getNotViewedNotifications() async {
    return fetchData(
        endpoint: ApiEndpoints.notifications + ApiEndpoints.notViewed);
  }

  Future<Either<AppException, r.Response>> deleteNotification(id) async {
    return deleteData(endpoint: '/$id');
  }
}
