import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../data/models/offer/offer_model.dart';
import '../../resources/app_colors.dart';
import '../../widgets/body_text.dart';
import '../../widgets/section_title.dart';

class DatePickerCell extends StatelessWidget {
  final DateTime date;
  final bool isDisabled;
  final CellStyleType cellStyleType;
  final Offer? offer;

  const DatePickerCell({
    super.key,
    required this.date,
    required this.isDisabled,
    required this.cellStyleType,
    required this.offer,
  });

  @override
  Widget build(BuildContext context) {
    final withOffer = cellStyleType == CellStyleType.circleWithOffer ||
        cellStyleType == CellStyleType.leftRadiusWithOffer ||
        cellStyleType == CellStyleType.rightRadiusWithOffer ||
        cellStyleType == CellStyleType.textWithOffer ||
        cellStyleType == CellStyleType.textInRangeWithOffer;
    final cellSelected = cellStyleType == CellStyleType.circle ||
        cellStyleType == CellStyleType.rightRadius ||
        cellStyleType == CellStyleType.leftRadius ||
        cellStyleType == CellStyleType.circleWithOffer ||
        cellStyleType == CellStyleType.leftRadiusWithOffer ||
        cellStyleType == CellStyleType.rightRadiusWithOffer ||
        cellStyleType == CellStyleType.textInRangeWithOffer ||
        cellStyleType == CellStyleType.textInRange;
    switch (cellStyleType) {
      case CellStyleType.yearRange:
        return Center(
          child: SectionTitle(
            title: '${(date.add(const Duration(days: 3600))).year}-${date.year}',
            textColor: isDisabled ? AppColors.cherryRed : AppColors.black,
          ),
        );
      case CellStyleType.textYear:
        return Center(
          child: SectionTitle(
            title:
            date.year.toString(),
            textColor: isDisabled ? AppColors.cherryRed : AppColors.black,
          ),
        );
      case CellStyleType.monthName:
        return Center(
          child: SectionTitle(
            title:
            DateFormat.MMM('ar').format(date),
            textColor: isDisabled ? AppColors.cherryRed : AppColors.black,
          ),
        );
      default:
        return Container(
          decoration: cellSelected ? const BoxDecoration(color: AppColors.mintGreen).convert(cellStyleType) : null,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BodyText(
                text: date.day.toString(),
                textColor: cellSelected
                    ? AppColors.white
                    : isDisabled
                    ? AppColors.cherryRed
                    : AppColors.black,
                textAlign: TextAlign.center,
              ),
              if (withOffer)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BodyText(
                      text: offer!.discount.toStringAsFixed(0),
                      textColor: cellSelected
                          ? AppColors.white
                          : isDisabled
                          ? AppColors.cherryRed
                          : AppColors.mintGreen,
                      textAlign: TextAlign.center,
                      fontSize: 11,
                    ),
                    if (offer!.discountType == 'percent')
                      Icon(
                        Icons.percent,
                        color: cellSelected
                            ? AppColors.white
                            : isDisabled
                            ? AppColors.cherryRed
                            : AppColors.mintGreen,
                        size: 13,
                      )
                    else
                      BodyText(
                        text: 'ريال',
                        textColor: cellSelected
                            ? AppColors.white
                            : isDisabled
                            ? AppColors.cherryRed
                            : AppColors.mintGreen,
                        textAlign: TextAlign.center,
                        fontSize: 11,
                      ),
                  ],
                ),
            ],
          ),
        );
    }
  }
}

enum CellStyleType {
  circle,
  circleWithOffer,
  leftRadius,
  leftRadiusWithOffer,
  rightRadius,
  rightRadiusWithOffer,
  text,
  textWithOffer,
  textInRange,
  textInRangeWithOffer,
  yearRange,
  textYear,
  monthName,
}

extension CustomDecoration on BoxDecoration {
  BoxDecoration convert(CellStyleType cellStyleType) {
    switch (cellStyleType) {
      case CellStyleType.circle:
      case CellStyleType.circleWithOffer:
        return copyWith(shape: BoxShape.circle);
      case CellStyleType.leftRadius:
      case CellStyleType.leftRadiusWithOffer:
        return copyWith(
          borderRadius: const BorderRadius.horizontal(
            left: Radius.circular(50),
          ),
        );
      case CellStyleType.rightRadius:
      case CellStyleType.rightRadiusWithOffer:
        return copyWith(
          borderRadius: const BorderRadius.horizontal(
            right: Radius.circular(50),
          ),
        );
      default:
        return this;
    }
  }
}

