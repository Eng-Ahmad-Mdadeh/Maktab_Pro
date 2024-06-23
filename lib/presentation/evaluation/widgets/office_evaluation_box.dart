import 'package:flutter/material.dart';
import 'package:maktab/core/helpers/date_formatter_helper.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/data/models/office/office_model.dart';
import 'package:maktab/presentation/resources/app_colors.dart';
import 'package:maktab/presentation/widgets/body_text.dart';
import 'package:maktab/presentation/widgets/section_title.dart';

class OfficeEvaluationBox extends StatelessWidget {
  const OfficeEvaluationBox({super.key, required this.office});

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
          ],
        ),
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 15.v),
            child: Column(
              children: office.evaluations
                  .map((evaluation) => Container(
                        width: SizeHelper.width,
                        margin: EdgeInsets.only(bottom: 15.v),
                        padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 15.v),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.softAsh),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SectionTitle(title: '${evaluation.id}#'),
                            SizedBox(height: 20.v),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const BodyText(
                                  text: 'التقييم: ',
                                  textColor: AppColors.lightBlack,
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      BodyText(text: evaluation.rate.toString()),
                                      const Padding(
                                        padding: EdgeInsets.only(bottom: 4.0),
                                        child: Icon(
                                          Icons.star,
                                          color: AppColors.yellow,
                                        ),
                                      ),
                                    ],
                                  ),
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
                                    text: DateFormatterHelper.getFormated(evaluation.createdAt),
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
                                    text: evaluation.comment,
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
