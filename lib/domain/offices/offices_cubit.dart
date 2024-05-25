import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:maktab/data/models/office/office_model.dart';
import 'package:maktab/data/models/office/search_data_model.dart';
import 'package:maktab/data/repositories/calendar_repository.dart';
import 'package:maktab/data/repositories/complaint_repository.dart';
import 'package:maktab/data/repositories/coupon_repository.dart';
import 'package:maktab/data/repositories/offer_repository.dart';
import 'package:maktab/data/repositories/office_repository.dart';
import 'package:maktab/data/repositories/price_repository.dart';

part 'offices_state.dart';

class OfficesCubit extends Cubit<OfficesState> {
  final OfficeRepository _officeRepository;
  final PriceRepository _priceRepository;
  final OfferRepository _offerRepository;
  final CouponRepository _couponRepository;
  final ComplaintRepository _complaintRepository;
  final CalendarRepository _calendarRepository;

  OfficesCubit({
    required OfficeRepository officeRepository,
    required PriceRepository priceRepository,
    required OfferRepository offerRepository,
    required CouponRepository couponRepository,
    required ComplaintRepository complaintRepository,
    required CalendarRepository calendarRepository,
  })  : _officeRepository = officeRepository,
        _priceRepository = priceRepository,
        _offerRepository = offerRepository,
        _couponRepository = couponRepository,
        _complaintRepository = complaintRepository,
        _calendarRepository = calendarRepository,
        super(OfficesState());

  Future<void> getMyOffices() async {
    emit(state.copyWith(
      myOfficesApiCallState: OfficesApiCallState.loading,
      marketingRequestsApiCallState: OfficesApiCallState.initial,
      officeApiCallState: OfficesApiCallState.initial,
      unitApiCallState: OfficesApiCallState.initial,
      pricesApiCallState: OfficesApiCallState.initial,
      offersApiCallState: OfficesApiCallState.initial,
      complaintsApiCallState: OfficesApiCallState.initial,
    ));
    var result = await _officeRepository.getMyOffices();
    result.fold(
        (failure) => emit(
            state.copyWith(myOfficesApiCallState: OfficesApiCallState.failure)),
        (offices) async {
      if (state.searchData == null) {
        var result = await _officeRepository.getSearchData();
        return result.fold(
          (failure) {
            emit(state.copyWith(
              myOfficesApiCallState: OfficesApiCallState.failure,
              searchData: null,
            ));
          },
          (searchData) {
            emit(state.copyWith(
              myOffices: offices,
              searchData: searchData,
              myOfficesApiCallState: OfficesApiCallState.success,
            ));
          },
        );
      } else {
        emit(state.copyWith(
          myOffices: offices,
          myOfficesApiCallState: OfficesApiCallState.success,
        ));
      }
    });
  }

  Future<void> getIncompleteOffices() async {
    emit(state.copyWith(
      incompleteOfficesApiCallState: OfficesApiCallState.loading,
      marketingRequestsApiCallState: OfficesApiCallState.initial,
      officeApiCallState: OfficesApiCallState.initial,
      unitApiCallState: OfficesApiCallState.initial,
      pricesApiCallState: OfficesApiCallState.initial,
      offersApiCallState: OfficesApiCallState.initial,
      complaintsApiCallState: OfficesApiCallState.initial,
    ));
    var result = await _officeRepository.getIncompleteOffices();
    result.fold(
      (failure) => emit(state.copyWith(
          incompleteOfficesApiCallState: OfficesApiCallState.failure)),
      (offices) => emit(state.copyWith(
        incompleteOffices: offices,
        incompleteOfficesApiCallState: OfficesApiCallState.success,
      )),
    );
  }

