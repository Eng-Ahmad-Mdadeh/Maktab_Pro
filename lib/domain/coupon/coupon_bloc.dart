import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:maktab_lessor/core/extension/date_range_extension.dart';
import 'package:maktab_lessor/data/models/coupon/coupon_model.dart';

import '../../core/helpers/date_formatter_helper.dart';
import '../../data/models/office/office_model.dart';
import '../../data/models/office/office_price_model.dart';
import '../../data/repositories/coupon_repository.dart';

part 'coupon_event.dart';

part 'coupon_state.dart';

class CouponBloc extends Bloc<CouponEvent, CouponState> {
  final CouponRepository _couponRepository;

  CouponBloc({required CouponRepository offerRepository})
      : _couponRepository = offerRepository,
        super(CouponState(
          startDate: DateFormatterHelper.getCurrentDate(),
          endDate: DateFormatterHelper.getCurrentDate(),
          prices: const {},
        )) {
    on<InitialCouponEvent>((event, emit) async {
      if (event.coupon != null) {
        state.copyWith(
          isInitialized: false,
          unit: event.unit,
          name: event.coupon!.name,
          startDate: event.coupon!.startDate,
          endDate: event.coupon!.endDate,
          isValidOfferDateRange: true,
          numberUsed: event.coupon!.numberUsed,
          code: event.coupon!.code,
          priceTypes: event.coupon!.priceTypeIds,
          discountType: event.coupon!.discountType == 'percent' ? DiscountTypes.percentage : DiscountTypes.price,
        );

        for (OfficePrice price in event.unit!.prices) {
          if (state.priceTypes.contains(price.typeResId)) {
            state.prices[price.id] = price.price;
          }
        }
        // state.pricesCount = event.coupon!.priceTypeIds.length;
        state.copyWith(pricesCount: event.coupon!.priceTypeIds.length);
      }
      //state.discountType = ;
      // final num discountAmount;
      // final Map<int, num> prices;
      // final List<int> priceTypes;
      // int pricesCount;

      emit(state.copyWith(isInitialized: true));
    });
    on<UpdateCouponStatusEvent>((event, emit) async {
      emit(state.copyWith(couponApiCallState: OfferApiCallState.loading));
      final result = await _couponRepository.updateStatus(event.id);
      result.fold(
        (failure) {
          emit(state.copyWith(couponApiCallState: OfferApiCallState.failure));
        },
        (success) {
          emit(state.copyWith(couponApiCallState: OfferApiCallState.update));
        },
      );
    });
    on<DeleteCouponEvent>((event, emit) async {
      emit(state.copyWith(couponApiCallState: OfferApiCallState.loading));
      final result = await _couponRepository.deleteCoupon(event.id);
      result.fold(
        (failure) {
          emit(state.copyWith(couponApiCallState: OfferApiCallState.failure));
        },
        (success) {
          emit(state.copyWith(couponApiCallState: OfferApiCallState.update));
        },
      );
    });
    on<SelectUnitEvent>((event, emit) async {
      emit(state.copyWith(unit: event.unit));
    });
    on<SetCouponNameEvent>((event, emit) async {
      emit(state.copyWith(name: event.name));
    });
    on<SetCouponUseTimesEvent>((event, emit) async {
      emit(state.copyWith(numberUsed: event.times));
    });
    on<SetCouponCodeEvent>((event, emit) async {
      emit(state.copyWith(code: event.code));
    });
    on<SelectDiscountTypeEvent>((event, emit) {
      emit(state.copyWith(discountType: event.type));
    });
    on<ChangeDiscountAmountEvent>((event, emit) {
      emit(state.copyWith(
        discountAmount: event.amount.isNotEmpty ? num.parse(event.amount) : -1,
      ));
    });
    on<SelectUnitPriceEvent>((event, emit) async {
      Map<int, num> prices = Map.from(state.prices);
      List<int> priceTypes = List.from(state.priceTypes);
      OfficePrice price = state.unit!.prices.firstWhere((price) => price.typeResId == event.id);
      if (!priceTypes.contains(event.id)) {
        if (state.pricesCount == -1) {
          // state.pricesCount = 1;
          state.copyWith(
            pricesCount: 1,
          );
        } else {
          // state.pricesCount++;
          state.copyWith(
            pricesCount: state.pricesCount+1,
          );
        }
        prices[price.id] = price.price;
        priceTypes.add(event.id);
      } else {
        if (state.pricesCount > 0) {
          // state.pricesCount--;
          state.copyWith(
            pricesCount: state.pricesCount-1,
          );
        }
        prices.remove(price.id);
        priceTypes.remove(event.id);
      }
      emit(state.copyWith(prices: prices, priceTypes: priceTypes));
      checkOfferDateRange(emit, DateTimeRange(start: state.startDate!, end: state.endDate!));
    });
    on<SelectAllUnitPricesEvent>((event, emit) async {
      if (state.prices.length < state.unit!.prices.length) {
        Map<int, num> prices = {};
        for (OfficePrice price in state.unit!.prices) {
          prices[price.id] = price.price;
        }
        emit(state.copyWith(prices: prices, priceTypes: [1, 2, 3, 4], pricesCount: prices.length));
      } else {
        emit(state.copyWith(prices: {}, priceTypes: [], pricesCount: 0));
      }
      checkOfferDateRange(emit, DateTimeRange(start: state.startDate!, end: state.endDate!));
    });
    on<ClearPriceCountEvent>((event, emit) async {
      emit(state.copyWith(pricesCount: 0, isValidOfferDateRange: true));
    });
    on<SelectOfferDateRangeEvent>((event, emit) async {
      if (state.unit == null) {
        emit(state.copyWith(startDate: event.range.start, endDate: event.range.end, isValidOfferDateRange: true));
      } else {
        checkOfferDateRange(emit, event.range);
      }
    });
    on<CreateCouponEvent>((event, emit) async {
      emit(state.copyWith(couponApiCallState: OfferApiCallState.loading));
      dynamic result;
      if (event.isUpdate) {
        // log(state.prices.keys.toList().toString());
        log("////////////////////////////////////");
        log("////////////////////////////////////");
        result = await _couponRepository.updateCoupon(
            name: state.name,
            couponId: event.couponId!,
            numberUsed: state.numberUsed,
            code: state.code,
            status: '1',
            discount: state.discountAmount.toString(),
            discountType: state.discountType == DiscountTypes.percentage ? 'percent' : 'rial',
            startDate: state.startDate!,
            endDate: state.endDate!,
            officeId: state.unit!.id,
            prices: state.priceTypes,
            mainPrices: state.prices.keys.toList());
      } else {
        result = await _couponRepository.createCoupon(
          name: state.name,
          numberUsed: state.numberUsed,
          code: state.code,
          status: '1',
          discount: state.discountAmount.toString(),
          discountType: state.discountType == DiscountTypes.percentage ? 'percent' : 'rial',
          startDate: state.startDate!,
          endDate: state.endDate!,
          officeId: state.unit!.id,
          prices: state.prices.keys.toList(),
        );
      }

      result.fold(
        (failure) {
          emit(state.copyWith(couponApiCallState: OfferApiCallState.failure, message: failure.message));
        },
        (success) {
          emit(state.copyWith(couponApiCallState: OfferApiCallState.success, message: 'تمت اضافة الكوبون بنجاح'));
        },
      );
      emit(state.copyWith(couponApiCallState: OfferApiCallState.initial, message: ''));
    });
  }

  void checkOfferDateRange(Emitter emit, DateTimeRange range) {
    List<Coupon> offersWithTypes = [];
    for (Coupon offer in state.unit!.coupons) {
      for (int id in state.priceTypes) {
        if (offer.priceTypeIds.contains(id)) {
          offersWithTypes.add(offer);
          break;
        }
      }
    }
    log(offersWithTypes.toString());
    if (offersWithTypes.isNotEmpty) {
      for (Coupon offer in offersWithTypes) {
        if (range.isRangeOutRange(offer.startDate, offer.endDate)) {
          emit(state.copyWith(isValidOfferDateRange: true));
        } else {
          emit(state.copyWith(
            isValidOfferDateRange: false,
            selectedOffer: offer,
          ));
        }
      }
      emit(state.copyWith(startDate: range.start, endDate: range.end));
    } else {
      emit(state.copyWith(
        startDate: range.start,
        endDate: range.end,
        isValidOfferDateRange: true,
      ));
    }
  }
}
