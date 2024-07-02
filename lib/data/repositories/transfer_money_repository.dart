import 'package:dartz/dartz.dart';
import 'package:maktab_lessor/core/classes/exception/app_exception.dart';
import 'package:maktab_lessor/data/data_sources/remote/transfer_money_data_source.dart';
import 'package:maktab_lessor/data/models/transfers/transfer_pagination_model.dart';

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
          // log(right.data.toString());
          final TransferPagination transferPagination =
              TransferPagination.fromJson(right.data);
          return Right(transferPagination);
        } else {
          return Left(AppException(right.message?? 'Unknown error'));
        }
      },
    );
  }
}
