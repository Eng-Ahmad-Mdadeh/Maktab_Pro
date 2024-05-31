// ignore_for_file: unused_local_variable

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:maktab/core/extension/date_range_extension.dart';
import 'package:maktab/core/helpers/date_formatter_helper.dart';
import 'package:maktab/data/models/offer/offer_model.dart';
import 'package:maktab/data/models/office/office_model.dart';
import 'package:maktab/data/models/office/office_price_model.dart';
import 'package:maktab/data/repositories/offer_repository.dart';

part 'offer_event.dart';
part 'offer_state.dart';

class OfferBloc extends Bloc<OfferEvent, OfferState> {
  final OfferRepository _offerRepository;

  OfferBloc({required OfferRepository offerRepository})
      : _offerRepository = offerRepository,
        super(OfferState(
          startDate: DateFormatterHelper.getCurrentDate(),
          endDate: DateFormatterHelper.getCurrentDate(),
          prices: const {},
        )) {
    on<InitialOfferEvent>((event, emit) async {
      if (event.offer != null) {
        state.isInitialized = false;
        state.unit = event.unit;
        state.name = event.offer!.name;
        state.startDate = event.offer!.startDate;
        state.endDate = event.offer!.endDate;
        state.isValidOfferDateRange = true;
        state.priceTypes = event.offer!.priceTypeIds;
        state.discountType=event.offer!.discountType=='percent'?DiscountTypes.percentage:DiscountTypes.price;
        for (OfficePrice price in event.unit!.prices) {
          if (state.priceTypes.contains(price.typeResId)) {
            state.prices[price.id!] = price.price!;
          }
        }
        state.pricesCount = event.offer!.priceTypeIds.length;
      }
      //state.discountType = ;
      // final num discountAmount;
      // final Map<int, num> prices;
      // final List<int> priceTypes;
      // int pricesCount;

      emit(state.copyWith(isInitialized: true));
    });
    on<UpdateOfferStatusEvent>((event, emit) async {
      emit(state.copyWith(offerApiCallState: OfferApiCallState.loading));
      final result = await _offerRepository.setOfferStatus(event.id);
      result.fold(
        (failure) {
          emit(state.copyWith(offerApiCallState: OfferApiCallState.failure));
        },
        (success) {
          emit(state.copyWith(offerApiCallState: OfferApiCallState.update));
        },
      );
    });
    on<DeleteOfferEvent>((event, emit) async {
      emit(state.copyWith(offerApiCallState: OfferApiCallState.loading));
      final result = await _offerRepository.deleteOffer(event.id);
      result.fold(
        (failure) {
          emit(state.copyWith(offerApiCallState: OfferApiCallState.failure));
        },
        (success) {
          emit(state.copyWith(offerApiCallState: OfferApiCallState.update));
        },
      );
    });
    on<SelectUnitEvent>((event, emit) async {
      emit(state.copyWith(unit: event.unit));
    });
    on<SetOfferNameEvent>((event, emit) async {
      emit(state.copyWith(name: event.name));
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
      OfficePrice price =
          state.unit!.prices.firstWhere((price) => price.typeResId == event.id);
      if (!priceTypes.contains(event.id)) {
        if (state.pricesCount == -1) {
          state.pricesCount = 1;
        } else {
          state.pricesCount++;
        }
        prices[price.id!] =price.price!;
        priceTypes.add(event.id);
      } else {
        if (state.pricesCount > 0) {
          state.pricesCount--;
        }
        prices.remove(price.id);
        priceTypes.remove(event.id);
      }
      emit(state.copyWith(prices: prices, priceTypes: priceTypes));
      checkOfferDateRange(
          emit, DateTimeRange(start: state.startDate!, end: state.endDate!));
    });
    on<SelectAllUnitPricesEvent>((event, emit) async {
      if (state.prices.length < state.unit!.prices.length) {
        Map<int, num> prices = {};
        for (OfficePrice price in state.unit!.prices) {
          prices[price.id!] = price.price!;
        }
        emit(state.copyWith(
            prices: prices,
            priceTypes: [1, 2, 3, 4],
            pricesCount: prices.length));
      } else {
        emit(state.copyWith(prices: {}, priceTypes: [], pricesCount: 0));
      }
      checkOfferDateRange(
          emit, DateTimeRange(start: state.startDate!, end: state.endDate!));
    });
    on<ClearPriceCountEvent>((event, emit) async {
      emit(state.copyWith(pricesCount: 0, isValidOfferDateRange: true));
    });
    on<SelectOfferDateRangeEvent>((event, emit) async {
      if (state.unit == null) {
        emit(state.copyWith(
            startDate: event.range.start,
            endDate: event.range.end,
            isValidOfferDateRange: true));
      } else {
        checkOfferDateRange(emit, event.range);
      }
    });
    on<CreateOfferEvent>((event, emit) async {
      emit(state.copyWith(offerApiCallState: OfferApiCallState.loading));
       dynamic result;
      if(event.isUpdate){

        result = await _offerRepository.updateOfferToOffice(
            name: state.name,
            offerId: event.offerId!,
            status: '1',
            discount: state.discountAmount.toString(),
            discountType:
            state.discountType == DiscountTypes.percentage ? 'percent' : 'rial',
            startDate: state.startDate!,
            endDate: state.endDate!,
            officeId: state.unit!.id!,
            prices: state.prices.keys.toList(),
         //   mainPrices:state.prices.keys.toList()
        );
      }else {
         result = await _offerRepository.createOffer(
          name: state.name,
          discount: state.discountAmount,
          discountType: state.discountType == DiscountTypes.percentage
              ? 'percent'
              : 'rial',
          startDate: state.startDate!,
          endDate: state.endDate!,
          officeId: state.unit!.id!,
          prices: state.prices.keys.toList(),
        );
      }
      result.fold(
        (failure) {
          emit(state.copyWith(offerApiCallState: OfferApiCallState.failure));
        },
        (success) {
          emit(state.copyWith(offerApiCallState: OfferApiCallState.success));
        },
      );
    });
  }

  void checkOfferDateRange(Emitter emit, DateTimeRange range) {
    List<Offer> offersWithTypes = [];
    for (Offer offer in state.unit!.offers) {
      for (int id in state.priceTypes) {
        if (offer.priceTypeIds.contains(id)) {
          offersWithTypes.add(offer);
          break;
        }
      }
    }
    print(offersWithTypes);
    if (offersWithTypes.isNotEmpty) {
      for (Offer offer in offersWithTypes) {
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
