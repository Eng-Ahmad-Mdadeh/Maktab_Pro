import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:maktab_lessor/core/classes/exception/api_exceptions.dart';
import 'package:maktab_lessor/core/classes/exception/app_exception.dart';
import 'package:maktab_lessor/data/data_sources/remote/profile_remote_data_source.dart';
import 'package:maktab_lessor/data/models/user/user_model.dart';

class ProfileRepository {
  final ProfileRemoteDataSource _remoteDataSource;

  ProfileRepository({required ProfileRemoteDataSource remoteDataSource}) : _remoteDataSource = remoteDataSource;

  Future<Either<ApiException, User>> getProfile() async {
    final result = await _remoteDataSource.getProfile();
    return result.fold(
      (error) => Left(error),
      (right) async {
        try {
          User user = User.fromJson(right.data);
          return Right(user);
        } on ApiException catch (e) {
          return Left(e);
        }
      },
    );
  }

  Future<Either<AppException, User>> updateProfile({
    String? id,
    String? userName,
    String? companyName,
    String? officeName,
    String? email,
    String? city,
    String? neighborhood,
    String? idNumber,
    String? commercialRecord,
    String? licenseNumber,
    String? licenseLink,
    String? phone,
    String? about,
    int? typeId,
    String? image,
  }) async {
    var userData = {
      if ((idNumber??'').isNotEmpty) "IdNumber": idNumber,
      if ((userName??'').isNotEmpty) "username": userName,
      if ((email??'').isNotEmpty) "email": email,
      if ((city??'').isNotEmpty) "city": city,
      if ((neighborhood??'').isNotEmpty) "neighborhood": neighborhood,
      if ((about??'').isNotEmpty) "about": about,
      if ((licenseNumber??'').isNotEmpty) "license_number": licenseNumber,
      if ((licenseLink??'').isNotEmpty) "licenseLink": licenseLink,
      if (typeId != null) "type_id": typeId,
    };
    if (commercialRecord != '') {
      userData.addAll({
        "commercial_record": commercialRecord,
      });
    }
    if (typeId == 1) {
      userData.addAll({"company_name": companyName});
    }
    if (typeId == 5) {
      userData.addAll({"office_name": officeName});
    }
    var userFiles = image != ''
        ? [
            {"field_name": "image", "path": image}
          ]
        : null;
    final result = await _remoteDataSource.updateProfile(userData, userFiles);
    return result.fold(
      (error) => Left(error),
      (right) async {
        try {
          User user = User.fromJson(right.data);
          return Right(user);
        } on ApiException catch (e, s) {
          log(e.message);
          log(s.toString());
          return Left(e);
        } catch (e, s) {
          log(e.toString());
          log(s.toString());
          return Left(AppException('خطأ غير متوقع'));
        }
      },
    );
  }

  Future<Either<AppException, String>> deleteAccount() async {
    final result = await _remoteDataSource.deleteAccount();
    return result.fold(
      (error) => Left(error),
      (right) {
        try {
          return Right(right.data ?? '');
        } on ApiException catch (e) {
          return Left(e);
        }
      },
    );
  }
}
