import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:maktab/core/classes/exception/api_exceptions.dart';
import 'package:maktab/core/classes/exception/app_exception.dart';
import 'package:maktab/data/data_sources/remote/office_remote_data_source.dart';
import 'package:maktab/data/data_sources/remote/settings_remote_data_source.dart';
import 'package:maktab/data/models/office/office_model.dart';
import 'package:maktab/data/models/office/office_unit_model.dart';
import 'package:maktab/data/models/office/search_data_model.dart';

import '../../domain/unit/unit_bloc.dart';


class OfficeRepository {
  final OfficeRemoteDataSource _officeRemoteDataSource;
  final SettingsRemoteDataSource _settingsRemoteDataSource;

  OfficeRepository({
    required OfficeRemoteDataSource officeRemoteDataSource,
    required SettingsRemoteDataSource settingsRemoteDataSource,
  })  : _officeRemoteDataSource = officeRemoteDataSource,
        _settingsRemoteDataSource = settingsRemoteDataSource;

  Future<Either<AppException, Office>> getOfficeById(id) async {
    final result = await _officeRemoteDataSource.getOfficeById(id);
    return result.fold(
      (error) => Left(error),
      (right) {
        if (right.status) {
          final Office office = Office.fromJson(right.data);
          return Right(office);
        } else {
          return Left(AppException(right.message?? 'Unknown error'));
        }
      },
    );
  }

  Future<Either<AppException, List<Office>>> getMyOffices() async {
    final result = await _officeRemoteDataSource.getMyOffices();
    return result.fold(
      (error) => Left(error),
      (right) {
        if (right.status) {
          final List<Office> offices = List<Office>.from(
              right.data.map((data) => Office.fromJson(data)));
          return Right(offices);
        } else {
          return Left(AppException(right.message?? 'Unknown error'));
        }
      },
    );
  }

  Future<Either<AppException, List<OfficeUnit>>> getMyUnits() async {
    final result = await _officeRemoteDataSource.getMyUnits();
    return result.fold(
      (error) => Left(error),
      (right) {
        if (right.status) {
          final List<OfficeUnit> units = List<OfficeUnit>.from(
              right.data.map((data) => OfficeUnit.fromJson(data)));
          return Right(units);
        } else {
          return Left(AppException(right.message?? 'Unknown error'));
        }
      },
    );
  }

  Future<Either<AppException, List<Office>>> getIncompleteOffices() async {
    final result = await _officeRemoteDataSource.getIncompleteOffices();
    return result.fold(
      (error) => Left(error),
      (right) {
        if (right.status) {
          final List<Office> offices = List<Office>.from(
              right.data.map((data) => Office.fromJson(data)));
          return Right(offices);
        } else {
          return Left(AppException(right.message?? 'Unknown error'));
        }
      },
    );
  }

  Future<Either<AppException, List<Office>>> getIncompleteUnits() async {
    final result = await _officeRemoteDataSource.getIncompleteUnits();
    return result.fold(
      (error) => Left(error),
      (right) {
        if (right.status) {
          final List<Office> offices = List<Office>.from(
              right.data.map((data) => Office.fromJson(data)));
          return Right(offices);
        } else {
          return Left(AppException(right.message?? 'Unknown error'));
        }
      },
    );
  }

  Future<Either<AppException, List<Office>>> getMarketingRequests() async {
    final result = await _officeRemoteDataSource.getMarketingRequests();
    return result.fold(
      (error) => Left(error),
      (right) {
        if (right.status) {
          final List<Office> offices = List<Office>.from(
              right.data.map((data) => Office.fromJson(data)));
          return Right(offices);
        } else {
          return Left(AppException(right.message?? 'Unknown error'));
        }
      },
    );
  }

