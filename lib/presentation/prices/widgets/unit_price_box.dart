import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/core/router/app_routes.dart';
import 'package:maktab_lessor/data/models/office/office_model.dart';
import 'package:maktab_lessor/presentation/prices/widgets/unit_price_text.dart';
import 'package:maktab_lessor/presentation/resources/app_colors.dart';
import 'package:maktab_lessor/presentation/widgets/body_text.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_image_view.dart';
import 'package:maktab_lessor/presentation/widgets/section_title.dart';

class UnitPriceBox extends StatelessWidget {
  const UnitPriceBox({super.key, required this.unit});

  final Office unit;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SectionTitle(title: unit.title??''),
            InkWell(
              onTap: () => context.pushNamed(AppRoutes.updateUnitPricesScreen,
                  extra: unit),
              child: const BodyText(
                text: 'تعديل',
                textColor: AppColors.mintTeal,
              ),
            ),
          ],
        ),
        SizedBox(height: 20.v),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 100.h,
              height: 100.v,
              decoration: BoxDecoration(
                color: AppColors.palePlatinum,
                borderRadius: BorderRadius.circular(15.v),
                border: Border.all(color: AppColors.slateGray),
              ),
              child: (unit.mainImage??'').isNotEmpty
                  ? MaktabImageView(
                      imagePath: unit.mainImage!,
                      fit: BoxFit.cover,
                      radius: BorderRadius.circular(15.v),
                    )
                  : const SizedBox.shrink(),
            ),
            SizedBox(width: 15.h),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const BodyText(
                    text: 'الأسعار المدعومة',
                    textColor: AppColors.lightBlack,
                  ),
                  SizedBox(height: 10.v),
                  if (unit.prices
                          .firstWhereOrNull((price) => price.typeResId == 1) !=
                      null)
                    UnitPriceText(
                      title: 'بالساعات: ',
                      price: unit.prices
                          .firstWhereOrNull((price) => price.typeResId == 1)!
                          .price,
                    ),
                  if (unit.prices
                          .firstWhereOrNull((price) => price.typeResId == 2) !=
                      null)
                    UnitPriceText(
                      title: 'بالأيام: ',
                      price: unit.prices
                          .firstWhereOrNull((price) => price.typeResId == 2)!
                          .price,
                    ),
                  if (unit.prices
                          .firstWhereOrNull((price) => price.typeResId == 3) !=
                      null)
                    UnitPriceText(
                      title: 'بالأشهر: ',
                      price: unit.prices
                          .firstWhereOrNull((price) => price.typeResId == 3)!
                          .price,
                    ),
                  if (unit.prices
                          .firstWhereOrNull((price) => price.typeResId == 4) !=
                      null)
                    UnitPriceText(
                      title: 'بالسنوات: ',
                      price: unit.prices
                          .firstWhereOrNull((price) => price.typeResId == 4)!
                          .price,
                    ),
                ],
              ),
            ),
            const Align(
              alignment: Alignment.center,
              child: Icon(
                Icons.arrow_forward_ios,
                color: AppColors.slateGray,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
