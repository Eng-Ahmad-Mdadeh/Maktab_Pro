import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:maktab_lessor/core/classes/exception/app_exception.dart';
import 'package:maktab_lessor/core/classes/exception/data_exceptions.dart';
import 'package:maktab_lessor/data/data_sources/remote/commission_remote_data_source.dart';
import 'package:maktab_lessor/data/models/commission/commission_model.dart';

class CommissionRepository {
  final CommissionRemoteDataSource _remoteDataSource;

  CommissionRepository(this._remoteDataSource);

  Future<Either<AppException, Commission>> getCommissionLessor() async {
    final result = await _remoteDataSource.getCommissionsLessor();
    return result.fold(
      (error) => Left(error),
      (right) {
        try {
          final Commission commission = Commission.fromJson(right.data);
          return Right(commission);
        } catch (e, s) {
          log(e.toString());
          log(s.toString());
          return Left(ConversionException(e.toString()));
        }
      },
    );
  }
}
