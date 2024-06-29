import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:maktab_lessor/core/classes/exception/api_exceptions.dart';
import 'package:maktab_lessor/core/classes/exception/app_exception.dart';
import 'package:maktab_lessor/core/classes/exception/data_exceptions.dart';
import 'package:maktab_lessor/core/services/service_locator.dart';
import 'package:maktab_lessor/data/data_sources/local/user_local_data_source.dart';
import 'package:maktab_lessor/data/data_sources/remote/auth_remote_data_source.dart';

import 'profile_repository.dart';

class AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final UserLocalDataSource _localDataSource;

  AuthRepository(
      {required AuthRemoteDataSource authRemoteDataSource, required UserLocalDataSource userLocalDataSource})
      : _remoteDataSource = authRemoteDataSource,
        _localDataSource = userLocalDataSource;

  Future<Either<AppException, String>> login({required String phone, required String messageType}) async {
    log("phone: $phone");
    var loginData = {"phone": "0$phone", "type_message": messageType};
    final result = await _remoteDataSource.login(loginData);
    return result.fold(
      (error) => Left(error),
      (right) {
        try {
          // log(right.message);
          return Right(right.message?? 'Unknown error');
        } on ApiException catch (e) {
          return Left(e);
        }
      },
    );
  }

  Future<Either<AppException, String>> checkCode({required String phone, required String code}) async {
    var loginData = {"phone": "0$phone", "code": code};

    final result = await _remoteDataSource.checkCode(loginData);
    return result.fold(
      (error) => Left(error),
      (right) async {
        try {
          log(right.message?? 'Unknown error');
          await _localDataSource.setUserToken(right.data['access_token']);
          return Right(right.message?? 'Unknown error');
        } catch (e) {
          return Left(ConversionException(e.toString()));
        }
      },
    );
  }

  Future<Either<AppException, void>> changeCode({required String phone}) async {
    var loginData = {"phone": "0$phone"};
    final result = await _remoteDataSource.changeCode(loginData);
    return result.fold(
      (error) => Left(error),
      (right) async {
        try {
          log('Code changed');
          return const Right(null);
        } catch (e) {
          return Left(ConversionException(e.toString()));
        }
      },
    );
  }

  Future<Either<AppException, void>> logout() async {
    final result = await _remoteDataSource.logout();
    return result.fold(
      (error) => Left(error),
      (right) async {
        try {
          log(right.message?? 'Unknown error');
          await _localDataSource.removeUserToken();
          return const Right(null);
        } on ApiException catch (e) {
          return Left(e);
        }
      },
    );
  }

  Future<bool> checkAuthentication() async {
    try {
      bool logged = false;
      final result = await locator<ProfileRepository>().getProfile();
      logged = result.fold(
        (l) => false,
        (r) => true,
      );
      String? token = await _localDataSource.getUserToken();
      log("USER_TOKEN: $token");
      return logged ? token != null ? true : false : false;
    } catch (e) {
      return false;
    }
  }
}
