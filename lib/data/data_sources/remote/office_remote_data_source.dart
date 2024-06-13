import 'package:dartz/dartz.dart';
import 'package:maktab/core/classes/exception/app_exception.dart';
import 'package:maktab/core/network/api_endpoints.dart';
import 'package:maktab/core/network/network_helper.dart';
import 'package:maktab/core/services/service_locator.dart';
import 'package:maktab/data/data_sources/remote/base_remote_data_source.dart';
import 'package:maktab/data/models/response/response_model.dart' as r;

class OfficeRemoteDataSource extends BaseRemoteDataSource<r.Response> {
  OfficeRemoteDataSource() : super(ApiEndpoints.offices);

  Future<Either<AppException, r.Response>> createOffice(data) async {
    return postData(
      endpoint: ApiEndpoints.create,
      data: data,
    );
  }

  Future<Either<AppException, r.Response>> updateInfo(officeId, data) async {
    return postData(
      endpoint: '${ApiEndpoints.updateOfficeInfo}/$officeId',
      data: data,
    );
  }

  Future<Either<AppException, r.Response>> addDetails(officeId, data) async {
    return postData(
      endpoint: '${ApiEndpoints.details}${ApiEndpoints.addToAds}/$officeId',
      data: data,
    );
  }

  Future<Either<AppException, r.Response>> updateDetails(officeId, data) async {
    return postData(
      endpoint: '${ApiEndpoints.details}${ApiEndpoints.cud}/$officeId',
      data: data,
    );
  }

  Future<Either<AppException, r.Response>> updateFacilites(
      officeId, data) async {
    return postData(
      endpoint: '${ApiEndpoints.facilities}${ApiEndpoints.crud}/$officeId',
      data: data,
    );
  }

  Future<Either<AppException, r.Response>> updateViewer(officeId, data) async {
    return postData(
      endpoint: '${ApiEndpoints.updateViewer}/$officeId',
      data: data,
    );
  }

  Future<Either<AppException, r.Response>> downPayment(data) async {
    return postData(
      endpoint: ApiEndpoints.downPayment,
      data: data,
    );
  }

  Future<Either<AppException, r.Response>> addUnit(officeId, data) async {
    return postData(
      endpoint: '${ApiEndpoints.addUnit}/$officeId',
      data: data,
    );
  }

  Future<Either<AppException, r.Response>> getAllOffices() async {
    return fetchAllData();
  }

  Future<Either<AppException, r.Response>> getOfficeById(id) async {
    return fetchData(endpoint: '$id');
  }

  Future<Either<AppException, r.Response>> getSpecialOffices() async {
    return fetchData(endpoint: ApiEndpoints.specialOffices);
  }

  Future<Either<AppException, r.Response>> getFavouriteOffices() async {
    return fetchData(endpoint: ApiEndpoints.favouriteOffices);
  }

  Future<Either<AppException, r.Response>> getMyOffices() async {
    return fetchData(endpoint: ApiEndpoints.myOffices);
  }

  Future<Either<AppException, r.Response>> getMyUnits() async {
    return fetchData(endpoint: ApiEndpoints.myUnits);
  }

  Future<Either<AppException, r.Response>> getIncompleteOffices() async {
    return fetchData(endpoint: ApiEndpoints.incompleteOffices);
  }

  Future<Either<AppException, r.Response>> getIncompleteUnits() async {
    return fetchData(endpoint: ApiEndpoints.incompleteUnits);
  }

  Future<Either<AppException, r.Response>> getMarketingRequests() async {
    return fetchData(endpoint: ApiEndpoints.marketing);
  }

  Future<Either<AppException, r.Response>> addFiles(officeId, files) async {
    return postData(
      endpoint: '${ApiEndpoints.addOfficeFiles}/$officeId',
      files: files,
    );
  }

  Future<Either<AppException, r.Response>> updateFiles(
      officeId, data, files) async {
    return postData(
      endpoint: '${ApiEndpoints.updateOfficeFiles}/$officeId',
      data: data,
      files: files,
    );
  }

  Future<Either<AppException, r.Response>> deleteFiles(officeId, data) async {
    return postData(
      endpoint: '${ApiEndpoints.deleteOfficeFiles}/$officeId',
      data: data,
    );
  }

  Future<Either<AppException, r.Response>> deleteMainImage(officeId) async {
    return deleteData(
      endpoint: '${ApiEndpoints.deleteOfficeMainImage}/$officeId',
    );
  }

  Future<Either<AppException, r.Response>> updateDescription(
      officeId, data) async {
    return postData(
      endpoint: '${ApiEndpoints.updateOfficeDescription}/$officeId',
      data: data,
    );
  }

  Future<Either<AppException, r.Response>> updateCategory(
      officeId, data) async {
    return postData(
      endpoint: '${ApiEndpoints.updateOfficeCategory}/$officeId',
      data: data,
    );
  }

  Future<Either<AppException, r.Response>> updateTitle(officeId, data) async {
    return postData(
      endpoint: '${ApiEndpoints.updateOfficeTitle}/$officeId',
      data: data,
    );
  }

  Future<Either<AppException, r.Response>> updateStatus(statusId) async {
    return postData(
      endpoint: '${ApiEndpoints.updateOfficeStatus}/$statusId',
    );
  }

  Future<Either<AppException, r.Response>> updateInterface(
      officeId, data) async {
    return postData(
      endpoint: '${ApiEndpoints.updateOfficeInterface}/$officeId',
      data: data,
    );
  }

  Future<Either<AppException, r.Response>> updateLocation(
      officeId, data) async {
    return postData(
      endpoint: '${ApiEndpoints.updateOfficeLocation}/$officeId',
      data: data,
    );
  }

  Future<Either<AppException, r.Response>> deleteById(officeId) async {
    return deleteData(endpoint: '${ApiEndpoints.delete}/$officeId');
  }

  Future<Either<AppException, r.Response>> makeOfficeSpecial(officeId) async {
    return postData(
      endpoint: '${ApiEndpoints.makeOfficeSpecial}/$officeId',
    );
  }

  Future<Either<AppException, r.Response>> updateFacailites(
      officeId, facilities) async {
    return postData(
      endpoint: '${ApiEndpoints.facilities}${ApiEndpoints.crud}/$officeId',
      data: facilities,
    );
  }

  Future<Either<AppException, r.Response>> updateFeatures(
      officeId, features) async {
    return postData(
      endpoint: '${ApiEndpoints.features}${ApiEndpoints.crud}/$officeId',
      data: features,
    );
  }

  Future<Either<AppException, r.Response>> updateComforts(
      officeId, comforts) async {
    return postData(
      endpoint: '${ApiEndpoints.comforts}${ApiEndpoints.crud}/$officeId',
      data: comforts,
    );
  }

  Future<Either<AppException, r.Response>> updatePrices(officeId, data) async {
    return postData(
      endpoint: '${ApiEndpoints.prices}${ApiEndpoints.cud}/$officeId',
      data: data,
    );
  }

  Future<Either<AppException, Map<String, dynamic>>> getOfficeAddressDetails(
      data) async {
    try {
      final Either response = await locator<NetworkHelper>()
          .get(ApiEndpoints.geocoding, queryParams: data);
      return response.fold(
        (error) => Left(error),
        (right) {
          return Right(right);
        },
      );
    } on AppException catch (e) {
      return Left(e);
    }
  }

  Future<Either<AppException, r.Response>> addMarketingFiles(
      officeId, files) async {
    return postData(
      endpoint: '${ApiEndpoints.marketing}/$officeId',
      files: files,
    );
  }
}