  Future<Either<AppException, Office?>> createOffice(
      {required String title,
      licenseNumber,
      required int categoryId,
      required bool isMarketing}) async {
    var officeData = {
      "title": title,
      "category_aqar_id": categoryId,
      "is_marketing": isMarketing ? 1 : 0,
    };
    if (licenseNumber.isNotEmpty) {
      officeData['license_number'] = 0000000;
    }
    final result = await _officeRemoteDataSource.createOffice(officeData);
    return result.fold(
      (error) => Left(error),
      (right) async {
        if (right.status) {
          Office office = Office.fromJson(right.data);
          return Right(office);
        } else {
          return Left(AppException(right.message?? 'Unknown error'));
        }
      },
    );
  }

  Future<Either<AppException, Office?>> updateOfficeInfo(
      {officeId,
      equipment,
      space,
      typeId,
      advertiserRelationship,
      advertiserRelationshipType}) async {
    Map<String, dynamic> officeData = {};
    if (space != null) {
      officeData["space"] = space;
    }
    if (equipment != null) {
      officeData["furnisher"] = equipment;
    }
    if (typeId != null) {
      officeData["type_aqar_id"] = typeId;
    }
    if (advertiserRelationship != null) {
      officeData["advertiser_relationship"] = advertiserRelationship;
    }
    if (advertiserRelationshipType != null &&
        advertiserRelationshipType.isNotEmpty) {
      officeData["advertiser_relationship_type"] = advertiserRelationshipType;
    }
    final result =
        await _officeRemoteDataSource.updateInfo(officeId, officeData);
    return result.fold(
      (error) => Left(error),
      (right) async {
        if (right.status) {
          Office office = Office.fromJson(right.data);
          return Right(office);
        } else {
          return Left(AppException(right.message?? 'Unknown error'));
        }
      },
    );
  }

  Future<Either<AppException, Office?>> addOfficeDetails(
      {required List<Map<String, dynamic>> details,
      required int officeId}) async {
    Map<String, dynamic> officeData = {};
    for (int index = 0; index < details.length; index++) {
      if (details[index].keys.first == 'floor') {
        officeData['newDetails[$index][ar_name]'] = 'الدور';
        officeData['newDetails[$index][en_name]'] = 'floor';
        officeData['newDetails[$index][status]'] = 1;
        officeData['newDetails[$index][number_details]'] =
            details[index]['floor'];
      } else if (details[index].keys.first == 'age') {
        officeData['newDetails[$index][ar_name]'] = 'عمر المكتب';
        officeData['newDetails[$index][en_name]'] = 'age';
        officeData['newDetails[$index][status]'] = 1;
        officeData['newDetails[$index][number_details]'] =
            details[index]['age'];
      } else if (details[index].keys.first == 'officescount') {
        officeData['newDetails[$index][ar_name]'] = 'عدد المكاتب';
        officeData['newDetails[$index][en_name]'] = 'officescount';
        officeData['newDetails[$index][status]'] = 1;
        officeData['newDetails[$index][number_details]'] =
            details[index]['officescount'];
      } else if (details[index].keys.first == 'meetingroomscount') {
        officeData['newDetails[$index][ar_name]'] = 'غرف الاجتماعات';
        officeData['newDetails[$index][en_name]'] = 'meetingroomscount';
        officeData['newDetails[$index][status]'] = 1;
        officeData['newDetails[$index][number_details]'] =
            details[index]['meetingroomscount'];
      }
    }
    final result =
        await _officeRemoteDataSource.updateDetails(officeId, officeData);
    return result.fold(
      (error) => Left(error),
      (right) async {
        if (right.status) {
          Office office = Office.fromJson(right.data);
          return Right(office);
        } else {
          return Left(AppException(right.message?? 'Unknown error'));
        }
      },
    );
  }