  Future<void> getIncompleteUnits() async {
    emit(state.copyWith(
      incompleteUnitsApiCallState: OfficesApiCallState.loading,
      marketingRequestsApiCallState: OfficesApiCallState.initial,
      officeApiCallState: OfficesApiCallState.initial,
      unitApiCallState: OfficesApiCallState.initial,
      pricesApiCallState: OfficesApiCallState.initial,
      offersApiCallState: OfficesApiCallState.initial,
      complaintsApiCallState: OfficesApiCallState.initial,
    ));
    var result = await _officeRepository.getIncompleteUnits();
    result.fold(
        (failure) => emit(state.copyWith(
            incompleteUnitsApiCallState: OfficesApiCallState.failure)),
        (units) async {
      if (state.searchData == null) {
        var result = await _officeRepository.getSearchData();
        return result.fold(
          (failure) {
            emit(state.copyWith(
              incompleteUnitsApiCallState: OfficesApiCallState.failure,
              searchData: null,
            ));
          },
          (searchData) {
            emit(state.copyWith(
              incompleteUnits: units,
              searchData: searchData,
              incompleteUnitsApiCallState: OfficesApiCallState.success,
            ));
          },
        );
      } else {
        emit(state.copyWith(
          incompleteUnits: units,
          incompleteUnitsApiCallState: OfficesApiCallState.success,
        ));
      }
    });
  }

  Future<void> getOfficeById(int id, {bool isUpdate = false}) async {
    emit(state.copyWith(
      officeApiCallState: OfficesApiCallState.loading,
      marketingRequestsApiCallState: OfficesApiCallState.initial,
      unitApiCallState: OfficesApiCallState.initial,
      pricesApiCallState: OfficesApiCallState.initial,
      offersApiCallState: OfficesApiCallState.initial,
      complaintsApiCallState: OfficesApiCallState.initial,
    ));
    var result = await _officeRepository.getOfficeById(id);
    return result.fold(
      (failure) {
        emit(state.copyWith(officeApiCallState: OfficesApiCallState.failure));
      },
      (office) {
        if (isUpdate) {
          emit(state.copyWith(
            officeApiCallState: OfficesApiCallState.update,
            selectedOffice: office,
          ));
        } else {
          emit(state.copyWith(
            officeApiCallState: OfficesApiCallState.success,
            selectedOffice: office,
          ));
        }
      },
    );
  }

  Future<void> getAllPrices({bool isUpdate = false}) async {
    emit(state.copyWith(
      pricesApiCallState: OfficesApiCallState.loading,
      marketingRequestsApiCallState: OfficesApiCallState.initial,
      officeApiCallState: OfficesApiCallState.initial,
      unitApiCallState: OfficesApiCallState.initial,
      offersApiCallState: OfficesApiCallState.initial,
      complaintsApiCallState: OfficesApiCallState.initial,
    ));
    var result = await _priceRepository.getPrices();
    result.fold(
        (failure) => emit(
            state.copyWith(pricesApiCallState: OfficesApiCallState.failure)),
        (offices) {
      if (isUpdate) {
        emit(state.copyWith(
          prices: offices,
          pricesApiCallState: OfficesApiCallState.update,
        ));
      } else {
        emit(state.copyWith(
          prices: offices,
          pricesApiCallState: OfficesApiCallState.success,
        ));
      }
    });
  }

  Future<void> getUnitById(int id) async {
    emit(state.copyWith(
      unitApiCallState: OfficesApiCallState.loading,
      marketingRequestsApiCallState: OfficesApiCallState.initial,
      officeApiCallState: OfficesApiCallState.initial,
      pricesApiCallState: OfficesApiCallState.initial,
      offersApiCallState: OfficesApiCallState.initial,
      complaintsApiCallState: OfficesApiCallState.initial,
    ));
    var result = await _officeRepository.getOfficeById(id);
    return result.fold(
      (failure) {
        emit(state.copyWith(unitApiCallState: OfficesApiCallState.failure));
      },
      (office) {
        emit(state.copyWith(
          unitApiCallState: OfficesApiCallState.success,
          selectedOffice: office,
        ));
      },
    );
  }

  Future<void> getAllOffers({bool isUpdate = false}) async {
    emit(state.copyWith(
      pricesApiCallState: OfficesApiCallState.loading,
      marketingRequestsApiCallState: OfficesApiCallState.initial,
      officeApiCallState: OfficesApiCallState.initial,
      unitApiCallState: OfficesApiCallState.initial,
      offersApiCallState: OfficesApiCallState.initial,
      complaintsApiCallState: OfficesApiCallState.initial,
    ));
    var result = await _offerRepository.getAllOffers();
    result.fold(
        (failure) => emit(
            state.copyWith(pricesApiCallState: OfficesApiCallState.failure)),
        (offers) {
      if (isUpdate) {
        emit(state.copyWith(
          offers: offers,
          pricesApiCallState: OfficesApiCallState.update,
        ));
      } else {
        emit(state.copyWith(
          offers: offers,
          pricesApiCallState: OfficesApiCallState.success,
        ));
      }
    });
  }

