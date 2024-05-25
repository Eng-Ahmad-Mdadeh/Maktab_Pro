import 'package:dartz/dartz.dart';
import 'package:maktab/core/classes/exception/app_exception.dart';
import 'package:maktab/core/network/api_endpoints.dart';
import 'package:maktab/data/data_sources/remote/base_remote_data_source.dart';
import 'package:maktab/data/models/response/response_model.dart' as r;

class FavouriteRemoteDataSource extends BaseRemoteDataSource<r.Response> {
  FavouriteRemoteDataSource() : super(ApiEndpoints.favourites);

  Future<Either<AppException, r.Response>> getAllFavourites() async {
    return fetchAllData();
  }

  Future<Either<AppException, r.Response>> addFavouriteOffice(officeId) async {
    return postData(
      endpoint: '${ApiEndpoints.addFavAds}/$officeId',
    );
  }
}
