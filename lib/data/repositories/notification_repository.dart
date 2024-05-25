import 'package:dartz/dartz.dart';
import 'package:maktab/core/classes/exception/app_exception.dart';
import 'package:maktab/core/classes/exception/data_exceptions.dart';
import 'package:maktab/data/data_sources/remote/notification_remote_data_source.dart';
import 'package:maktab/data/models/notification/notification_model.dart' as n;

class NotificationRepository {
  final NotificationRemoteDataSource _remoteDataSource;

  NotificationRepository(this._remoteDataSource);

  Future<Either<AppException, List<n.Notification>>> getNotifications() async {
    final result = await _remoteDataSource.getNotifications();
    return result.fold(
      (error) => Left(error),
      (right) {
        try {
          final List<n.Notification> notifications = List<n.Notification>.from(
              right.data.map((dynamic data) => n.Notification.fromJson(data)));
          return Right(notifications);
        } catch (e) {
          return Left(ConversionException(e.toString()));
        }
      },
    );
  }

  Future<Either<AppException, n.Notification>> getNotificationById(id) async {
    final result = await _remoteDataSource.getNotificationById(id);
    return result.fold(
      (error) => Left(error),
      (right) {
        try {
          final n.Notification notification =
              n.Notification.fromJson(right.data);
          return Right(notification);
        } catch (e) {
          return Left(ConversionException(e.toString()));
        }
      },
    );
  }

  Future<Either<AppException, List<n.Notification>>>
      getViewedNotifications() async {
    final result = await _remoteDataSource.getNotViewedNotifications();
    return result.fold(
      (error) => Left(error),
      (right) {
        try {
          final List<n.Notification> notifications = List<n.Notification>.from(
              right.data.map((dynamic data) => n.Notification.fromJson(data)));
          return Right(notifications);
        } catch (e) {
          return Left(ConversionException(e.toString()));
        }
      },
    );
  }

  Future<Either<AppException, List<n.Notification>>>
      getNotViewedNotifications() async {
    final result = await _remoteDataSource.getNotViewedNotifications();
    return result.fold(
      (error) => Left(error),
      (right) {
        try {
          final List<n.Notification> notifications = List<n.Notification>.from(
              right.data.map((dynamic data) => n.Notification.fromJson(data)));
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
}
