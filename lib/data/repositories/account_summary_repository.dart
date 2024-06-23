import 'package:dartz/dartz.dart';
import 'package:maktab/data/models/account_summary/account_summary_model.dart';

import '../../core/classes/exception/api_exceptions.dart';
import '../../core/classes/exception/app_exception.dart';
import '../data_sources/remote/account_summary_data_source.dart';

class AccountSummaryRepository{
  final AccountSummaryDataSource _dataSource;

  AccountSummaryRepository(this._dataSource);

  Future<Either<AppException, AccountSummaryModel>> getAccountSummaries(int page) async {
    final result = await _dataSource.getAccountSummaries(page);
    return result.fold(
          (error) => Left(error),
          (right) {
        if (right.status) {
          final AccountSummaryModel accountSummary = AccountSummaryModel.fromJson(right.data);
          return Right(accountSummary);
        } else {
          return Left(ApiException(right.message??'Unknown error'));
        }
      },
    );
  }
}