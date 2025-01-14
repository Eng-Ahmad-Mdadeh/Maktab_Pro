import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:maktab_lessor/core/classes/exception/app_exception.dart';
import 'package:maktab_lessor/core/classes/exception/data_exceptions.dart';
import 'package:maktab_lessor/data/data_sources/remote/evaluation_remote_data_source.dart';
import 'package:maktab_lessor/data/models/office/office_model.dart';

class EvaluationRepository {
  final EvaluationRemoteDataSource _remoteDataSource;

  EvaluationRepository(this._remoteDataSource);

  Future<Either<AppException, List<Office>>> getEvaluations() async {
    final result = await _remoteDataSource.getEvaluations();
    return result.fold(
          (error) => Left(error),
          (right) {
        try {
          final List<Office> evaluations = List<Office>.from(
              right.data.map((evaluation) => Office.fromJson(evaluation)));
          return Right(evaluations);
        } catch (e, s) {
          log(e.toString());
          log(s.toString());
          return Left(ConversionException(e.toString()));
        }
      },
    );
  }

  Future<Either<AppException, List<Office>>> getMyEvaluations() async {
    final result = await _remoteDataSource.getMyEvaluations();
    return result.fold(
      (error) => Left(error),
      (right) {
        try {
          final List<Office> evaluations = List<Office>.from(
              right.data.map((evaluation) => Office.fromJson(evaluation)));
          return Right(evaluations);
        } catch (e, s) {
          log(e.toString());
          log(s.toString());
          return Left(ConversionException(e.toString()));
        }
      },
    );
  }

  Future<Either<AppException, Office>> addToOffice({
    required num rate,
    required String comment,
    required int officeId,
  }) async {
    final result = await _remoteDataSource.addToOffice({
      "rate": rate,
      "comment": comment,
      "ads_id": officeId,
    });
    return result.fold(
      (error) => Left(error),
      (right) {
        try {
          final Office evaluation = Office.fromJson(right.data);
          return Right(evaluation);
        } catch (e, s) {
          log(e.toString());
          log(s.toString());
          return Left(ConversionException(e.toString()));
        }
      },
    );
  }

  Future<Either<AppException, Office>> deleteFromOffice({
    required int evaluationId,
    required int officeId,
  }) async {
    final result = await _remoteDataSource.deleteFromOffice(
      officeId,
      {"evaluation_id": evaluationId},
    );
    return result.fold(
      (error) => Left(error),
      (right) {
        try {
          final Office evaluation = Office.fromJson(right.data);
          return Right(evaluation);
        } catch (e, s) {
          log(e.toString());
          log(s.toString());
          return Left(ConversionException(e.toString()));
        }
      },
    );
  }
}
