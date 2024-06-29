import 'package:dartz/dartz.dart';
import 'package:maktab_lessor/core/classes/exception/app_exception.dart';
import 'package:maktab_lessor/core/network/api_endpoints.dart';
import 'package:maktab_lessor/data/data_sources/remote/base_remote_data_source.dart';
import 'package:maktab_lessor/data/models/response/response_model.dart' as r;

class OfferRemoteDataSource extends BaseRemoteDataSource<r.Response> {
  OfferRemoteDataSource() : super(ApiEndpoints.offers);

  Future<Either<AppException, r.Response>> getAllOffers() async {
    return fetchAllData();
  }

  Future<Either<AppException, r.Response>> getMyOffers() async {
    return fetchData(endpoint: ApiEndpoints.myOffers);
  }

  Future<Either<AppException, r.Response>> getOfferById(id) async {
    return fetchData(endpoint: '/$id');
  }

  Future<Either<AppException, r.Response>> createOffer(data) async {
    return postData(
      endpoint: ApiEndpoints.saveOfficeOffer,
      data: data,
    );
  }

  Future<Either<AppException, r.Response>> setOfferPrices(offerId, data) async {
    return postData(
      endpoint: '${ApiEndpoints.setOfferPrices}/$offerId',
      data: data,
    );
  }

  Future<Either<AppException, r.Response>> updateOfferToOffice(
      offerId, data) async {
    return postData(
      endpoint: '${ApiEndpoints.updateOfferOffices}/$offerId',
      data: data,
    );
  }

  Future<Either<AppException, r.Response>> setOfferStatus(offerId) async {
    return postData(
      endpoint: '${ApiEndpoints.statusOfferOffices}/$offerId',
    );
  }

  Future<Either<AppException, r.Response>> deleteOffer(offerId) async {
    return deleteData(
      endpoint: '${ApiEndpoints.deleteOfferOffices}/$offerId',
    );
  }

  Future<Either<AppException, r.Response>> deleteOfferByOfficePrice(
      offerId, data) async {
    return deleteData(
      endpoint: '${ApiEndpoints.deleteOfferPrice}/$offerId',
    );
  }
}
