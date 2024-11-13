import 'dart:developer';

import 'package:dartz/dartz.dart';

import '../../core/classes/exception/app_exception.dart';
import '../../core/classes/exception/data_exceptions.dart';
import '../../domain/menus/footer_model.dart';
import '../data_sources/remote/menus_remote_data_source.dart';

class MenusRepository {
  final MenusRemoteDataSource _remoteDataSource;

  MenusRepository(this._remoteDataSource);

  Future<Either<AppException, FooterModel>> getFooter() async {
    final result = await _remoteDataSource.getFooter();
    return result.fold(
      (error) {
        return Left(error);
      },
      (right) {
        try {
          final FooterModel footer = FooterModel.fromJson(right.data);
          return Right(footer);
        } catch (e, s) {
          log(e.toString());
          log(s.toString());
          return Left(ConversionException(e.toString()));
        }
      },
    );
  }
}
