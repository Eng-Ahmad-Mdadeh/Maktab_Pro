import 'package:flutter/material.dart';
import 'package:maktab/core/helpers/date_formatter_helper.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/data/models/financial_transactions/financial_transfer.dart';
import 'package:maktab/presentation/resources/app_colors.dart';
import 'package:maktab/presentation/widgets/body_text.dart';
import 'package:maktab/presentation/widgets/maktab_rich_text.dart';
import 'package:maktab/presentation/widgets/section_title.dart';

class FinancialTransferListItem extends StatelessWidget {
  const FinancialTransferListItem({super.key, required this.transfer});

  final FinancialTransfer transfer;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: AppColors.white,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: AppColors.softAsh),
        borderRadius: BorderRadius.circular(10.adaptSize),
      ),
      clipBehavior: Clip.antiAlias,
      child: ExpansionTile(
        tilePadding: EdgeInsets.symmetric(vertical: 0.v, horizontal: 10.h),
        title: Row(
          children: [
            Expanded(
              child: SectionTitle(
                title: '#${transfer.id}',
                textColor: AppColors.lightBlack,
              ),
            ),
            Expanded(
              child: MaktabRichText(
                texts: [
                  MaktabRichTextModel(
                    text: transfer.netAmountTransferred,
                    color: AppColors.mintGreen,
                    fontWeight: FontWeight.bold,
                  ),
                  MaktabRichTextModel(
                    text: ' ريال',
                    color: AppColors.lightBlack,
                    fontWeight: FontWeight.normal,
                  ),
                ],
              ),
            ),
            Expanded(
              child: BodyText(
                text: DateFormatterHelper.getFormated(transfer.createdAt),
                textColor: AppColors.lightBlack,
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
        childrenPadding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 15.v),
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const BodyText(
                text: 'طريقة التحويل: ',
                textColor: AppColors.lightBlack,
              ),
              Expanded(
                child: BodyText(text: transfer.transferMethod),
              ),
            ],
          ),
          SizedBox(height: 10.v),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const BodyText(
                text: 'المبلغ المحول: ',
                textColor: AppColors.lightBlack,
              ),
              Expanded(
                child: BodyText(
                  text: '${transfer.netAmountTransferred} ريال',
                  textColor: AppColors.mintTeal,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.v),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const BodyText(
                text: 'المبلغ المتبقي: ',
                textColor: AppColors.lightBlack,
              ),
              Expanded(
                child: BodyText(
                  text: '${transfer.remainingAmount} ريال',
                  textColor: AppColors.orangeAccent,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
