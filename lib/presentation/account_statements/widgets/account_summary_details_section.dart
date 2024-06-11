import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:maktab/core/extension/date_time_extension.dart';
import 'package:maktab/core/helpers/size_helper.dart';

import '../../../data/models/account_summary/account_summary_model.dart';
import '../../../domain/account_summary/account_summary_bloc.dart';
import '../../widgets/section_title.dart';
import '../../widgets/body_text.dart';
import '../../resources/app_colors.dart';

class AccountSummaryDetailsSection extends StatelessWidget {
  final bool noContents;

  const AccountSummaryDetailsSection({super.key, this.noContents = false});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountSummaryBloc, AccountSummaryState>(
      builder: (context, state) {
        if (state is AccountSummarySuccess) {
          return ListView.builder(
            itemCount: state.accountSummaries.accountStatement!.data.length,
            itemBuilder: (context, i) {
              final data = state.accountSummaries.accountStatement!.data[i];
              return Container(
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.softAsh),
                  borderRadius: BorderRadius.circular(7.0.adaptSize),
                ),
                // padding: const EdgeInsets.all(14.0),
                child: SummaryCard(data: data,),
              );
            },
          );
        }
        return const Center(child: BodyText(text: 'لا يوجد بيانات حاليا'));
      },
    );
  }
}

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

class SummaryRow extends StatelessWidget {
  final String title;
  final String text;
  final bool bigRow;
  final Color? textColor;

  const SummaryRow({
    super.key,
    required this.title,
    required this.text,
    this.bigRow = false,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return bigRow
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BodyText(text: title),
              SectionTitle(
                title: text,
                textColor: textColor,
                fontSize: 16,
                overflow: TextOverflow.visible,
              ),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BodyText(text: title),
              SectionTitle(
                title: text,
                textColor: textColor,
                fontSize: 16,
              ),
            ],
          );
  }
}