  Future<Either<AppException, Office?>> updateOfficeDetails(
      {required Map<String, dynamic> newDetails,
      required Map<String, Map<int, dynamic>> updatedDetails,
      required List<int> deletedDetails,
      required int officeId}) async {
    Map<String, dynamic> officeData = {};
    int index = 0;
    newDetails.forEach((key, value) {
      if (key == 'floor') {
        officeData['details[$index][ar_name]'] = 'الدور';
        officeData['details[$index][en_name]'] = 'floors';
      } else if (key == 'age') {
        officeData['details[$index][ar_name]'] = 'عمر المكتب';
        officeData['details[$index][en_name]'] = 'office Age';
      } else if (key == 'officescount') {
        officeData['details[$index][ar_name]'] = 'عدد المكاتب';
        officeData['details[$index][en_name]'] = 'offices numbers';
      } else if (key == 'meetingroomscount') {
        officeData['details[$index][ar_name]'] = 'غرف الاجتماعات';
        officeData['details[$index][en_name]'] = 'Meeting Rooms';
      } else if (key == 'tablescount') {
        officeData['details[$index][ar_name]'] = 'عدد الطاولات';
        officeData['details[$index][en_name]'] = 'Number of Tables';
      } else if (key == 'sharedworkspacescount') {
        officeData['details[$index][ar_name]'] = 'مساحات عمل مشتركة';
        officeData['details[$index][en_name]'] = 'Shared Workspaces';
      }
      officeData['details[$index][id]'] = 0;
      officeData['details[$index][status]'] = 1;
      officeData['details[$index][number_details]'] = value;
      index++;
    });
    updatedDetails.forEach((key, value) {
      if (key == 'floor') {
        officeData['details[$index][ar_name]'] = 'الدور';
        officeData['details[$index][en_name]'] = 'floors';
      } else if (key == 'age') {
        officeData['details[$index][ar_name]'] = 'عمر المكتب';
        officeData['details[$index][en_name]'] = 'office Age';
      } else if (key == 'officescount') {
        officeData['details[$index][ar_name]'] = 'عدد المكاتب';
        officeData['details[$index][en_name]'] = 'offices numbers';
      } else if (key == 'meetingroomscount') {
        officeData['details[$index][ar_name]'] = 'غرف الاجتماعات';
        officeData['details[$index][en_name]'] = 'Meeting Rooms';
      } else if (key == 'tablescount') {
        officeData['details[$index][ar_name]'] = 'عدد الطاولات';
        officeData['details[$index][en_name]'] = 'Number of Tables';
      } else if (key == 'sharedworkspacescount') {
        officeData['details[$index][ar_name]'] = 'مساحات عمل مشتركة';
        officeData['details[$index][en_name]'] = 'Shared Workspaces';
      }
      officeData['details[$index][id]'] = value.keys.first;
      officeData['details[$index][status]'] = 1;
      officeData['details[$index][number_details]'] = value[value.keys.first];
      index++;
    });
    for (var detailId in deletedDetails) {
      officeData['delete_ids[$index]'] = detailId;
      index++;
    }

    log("OFFICE DATA");
    log(officeData.toString());
    final result =
        await _officeRemoteDataSource.updateDetails(officeId, officeData);
    return result.fold(
      (error) => Left(error),
      (right) async {
        if (right.status) {
          Office office = Office.fromJson(right.data);
          return Right(office);
        } else {
          return Left(AppException(right.message?? 'Unknown error'));
        }
      },
    );
  }

  Future<Either<AppException, Office?>> updateOfficeFacilities(
      {required List<int> facilities, required int officeId}) async {
    Map<String, dynamic> officeData = {};
    for (int id in facilities) {
      officeData['facilities[$id]'] = id;
    }
    final result =
        await _officeRemoteDataSource.updateFacilites(officeId, officeData);
    return result.fold(
      (error) => Left(error),
      (right) async {
        if (right.status) {
          Office office = Office.fromJson(right.data);
          return Right(office);
        } else {
          return Left(AppException(right.message?? 'Unknown error'));
        }
      },
    );
  }

  Future<Either<AppException, Office?>> updateOfficeFeatures(
      {required List<int> features, required int officeId}) async {
    Map<String, dynamic> officeData = {};
    for (int id in features) {
      officeData['features[$id]'] = id;
    }
    final result =
        await _officeRemoteDataSource.updateFeatures(officeId, officeData);
    return result.fold(
      (error) => Left(error),
      (right) async {
        if (right.status) {
          Office office = Office.fromJson(right.data);
          return Right(office);
        } else {
          return Left(AppException(right.message?? 'Unknown error'));
        }
      },
    );
  }

