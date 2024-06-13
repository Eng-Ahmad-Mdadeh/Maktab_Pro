import 'package:flutter/material.dart';
import 'package:maktab/core/extension/date_time_extension.dart';

import '../../../../../../../../../core/helpers/size_helper.dart';
import '../../../../../../../../../data/models/contract/contract_model.dart';
import '../../../../../../../resources/app_colors.dart';
import '../../../../../../../widgets/text/body_text.dart';
import '../../../../../../../widgets/text/section_title.dart';

class ContractStep1 extends StatelessWidget {
  final ContractModel contract;

  const ContractStep1({super.key, required this.contract});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 37.0.v, right: 20.0.h, left: 20.0.h, bottom: 25.0.v),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(.15),
            offset: const Offset(0, 1),
            blurRadius: 14,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 22.0.h, right: 22.0.h, top: 21.0.v),
            child: const SectionTitle(
              title: "معلومات العقد",
              fontSize: 16.0,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 22.0.h, right: 22.0.h, top: 6.0.v),
            child: const BodyText(
              "معلومات عامة والحالة الفعلية للعقد",
              fontSize: 14.0,
            ),
          ),
          const Divider(
            color: AppColors.softAsh,
          ),
          Padding(
            padding: EdgeInsets.only(left: 21.0.h, right: 21.0.h, top: 20.0.v),
            child: const BodyText(
              "تاريخ البدء",
              fontSize: 15.0,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 21.0.h, right: 21.0.h, top: 8.0.v),
            child: SectionTitle(
              title: contract.contractStartDate?.dayFormatWithLocale('ar')??'',
              fontSize: 14.0,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 21.0.h, right: 21.0.h, top: 28.0.v),
            child: const BodyText(
              "تاريخ الانتهاء",
              fontSize: 15.0,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 21.0.h, right: 21.0.h, top: 8.0.v),
            child: SectionTitle(
              title: contract.contractEndDate?.dayFormatWithLocale('ar')??'',
              textColor: AppColors.cherryRed,
              fontSize: 14.0,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 21.0.h, right: 21.0.h, top: 28.0.v),
            child: GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2 / 1,
                crossAxisSpacing: 60.0.h,
              ),
              shrinkWrap: true,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const BodyText(
                      "مدة العقد",
                      fontSize: 15.0,
                    ),
                    SectionTitle(
                      title: "${contract.durationDaysOpenContract} يوم",
                      fontSize: 14.0,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const BodyText(
                      "دورة سداد الإيجار",
                      fontSize: 15.0,
                    ),
                    // 'Monthly','Quarterly Yearly','Mid Yearly','Yearly'
                    SectionTitle(
                      title: contract.rentPaymentCycle!,
                      fontSize: 14.0,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const BodyText(
                      "نوع الإيجار",
                      fontSize: 15.0,
                    ),
                    SectionTitle(
                      title: contract.typeReservation!,
                      fontSize: 14.0,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const BodyText(
                      "إجمالي قيمة  العقد",
                      fontSize: 15.0,
                    ),
                    SectionTitle(
                      title: '${contract.totalPrice} ريال',
                      fontSize: 14.0,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}