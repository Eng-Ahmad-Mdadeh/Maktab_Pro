import 'package:dartz/dartz.dart';

import '../../core/classes/exception/app_exception.dart';
import '../../core/classes/exception/data_exceptions.dart';
import '../data_sources/remote/invoice_remote_data_source.dart';
import '../models/invoice/invoice_model.dart';

class InvoiceRepository {
  final InvoiceRemoteDataSource _remoteDataSource;

  InvoiceRepository(this._remoteDataSource);

  Future<Either<AppException, InvoiceModel>> getInvoices(int page) async {
    final result = await _remoteDataSource.getInvoices(page);
    return result.fold(
      (error) => Left(error),
      (right) {
        try {
          final InvoiceModel invoices = InvoiceModel.fromJson(right.data);
          return Right(invoices);
        } catch (e) {
          return Left(ConversionException(e.toString()));
        }
      },
    );
  }

  Future<Either<AppException, Invoice>> getInvoice(id) async {
    final result = await _remoteDataSource.getInvoice(id);
    return result.fold(
      (error) => Left(error),
      (right) {
        try {
          final Invoice invoices = Invoice.fromJson(right.data);
          return Right(invoices);
        } catch (e) {
          return Left(ConversionException(e.toString()));
        }
      },
    );
  }

}