  Future<Either<AppException, Office?>> updateOfficeComforts(
      {required List<int> comforts, required int officeId}) async {
    Map<String, dynamic> officeData = {};
    for (int id in comforts) {
      officeData['comforts[$id]'] = id;
    }
    final result =
        await _officeRemoteDataSource.updateComforts(officeId, officeData);
    return result.fold(
      (error) => Left(error),
      (right) async {
        if (right.status) {
          Office office = Office.fromJson(right.data);
          return Right(office);
        } else {
          return Left(AppException(right.message?? 'Unknown error'));
        }
      },
    );
  }

  Future<Either<AppException, Office>> updateViewer(
      {officeId, viewerName, viewerPhone}) async {
    var viewerData = {
      "viewer_name": viewerName,
      "viewer_phone": '+966$viewerPhone',
    };
    final result =
        await _officeRemoteDataSource.updateViewer(officeId, viewerData);
    return result.fold(
      (error) => Left(error),
      (right) async {
        if (right.status) {
          Office office = Office.fromJson(right.data);
          return Right(office);
        } else {
          return Left(AppException(right.message?? 'Unknown error'));
        }
      },
    );
  }

  Future<Either<AppException, Office>> updateDownPayment(
      {officeId, downPayment, DepositTypes? downPaymentType}) async {
    var downPaymentData = {
      "id": officeId,
      "down_payment": downPayment,
      "type_down_payment": downPaymentType == DepositTypes.price ? 'rial' : downPaymentType == DepositTypes.percentage ? 'percent' : 'unknown',
    };
    log("************************************************");
    log(downPaymentData.toString());
    log(downPaymentType.toString());
    log("************************************************");
    final result = await _officeRemoteDataSource.downPayment(downPaymentData);
    return result.fold(
      (error) => Left(error),
      (right) async {
        if (right.status) {
          Office office = Office.fromJson(right.data);
          return Right(office);
        } else {
          return Left(AppException(right.message?? 'Unknown error'));
        }
      },
    );
  }

  Future<Either<AppException, Office>> addUnit({
    required int officeId,
    required String title,
    licenseNumber,
    required int categoryId,
    required bool isMarketing,
    required bool isCentral,
  }) async {
    var officeData = {
      "title": title,
      "category_aqar_id": categoryId,
      "is_marketing": isMarketing ? 1 : 0,
      "is_central": isCentral ? 1 : 0,
    };
    if (licenseNumber.isNotEmpty) {
      officeData['license_number'] = 0000000;
    }
    final result = await _officeRemoteDataSource.addUnit(officeId, officeData);
    return result.fold(
      (error) => Left(error),
      (right) async {
        if (right.status) {
          Office unit = Office.fromJson(right.data);
          return Right(unit);
        } else {
          return Left(AppException(right.message?? 'Unknown error'));
        }
      },
    );
  }

  Future<Either<AppException, void>> addOfficeFiles({
    required int officeId,
    String? video,
    String? mainImage,
    List<String>? images,
    List<String>? marketingFiles,
  }) async {
    List<Map<String, dynamic>> officeFiles = [];
    if (video != null) {
      officeFiles.add({'field_name': 'video', 'path': video});
    }
    if (mainImage != null) {
      officeFiles.add({'field_name': 'main_image', 'path': mainImage});
    }
    if (images != null) {
      officeFiles.add({'field_name': 'images[]', 'path': images});
    }
    final result =
        await _officeRemoteDataSource.addFiles(officeId, officeFiles);
    return result.fold(
      (error) => Left(error),
      (right) async {
        if (right.status) {
          return const Right(null);
        } else {
          return Left(AppException(right.message?? 'Unknown error'));
        }
      },
    );
  }

