import 'package:dartz/dartz.dart';
import 'package:maktab_lessor/core/classes/exception/app_exception.dart';
import 'package:maktab_lessor/core/classes/exception/data_exceptions.dart';
import 'package:maktab_lessor/data/data_sources/remote/favourite_remote_data_source.dart';
import 'package:maktab_lessor/data/models/favourite/favourite_model.dart';

class FavouriteRepository {
  final FavouriteRemoteDataSource _remoteDataSource;

  FavouriteRepository(this._remoteDataSource);

  Future<Either<AppException, List<Favourite>>> getAllFavourites() async {
    final result = await _remoteDataSource.getAllFavourites();
    return result.fold(
      (error) => Left(error),
      (right) {
        try {
          final List<Favourite> favourites = List<Favourite>.from(
              right.data.map((coupon) => Favourite.fromJson(coupon)));
          return Right(favourites);
        } catch (e) {
          return Left(ConversionException(e.toString()));
        }
      },
    );
  }

  Future<Either<AppException, Favourite>> addFavouriteOffice(
      favouriteId) async {
    final result = await _remoteDataSource.addFavouriteOffice(favouriteId);
    return result.fold(
      (error) => Left(error),
      (right) {
        try {
          final Favourite favourite = Favourite.fromJson(right.data);
          return Right(favourite);
        } catch (e) {
          return Left(ConversionException(e.toString()));
        }
      },
    );
  }
}
