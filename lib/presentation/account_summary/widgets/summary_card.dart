import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:maktab_lessor/core/extension/date_time_extension.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';

import '../../../data/models/account_summary/account_summary_model.dart';
import '../../resources/app_colors.dart';
import '../../widgets/body_text.dart';
import '../../widgets/section_title.dart';
import 'summary_row.dart';

class SummaryCard extends StatelessWidget {
  final Datum data;

  const SummaryCard({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      tilePadding: EdgeInsets.symmetric(vertical: 7.0.v, horizontal: 10.0.h),
      childrenPadding: const EdgeInsets.all(14.0),
      title: SummaryRow(
        title: data.nameTenant??'',
        text: data.paid??'',
        textColor: AppColors.mintGreen,
      ),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SectionTitle(
            title: data.updatedAt!.dayFormatWithLocale('ar'),
            fontSize: 16,
          ),
          const BodyText(text: "ريال")
        ],
      ),
      leading: const Icon(FontAwesomeIcons.circleDot),
      children: [
        SummaryRow(title: "اسم المستأجر", text: data.nameTenant??''),
        SummaryRow(title: "رقم الجوال", text: data.phoneTenant??''),
        SummaryRow(title: "التاريخ", text: data.createdAt!.dayFormatWithLocale('ar')),
        SummaryRow(title: "المدفوع", text: data.paid??''),
        SummaryRow(title: "المتبقي", text: data.remaining??''),
        SummaryRow(title: "عمولة مكتب (10%)", text: data.commissionValueLessor??''),
        SummaryRow(bigRow: true, title: "البيان", text: data.description??''),
      ],
    );
  }
}