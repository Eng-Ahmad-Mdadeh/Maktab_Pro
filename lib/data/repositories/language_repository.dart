import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:maktab_lessor/core/classes/exception/app_exception.dart';
import 'package:maktab_lessor/core/classes/exception/data_exceptions.dart';
import 'package:maktab_lessor/data/data_sources/remote/language_remote_data_source.dart';
import 'package:maktab_lessor/data/models/language/language_model.dart';

class LanguageRepository {
  final LanguageRemoteDataSource _remoteDataSource;

  LanguageRepository(this._remoteDataSource);

  Future<Either<AppException, List<Language>>> getLanguages() async {
    final result = await _remoteDataSource.getLanguages();
    return result.fold(
      (error) => Left(error),
      (right) {
        try {
          final List<Language> languages = List<Language>.from(
            right.data.map((dynamic data) => Language.fromJson(data)),
          );
          return Right(languages);
        } catch (e, s) {
          log(e.toString());
          log(s.toString());
          return Left(ConversionException(e.toString()));
        }
      },
    );
  }
}
