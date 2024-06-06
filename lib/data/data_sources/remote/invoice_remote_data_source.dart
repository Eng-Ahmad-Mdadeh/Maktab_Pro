import 'package:dartz/dartz.dart';

import '../../../core/classes/exception/app_exception.dart';
import '../../models/response/response_model.dart' as r;
import '../../../core/network/api_endpoints.dart';
import 'base_remote_data_source.dart';

class InvoiceRemoteDataSource extends BaseRemoteDataSource<r.Response> {
  InvoiceRemoteDataSource() : super(ApiEndpoints.invoices);

  Future<Either<AppException, r.Response>> getInvoices(int page) async {
    return fetchAllData(page);
  }

  Future<Either<AppException, r.Response>> getInvoice(id) async {
    return fetchDataWithId(id);
  }
}