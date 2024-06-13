import 'package:flutter/material.dart';
import 'package:maktab/core/helpers/date_formatter_helper.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/data/models/complaint/complaint_model.dart';
import 'package:maktab/presentation/resources/app_colors.dart';
import 'package:maktab/presentation/widgets/body_text.dart';


class ComplaintListItem extends StatelessWidget {
  const ComplaintListItem({super.key, required this.complaint});

  final Complaint complaint;

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
              child: BodyText(
                text: '#${complaint.id}',
                textColor: AppColors.lightBlack,
              ),
            ),
            Expanded(child: BodyText(text: complaint.reason)),
            Expanded(
              child: BodyText(
                text: DateFormatterHelper.getFormated(complaint.createdAt),
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
                text: 'السبب: ',
                textColor: AppColors.lightBlack,
              ),
              Expanded(
                child: BodyText(text: complaint.reason),
              ),
            ],
          ),
          SizedBox(height: 10.v),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const BodyText(
                text: 'النص: ',
                textColor: AppColors.lightBlack,
              ),
              Expanded(
                child: BodyText(
                  text: complaint.text,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
