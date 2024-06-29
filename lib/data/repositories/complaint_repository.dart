import 'package:dartz/dartz.dart';
import 'package:maktab_lessor/core/classes/exception/api_exceptions.dart';
import 'package:maktab_lessor/core/classes/exception/app_exception.dart';
import 'package:maktab_lessor/core/classes/exception/data_exceptions.dart';
import 'package:maktab_lessor/data/data_sources/remote/complaint_remote_data_source.dart';
import 'package:maktab_lessor/data/models/office/office_model.dart';

class ComplaintRepository {
  final ComplaintRemoteDataSource _complaintRemoteDataSource;

  ComplaintRepository(
      {required ComplaintRemoteDataSource complaintRemoteDataSource})
      : _complaintRemoteDataSource = complaintRemoteDataSource;

  Future<Either<AppException, List<Office>>> getComplaints() async {
    final result = await _complaintRemoteDataSource.getComplaints();
    return result.fold(
      (error) => Left(error),
      (right) {
        if (right.status) {
          final List<Office> reports = List<Office>.from(
            right.data.map((data) => Office.fromJson(data)),
          );
          return Right(reports);
        } else {
          return Left(ApiException(right.message?? 'Unknown error'));
        }
      },
    );
  }

  Future<Either<AppException, List<Office>>> getReportByAdsId(id) async {
    final result = await _complaintRemoteDataSource.getReportsByAdsId(id);
    return result.fold(
      (error) => Left(error),
      (right) {
        try {
          final List<Office> reports = List<Office>.from(
            right.data['reports'].map((data) => Office.fromJson(data)),
          );
          return Right(reports);
        } catch (e) {
          return Left(ConversionException(e.toString()));
        }
      },
    );
  }

  Future<Either<AppException, Office>> createReport({
    required String reason,
    required String text,
    required int officeId,
  }) async {
    try {
      final reportData =
          _createReportDataMap(reason: reason, text: text, officeId: officeId);
      final result = await _complaintRemoteDataSource.createReport(reportData);
      return result.fold(
        (error) => Left(error),
        (right) {
          try {
            final Office report = Office.fromJson(right.data);
            return Right(report);
          } catch (e) {
            return Left(ConversionException(e.toString()));
          }
        },
      );
    } catch (e) {
      return Left(ConversionException(e.toString()));
    }
  }

  Future<Either<AppException, void>> deleteReport(id) async {
    final result = await _complaintRemoteDataSource.deleteReport(id);
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

  Map<String, dynamic> _createReportDataMap({
    required String reason,
    required String text,
    required int officeId,
  }) {
    return {
      'reason': reason,
      'text': text,
      'ads_id': officeId,
    };
  }
}
