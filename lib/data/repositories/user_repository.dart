import 'package:dartz/dartz.dart';
import 'package:maktab_lessor/core/classes/exception/api_exceptions.dart';
import 'package:maktab_lessor/core/classes/exception/app_exception.dart';
import 'package:maktab_lessor/data/data_sources/remote/user_remote_data_source.dart';
import 'package:maktab_lessor/data/models/office/unit_settings.dart';
import 'package:maktab_lessor/data/models/statistics/statistics_model.dart';
import 'package:maktab_lessor/data/models/user/user_agreement_model.dart';
import 'package:maktab_lessor/data/models/user/user_type.dart';

class UserRepository {
  final UserRemoteDataSource _remoteDataSource;

  UserRepository({required UserRemoteDataSource remoteDataSource})
      : _remoteDataSource = remoteDataSource;

  Future<Either<AppException, Statistics>> getStatistics() async {
    final result = await _remoteDataSource.getStatistics();
    return result.fold(
      (error) => Left(error),
      (right) async {
        if (right.status) {
          Statistics statistics = Statistics.fromJson(right.data);
          return Right(statistics);
        } else {
          return Left(ApiException(right.message?? 'Unknown error'));
        }
      },
    );
  }

  Future<Either<AppException, List<UserType>>> getUserTypes() async {
    final result = await _remoteDataSource.getUserTypes();
    return result.fold(
      (error) => Left(error),
      (right) async {
        if (right.status) {
          List<UserType> userTypes =
              List<UserType>.from(right.data.map((x) => UserType.fromJson(x)));
          return Right(userTypes);
        } else {
          return Left(ApiException(right.message?? 'Unknown error'));
        }
      },
    );
  }

  Future<Either<AppException, UserAgreement?>> getUserAgreement() async {
    try{
      final result = await _remoteDataSource.getUserAgreement();
      return result.fold(
            (error) => Left(error),
            (right) async {
              if (right.status) {
            UserAgreement agreement = UserAgreement.fromJson(right.data['data']);
            return Right(agreement);
          } else {
            return Left(ApiException(right.message??'Unknown error'));
          }
        },
      );
    }catch(e){
      rethrow;
    }
  }

  Future<Either<AppException, UnitSettings?>> getUnitSettings() async {
    final result = await _remoteDataSource.getUnitSettings();
    return result.fold(
      (error) => Left(error),
      (right) async {
        if (right.status) {
          UnitSettings? settings = right.data == null ? null : UnitSettings.fromJson(right.data);
          return Right(settings);
        } else {
          return Left(ApiException(right.message??'Unknown error'));
        }
      },
    );
  }

  Future<Either<AppException, UnitSettings?>> setUnitSettings({
    required bool isInsuranceRequired,
    required String insurancePrice,
    required String conditions,
  }) async {
    final result = await _remoteDataSource.setUnitSettings({
      'required': isInsuranceRequired ? 1 : 0,
      if (isInsuranceRequired) 'price': insurancePrice,
      'text': conditions,
    });
    return result.fold(
      (error) => Left(error),
      (right) async {
        if (right.status) {
          UnitSettings settings = UnitSettings.fromJson(right.data);
          return Right(settings);
        } else {
          return Left(ApiException(right.message??'Unknown error'));
        }
      },
    );
  }
}
