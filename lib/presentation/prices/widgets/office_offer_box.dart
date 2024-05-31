import 'package:flutter/material.dart';
import 'package:maktab/core/helpers/date_formatter_helper.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/data/models/office/office_model.dart';
import 'package:maktab/presentation/prices/widgets/unit_offer_box.dart';
import 'package:maktab/presentation/resources/app_colors.dart';
import 'package:maktab/presentation/widgets/maktab_page_slider.dart';
import 'package:maktab/presentation/widgets/section_title.dart';

class OfficeOfferBox extends StatelessWidget {
  const OfficeOfferBox({super.key, required this.office});

  final Office office;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: AppColors.white,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: AppColors.softAsh),
        borderRadius: BorderRadius.circular(10),
      ),
      clipBehavior: Clip.antiAlias,
      child: ExpansionTile(
        title: Row(
          children: [
            Expanded(
              flex: 2,
              child: SectionTitle(
                title: office.title ?? '',
                textAlign: TextAlign.right,
              ),
            ),
            SizedBox(width: 10.h),
            Expanded(
              child: Text(
                DateFormatterHelper.getFormated(office.createdAt),
                softWrap: true,
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: AppColors.slateGray,
                    ),
              ),
            ),
          ],
        ),
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 15.v),
            child: MaktabPageSlider(
              height: 180.v,
              widgets: office.units.map((unit) => UnitOfferBox(unit: unit)).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
