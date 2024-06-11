// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/data/models/evaluation/evaluation_model.dart';
import 'package:maktab/domain/home/home_bloc.dart';
import 'package:maktab/presentation/resources/app_colors.dart';
import 'package:maktab/presentation/widgets/body_text.dart';
import 'package:maktab/presentation/widgets/maktab_ratingbar.dart';
import 'package:maktab/presentation/widgets/maktab_rich_text.dart';
import 'package:maktab/presentation/widgets/section_title.dart';

class LatestEvaluationsSection extends StatelessWidget {
  LatestEvaluationsSection({super.key});

  Evaluation? evaluation;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        width: SizeHelper.width,
        padding: EdgeInsets.symmetric(vertical: 20.v, horizontal: 20.h),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Row(
                children: [
                  Icon(
                    Icons.star_border,
                    color: AppColors.softAsh,
                    size: 35.adaptSize,
                  ),
                  SizedBox(width: 10.h),
                  const SectionTitle(title: 'آخر التقييمات'),
                ],
              ),
            ),
            SizedBox(height: 10.v),
            context.read<HomeBloc>().state.statistics != null &&
                    context.read<HomeBloc>().state.statistics!.evaluations.isNotEmpty
                ? ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: 200.v),
                    child: ListView.separated(
                      primary: false,
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(vertical: 10.v),
                      itemBuilder: (context, index) {
                        evaluation = context.read<HomeBloc>().state.statistics!.evaluations[index];
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(width: 8.h),
                            Expanded(
                              child: SectionTitle(
                                title: evaluation!.userOrdinary?.userName ?? '',
                              ),
                            ),
                            if (evaluation!.comment.length > 10)
                              Expanded(
                                child: MaktabRichText(
                                  texts: [
                                    MaktabRichTextModel(
                                      text: evaluation!.comment.substring(0, 10),
                                    ),
                                    MaktabRichTextModel(
                                      text: "...",
                                    ),
                                    MaktabRichTextModel(
                                        text: "المزيد",
                                        color: AppColors.mintGreen,
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                content: BodyText(
                                                  text: evaluation!.comment,
                                                  textAlign: TextAlign.center,
                                                ),
                                              );
                                            },
                                          );
                                        }),
                                  ],
                                ),
                              )
                            else
                              Expanded(child: BodyText(text: evaluation!.comment)),
                            MaktabRatingBar(rate: evaluation!.rate.toDouble()),
                          ],
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(height: 5.v),
                      itemCount: context.read<HomeBloc>().state.statistics!.evaluations.length,
                    ))
                : Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.v),
                      child: const BodyText(text: 'لا يوجد بيانات'),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