  Future<void> getAllCoupons({bool isUpdate = false}) async {
    emit(state.copyWith(
      pricesApiCallState: OfficesApiCallState.loading,
      marketingRequestsApiCallState: OfficesApiCallState.initial,
      officeApiCallState: OfficesApiCallState.initial,
      unitApiCallState: OfficesApiCallState.initial,
      offersApiCallState: OfficesApiCallState.initial,
      complaintsApiCallState: OfficesApiCallState.initial,
    ));
    var result = await _couponRepository.getAllCoupons();
    result.fold(
        (failure) => emit(
            state.copyWith(pricesApiCallState: OfficesApiCallState.failure)),
        (coupons) {
      if (isUpdate) {
        emit(state.copyWith(
          coupons: coupons,
          pricesApiCallState: OfficesApiCallState.update,
        ));
      } else {
        emit(state.copyWith(
          coupons: coupons,
          pricesApiCallState: OfficesApiCallState.success,
        ));
      }
    });
  }

  Future<void> getMarketingRequests({bool isUpdate = false}) async {
    emit(state.copyWith(
      marketingRequestsApiCallState: OfficesApiCallState.loading,
      officeApiCallState: OfficesApiCallState.initial,
      unitApiCallState: OfficesApiCallState.initial,
      pricesApiCallState: OfficesApiCallState.initial,
      offersApiCallState: OfficesApiCallState.initial,
      complaintsApiCallState: OfficesApiCallState.initial,
    ));
    var result = await _officeRepository.getMarketingRequests();
    result.fold(
        (failure) => emit(state.copyWith(
            marketingRequestsApiCallState: OfficesApiCallState.failure)),
        (marketingRequests) {
      if (isUpdate) {
        emit(state.copyWith(
          marketingRequests: marketingRequests,
          marketingRequestsApiCallState: OfficesApiCallState.update,
        ));
      } else {
        emit(state.copyWith(
          marketingRequests: marketingRequests,
          marketingRequestsApiCallState: OfficesApiCallState.success,
        ));
      }
    });
  }

  Future<void> getComplaints({bool isUpdate = false}) async {
    emit(state.copyWith(
      complaintsApiCallState: OfficesApiCallState.loading,
      officeApiCallState: OfficesApiCallState.initial,
      unitApiCallState: OfficesApiCallState.initial,
      pricesApiCallState: OfficesApiCallState.initial,
      offersApiCallState: OfficesApiCallState.initial,
    ));
    var result = await _complaintRepository.getComplaints();
    result.fold(
        (failure) => emit(state.copyWith(
            complaintsApiCallState: OfficesApiCallState.failure)),
        (complaints) {
      if (isUpdate) {
        emit(state.copyWith(
          complaints: complaints,
          complaintsApiCallState: OfficesApiCallState.update,
        ));
      } else {
        emit(state.copyWith(
          complaints: complaints,
          complaintsApiCallState: OfficesApiCallState.success,
        ));
      }
    });
  }

  Future<void> getCalendars({bool isUpdate = false}) async {
    emit(state.copyWith(
      calendarsApiCallState: OfficesApiCallState.loading,
      complaintsApiCallState: OfficesApiCallState.initial,
      officeApiCallState: OfficesApiCallState.initial,
      unitApiCallState: OfficesApiCallState.initial,
      pricesApiCallState: OfficesApiCallState.initial,
      offersApiCallState: OfficesApiCallState.initial,
    ));
    var result = await _calendarRepository.getAllCalendars();
    result.fold(
        (failure) => emit(
            state.copyWith(calendarsApiCallState: OfficesApiCallState.failure)),
        (calendars) {
      if (isUpdate) {
        emit(state.copyWith(
          calendars: calendars,
          calendarsApiCallState: OfficesApiCallState.update,
        ));
      } else {
        emit(state.copyWith(
          calendars: calendars,
          calendarsApiCallState: OfficesApiCallState.success,
        ));
      }
    });
  }
}
