import 'package:dartz/dartz.dart';

import '../../core/classes/exception/app_exception.dart';
import '../../core/classes/exception/data_exceptions.dart';
import '../data_sources/remote/settings_remote_data_source.dart';
import '../models/aqar_filter/aqar_filter_model.dart';
import '../models/settings/general_setting_model.dart';

class SettingsRepository {
  final SettingsRemoteDataSource _remoteDataSource;

  SettingsRepository(this._remoteDataSource);

  Future<Either<AppException, AqarFilterModel>> getSearchData() async {
    final result = await _remoteDataSource.getSearchData();
    return result.fold(
      (error) {
        return Left(error);
      },
      (right) {
        try {
          final AqarFilterModel settings = AqarFilterModel.fromJson(right.data);
          return Right(settings);
        } catch (e) {
          return Left(ConversionException(e.toString()));
        }
      },
    );
  }

  Future<Either<AppException, GeneralSettingsModel>> getGeneralSettings() async {
    final result = await _remoteDataSource.getGeneralSettings();
    return result.fold(
      (error) => Left(error),
      (right) {
        try {
          final GeneralSettingsModel settings = GeneralSettingsModel.fromJson(right.data);
          return Right(settings);
        } catch (e) {
          return Left(ConversionException(e.toString()));
        }
      },
    );
  }
}
