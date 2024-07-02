import 'package:dartz/dartz.dart';
import 'package:maktab_lessor/core/classes/exception/app_exception.dart';
import 'package:maktab_lessor/core/classes/exception/data_exceptions.dart';
import 'package:maktab_lessor/data/data_sources/remote/notification_remote_data_source.dart';
import 'package:maktab_lessor/data/models/notification/notification_model.dart' as n;
import 'package:maktab_lessor/data/models/pagination/pagination_model.dart';

class NotificationRepository {
  final NotificationRemoteDataSource _remoteDataSource;

  NotificationRepository(this._remoteDataSource);

  Future<Either<AppException, List<n.NotificationModel>>> getNotifications() async {
    final result = await _remoteDataSource.getNotifications();
    return result.fold(
      (error) => Left(error),
      (right) {
        try {
          final PaginationModel pagination = PaginationModel.fromJson(right.data);
          final List<n.NotificationModel> notifications = List<n.NotificationModel>.from(
              pagination.data.map((dynamic data) => n.NotificationModel.fromJson(data)));
          return Right(notifications);
        } catch (e) {
          return Left(ConversionException(e.toString()));
        }
      },
    );
  }

  Future<Either<AppException, n.NotificationModel>> getNotificationById(id) async {
    final result = await _remoteDataSource.getNotificationById(id);
    return result.fold(
      (error) => Left(error),
      (right) {
        try {
          final n.NotificationModel notification =
              n.NotificationModel.fromJson(right.data);
          return Right(notification);
        } catch (e) {
          return Left(ConversionException(e.toString()));
        }
      },
    );
  }

  Future<Either<AppException, List<n.NotificationModel>>>
      getViewedNotifications() async {
    final result = await _remoteDataSource.getNotViewedNotifications();
    return result.fold(
      (error) => Left(error),
      (right) {
        try {
          final List<n.NotificationModel> notifications = List<n.NotificationModel>.from(
              right.data.map((dynamic data) => n.NotificationModel.fromJson(data)));
          return Right(notifications);
        } catch (e) {
          return Left(ConversionException(e.toString()));
        }
      },
    );
  }

  Future<Either<AppException, List<n.NotificationModel>>>
      getNotViewedNotifications() async {
    final result = await _remoteDataSource.getNotViewedNotifications();
    return result.fold(
      (error) => Left(error),
      (right) {
        try {
          final List<n.NotificationModel> notifications = List<n.NotificationModel>.from(
              right.data.map((dynamic data) => n.NotificationModel.fromJson(data)));
          return Right(notifications);
        } catch (e) {
          return Left(ConversionException(e.toString()));
        }
      },
    );
  }

  Future<Either<AppException, void>> deleteNotification(id) async {
    final result = await _remoteDataSource.deleteNotification(id);
    return result.fold(
      (error) => Left(error),
      (right) {
        try {
          return const Right(null);
        } catch (e) {
          return Left(ConversionException(e.toString()));
        }
      },
    );
  }

  Future<Either<AppException, void>> setNotificationSeen(id) async {
    final result = await _remoteDataSource.setNotificationSeen(id);
    return result.fold(
          (error) => Left(error),
          (right) {
        try {
          return const Right(null);
        } catch (e) {
          return Left(ConversionException(e.toString()));
        }
      },
    );
  }
}