  Future<Either<AppException, void>> updateFiles({
    required int officeId,
    required String mainImage,
  }) async {
    Map<String, dynamic> officeData = {};
    List<Map<String, dynamic>> officeFiles = [];
    if (mainImage.isNotEmpty) {
      officeFiles.add({'field_name': 'main_image', 'path': mainImage});
    }
    final result = await _officeRemoteDataSource.updateFiles(
        officeId, officeData, officeFiles);
    return result.fold(
      (error) => Left(error),
      (right) async {
        try {
          return const Right(null);
        } on ApiException catch (e) {
          return Left(e);
        }
      },
    );
  }

  Future<Either<AppException, void>> deleteFiles({
    required int officeId,
    required List<int> filesIds,
  }) async {
    final result = await _officeRemoteDataSource.deleteFiles(
      officeId,
      {
        for (int i = 0; i < filesIds.length; i++)
          "file_ids[${i + 1}]": filesIds[i]
      },
    );
    return result.fold(
      (error) => Left(error),
      (right) async {
        if (right.status) {
          return const Right(null);
        } else {
          return Left(AppException(right.message?? 'Unknown error'));
        }
      },
    );
  }

  Future<Either<AppException, void>> deleteMainImage(
      {required int officeId}) async {
    final result = await _officeRemoteDataSource.deleteMainImage(officeId);
    return result.fold(
      (error) => Left(error),
      (right) async {
        if (right.status) {
          return const Right(null);
        } else {
          return Left(AppException(right.message?? 'Unknown error'));
        }
      },
    );
  }

  Future<Either<AppException, Office>> updateDescription(
      {required int officeId, required String description}) async {
    final descriptionData = {"description": description};
    final result = await _officeRemoteDataSource.updateDescription(
        officeId, descriptionData);
    return result.fold(
      (error) => Left(error),
      (right) async {
        if (right.status) {
          Office office = Office.fromJson(right.data);
          return Right(office);
        } else {
          return Left(AppException(right.message?? 'Unknown error'));
        }
      },
    );
  }

  Future<Either<AppException, Office?>> updateCategory(
      {required int officeId, required int categoryId}) async {
    final categoryData = {"category_aqar_id": categoryId};
    final result =
        await _officeRemoteDataSource.updateCategory(officeId, categoryData);
    return result.fold(
      (error) => Left(error),
      (right) async {
        if (right.status) {
          Office office = Office.fromJson(right.data);
          return Right(office);
        } else {
          return Left(AppException(right.message?? 'Unknown error'));
        }
      },
    );
  }

  Future<Either<AppException, Office?>> updateTitle(
      {required int officeId, required String title}) async {
    final officeData = {"title": title};
    final result =
        await _officeRemoteDataSource.updateTitle(officeId, officeData);
    return result.fold(
      (error) => Left(error),
      (right) async {
        if (right.status) {
          Office office = Office.fromJson(right.data);
          return Right(office);
        } else {
          return Left(AppException(right.message?? 'Unknown error'));
        }
      },
    );
  }

  Future<Either<AppException, void>> updateStatus(
      {required int officeId}) async {
    final result = await _officeRemoteDataSource.updateStatus(officeId);
    return result.fold(
      (error) => Left(error),
      (right) async {
        if (right.status) {
          return const Right(null);
        } else {
          return Left(AppException(right.message?? 'Unknown error'));
        }
      },
    );
  }

  Future<Either<AppException, Office>> updateInterface(
      {required int officeId, required int interfaceId}) async {
    var interfaceData = {"interface_id": interfaceId};
    final result =
        await _officeRemoteDataSource.updateInterface(officeId, interfaceData);
    return result.fold(
      (error) => Left(error),
      (right) async {
        if (right.status) {
          Office office = Office.fromJson(right.data);
          return Right(office);
        } else {
          return Left(AppException(right.message?? 'Unknown error'));
        }
      },
    );
  }

