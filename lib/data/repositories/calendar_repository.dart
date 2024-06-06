import 'package:dartz/dartz.dart';
import 'package:maktab/core/classes/exception/api_exceptions.dart';
import 'package:maktab/core/classes/exception/app_exception.dart';
import 'package:maktab/core/classes/exception/data_exceptions.dart';
import 'package:maktab/data/data_sources/remote/calendar_remote_data_source.dart';
import 'package:maktab/data/models/calendar/calender_model.dart';
import 'package:maktab/data/models/office/office_model.dart';

class CalendarRepository {
  final CalendarRemoteDataSource _calendarRemoteDataSource;

  CalendarRepository(
      {required CalendarRemoteDataSource calendarRemoteDataSource})
      : _calendarRemoteDataSource = calendarRemoteDataSource;

  Future<Either<AppException, List<Office>>> getAllCalendars() async {
    final result = await _calendarRemoteDataSource.getAllCalendars();
    return result.fold(
      (error) => Left(error),
      (right) {
        if (right.status) {
          final List<Office> calendars = List<Office>.from(
            right.data.map((data) {
              return Office.fromJson(data);
            }),
          );
          return Right(calendars);
        } else {
          return Left(ApiException(right.message?? 'Unknown error'));
        }
      },
    );
  }

  Future<Either<AppException, Office>> setOfficeCalendars({
    required int officeId,
    required int priceId,
    required List<Calendar> calendars,
  }) async {
    try {
      final calendarData = _createCalendarDataMap(
          officeId: officeId, priceId: priceId, calendars: calendars);
      final result =
          await _calendarRemoteDataSource.setOfficeCalendars(calendarData);
      return result.fold(
        (error) {
          throw(error);
          // return Left(error);
        },
        (right) {
          try {
            final Office calendar = Office.fromJson(right.data);
            return Right(calendar);
          } catch (e) {
            rethrow;
            // return Left(ConversionException(e.toString()));
          }
        },
      );
    } catch (e) {
      rethrow;
      // return Left(ConversionException(e.toString()));
    }
  }

  Future<Either<AppException, Office>> deleteCalendarFromOffice({
    required int officeId,
    required List<Calendar> calendars,
  }) async {
    final result = await _calendarRemoteDataSource.deleteCalendarFromOffice(
      officeId,
      _createCalendarIdsMap(calendars: calendars),
    );
    return result.fold(
      (error) => Left(error),
      (right) {
        try {
          final Office calendar = Office.fromJson(right.data);
          return Right(calendar);
        } catch (e) {
          return Left(ConversionException(e.toString()));
        }
      },
    );
  }

  Map<String, dynamic> _createCalendarDataMap({
    required int officeId,
    required int priceId,
    required List<Calendar> calendars,
  }) {
    Map<String, dynamic> calendarMap = {};
    calendarMap.addAll({
      'ads_id': officeId,
      'ads_price_id': priceId,
    });
    for (int i = 0; i < calendars.length; i++) {
      calendarMap.addAll({
        'calenders[$i][start_date]': calendars[i].startDate.toIso8601String(),
        'calenders[$i][end_date]': calendars[i].endDate.toIso8601String(),
      });
    }
    return calendarMap;
  }

  Map<String, dynamic> _createCalendarIdsMap(
      {required List<Calendar> calendars}) {
    Map<String, dynamic> calendarMap = {};
    for (int i = 0; i < calendars.length; i++) {
      calendarMap.addAll({
        'calenders[$i]': calendars[i].id,
      });
    }
    return calendarMap;
  }
}
