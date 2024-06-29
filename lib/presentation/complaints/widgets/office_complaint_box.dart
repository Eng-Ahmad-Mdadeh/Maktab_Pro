import 'package:flutter/material.dart';
import 'package:maktab_lessor/core/helpers/date_formatter_helper.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/data/models/office/office_model.dart';
import 'package:maktab_lessor/presentation/resources/app_colors.dart';
import 'package:maktab_lessor/presentation/widgets/body_text.dart';
import 'package:maktab_lessor/presentation/widgets/section_title.dart';

class OfficeComplaintBox extends StatelessWidget {
  const OfficeComplaintBox({super.key, required this.office});

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
                title: office.title??'',
                textAlign: TextAlign.right,
              ),
            ),
            // SizedBox(width: 10.h),
            // Expanded(
            //   child: Text(
            //     DateFormatterHelper.getFormated(office.createdAt),
            //     softWrap: true,
            //     style: Theme.of(context).textTheme.titleSmall!.copyWith(
            //           color: AppColors.slateGray,
            //         ),
            //   ),
            // ),
          ],
        ),
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 15.v),
            child: Column(
              children: office.complaints
                  .map((complaint) => Container(
                        width: SizeHelper.width,
                        margin: EdgeInsets.only(bottom: 15.v),
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.h, vertical: 15.v),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.softAsh),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SectionTitle(title: '${complaint.id}#'),
                            SizedBox(height: 20.v),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const BodyText(
                                  text: 'السبب: ',
                                  textColor: AppColors.lightBlack,
                                ),
                                Expanded(
                                  child: BodyText(text: complaint.reason??''),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.v),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const BodyText(
                                  text: 'التاريخ: ',
                                  textColor: AppColors.lightBlack,
                                ),
                                Expanded(
                                  child: BodyText(
                                    text: DateFormatterHelper.getFormated(
                                        complaint.createdAt),
                                  ),
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
                                    text: complaint.text??'',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