  Future<Either<AppException, Office>> updateLocation({
    required int officeId,
    required num lat,
    required num lng,
    required double zoom,
    required String city,
    required String neighborhood,
    required String street,
  }) async {
    var locationData = {
      "lat": lat,
      "lng": lng,
      "zoom": zoom,
      "address": '$city, $neighborhood, $street',
      "city": city,
      "neighborhood": neighborhood,
      "street": street,
    };
    final result =
        await _officeRemoteDataSource.updateLocation(officeId, locationData);
    return result.fold(
      (error) => Left(error),
      (right) async {
        if (right.status) {
          Office office = Office.fromJson(right.data);
          return Right(office);
        } else {
          return Left(AppException(right.message?? 'Unknown error'));
        }
      },
    );
  }

  Future<Either<AppException, void>> deleteById(int id) async {
    final result = await _officeRemoteDataSource.deleteById(id);
    return result.fold(
      (error) => Left(error),
      (right) async {
        if (right.status) {
          return const Right(null);
        } else {
          return Left(AppException(right.message?? 'Unknown error'));
        }
      },
    );
  }

  Future<Either<AppException, void>> makeOfficeSpecial({officeId}) async {
    final result = await _officeRemoteDataSource.makeOfficeSpecial(officeId);
    return result.fold(
      (error) => Left(error),
      (right) async {
        if (right.status) {
          return const Right(null);
        } else {
          return Left(AppException(right.message?? 'Unknown error'));
        }
      },
    );
  }

  Future<Either<AppException, SearchData>> getSearchData() async {
    final result = await _settingsRemoteDataSource.getSearchData();
    return result.fold(
      (error) => Left(error),
      (right) async {
        if (right.status) {
          SearchData data = SearchData.fromJson(right.data);
          return Right(data);
        } else {
          return Left(AppException(right.message?? 'Unknown error'));
        }
      },
    );
  }

  Future<Either<AppException, Office?>> updateOfficePrices(
      {required Map<int, dynamic> newPrices,
      required Map<int, Map<int, dynamic>> updatedPrices,
      required List<int> deletedPrices,
      required int officeId}) async {
    Map<String, dynamic> officeData = {};
    int index = 0;
    newPrices.forEach((key, value) {
      officeData['prices[$index][type_res_id]'] = key;
      officeData['prices[$index][status]'] = 1;
      officeData['prices[$index][price]'] = value;
      index++;
    });
    updatedPrices.forEach((key, value) {
      officeData['prices[$index][id]'] = key;
      officeData['prices[$index][status]'] = 1;
      officeData['prices[$index][type_res_id]'] = value.keys.first;
      officeData['prices[$index][price]'] = value[value.keys.first];
      index++;
    });
    for (var detailId in deletedPrices) {
      officeData['delete_ids[$index]'] = detailId;
      index++;
    }
    final result =
        await _officeRemoteDataSource.updatePrices(officeId, officeData);
    return result.fold(
      (error) => Left(error),
      (right) async {
        if (right.status) {
          Office office = Office.fromJson(right.data);
          return Right(office);
        } else {
          return Left(AppException(right.message?? 'Unknown error'));
        }
      },
    );
  }

  Future<Either<AppException, void>> addMarketingFiles({
    required int officeId,
    String? officeLicensingFile,
    String? buildingLicesnsingFile,
    String? civilDefenseFile,
  }) async {
    List<Map<String, dynamic>> officeFiles = [];
    officeFiles.addAll([
      {'field_name': 'file_estate_deed', 'path': officeLicensingFile},
      {'field_name': 'file_building_license', 'path': buildingLicesnsingFile},
      {'field_name': 'file_civil_defense', 'path': civilDefenseFile},
    ]);
    final result =
        await _officeRemoteDataSource.addMarketingFiles(officeId, officeFiles);
    return result.fold(
      (error) => Left(error),
      (right) async {
        if (right.status) {
          return const Right(null);
        } else {
          return Left(AppException(right.message?? 'Unknown error'));
        }
      },
    );
  }
}
