import 'package:dartz/dartz.dart';
import 'package:maktab/core/classes/exception/api_exceptions.dart';
import 'package:maktab/core/classes/exception/app_exception.dart';
import 'package:maktab/data/data_sources/remote/profile_remote_data_source.dart';
import 'package:maktab/data/models/user/user_model.dart';

class ProfileRepository {
  final ProfileRemoteDataSource _remoteDataSource;

  ProfileRepository({required ProfileRemoteDataSource remoteDataSource})
      : _remoteDataSource = remoteDataSource;

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

  Future<Either<AppException, User>> updateProfile(
      {id,
      userName,
      companyName,
      officeName,
      email,
      city,
      neighborhood,
      idNumber,
      commercialRecord,
      licenseNumber,
      licenseLink,
      phone,
      about,
      typeId,
      image}) async {
    var userData = {
      "IdNumber": idNumber,
      "username": userName,
      "email": email,
      "city": city,
      "neighborhood": neighborhood,
      "type_id": typeId,
      "about": about,
      "license_number": licenseNumber,
      "licenseLink": licenseLink
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
        } on ApiException catch (e) {
          return Left(e);
        }
      },
    );
  }
}
