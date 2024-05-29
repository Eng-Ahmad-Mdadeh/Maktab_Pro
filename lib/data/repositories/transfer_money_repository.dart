import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:maktab/core/classes/exception/app_exception.dart';
import 'package:maktab/data/data_sources/remote/financial_transactions_data_source.dart';
import 'package:maktab/data/data_sources/remote/transfer_money_data_source.dart';
import 'package:maktab/data/models/financial_transactions/bank_account.dart';
import 'package:maktab/data/models/financial_transactions/receiving_method_model.dart';
import 'package:maktab/data/models/transfers/transfer_pagination_model.dart';
import 'package:maktab/data/models/user/user_model.dart';

class TransferMoneyRepository {
  final TransferMoneyRemoteDataSource _transferMoneyRemoteDataSource;

  TransferMoneyRepository(
      {required TransferMoneyRemoteDataSource transferMoneyRemoteDataSource})
      : _transferMoneyRemoteDataSource = transferMoneyRemoteDataSource;

  Future<Either<AppException, TransferPagination>> getAllTransfers(
      {required int page}) async {
    final result = await _transferMoneyRemoteDataSource.getAllTransfers(page);
    return result.fold(
      (error) => Left(error),
      (right) {
        if (right.status) {
          log(right.data.toString());
          final TransferPagination transferPagination =
              TransferPagination.fromJson(right.data);
          return Right(transferPagination);
        } else {
          return Left(AppException(right.message));
        }
      },
    );
  }
}
