
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/data/models/evaluation/evaluation_model.dart';
import 'package:maktab_lessor/domain/home/home_bloc.dart';
import 'package:maktab_lessor/presentation/resources/app_colors.dart';
import 'package:maktab_lessor/presentation/widgets/body_text.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_ratingbar.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_rich_text.dart';
import 'package:maktab_lessor/presentation/widgets/section_title.dart';

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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: SectionTitle(
                                    title: evaluation!.userOrdinary?.userName ?? '',
                                    textColor: AppColors.lightBlack,
                                  ),
                                ),
                                if (evaluation!.comment.length > 10)
                                  Expanded(
                                    child: MaktabRichText(
                                      texts: [
                                        MaktabRichTextModel(
                                            text: evaluation!.comment.substring(0, 10), fontWeight: FontWeight.normal),
                                        MaktabRichTextModel(text: "...", fontWeight: FontWeight.normal),
                                        MaktabRichTextModel(
                                            text: "المزيد",
                                            color: AppColors.mintGreen,
                                            fontWeight: FontWeight.normal,
                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(10.0.adaptSize)),
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
                            ),
                            childrenPadding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 15.v),
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const BodyText(
                                    text: 'الوحدة: ',
                                    textColor: AppColors.lightBlack,
                                  ),
                                  Expanded(
                                    child: BodyText(
                                      text: evaluation?.unit?.title ?? '',
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.v),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const BodyText(
                                    text: 'الهاتف: ',
                                    textColor: AppColors.lightBlack,
                                  ),
                                  Expanded(
                                    child: BodyText(text: '0${evaluation?.userOrdinary?.phone ?? 'لايوجد'}'),
                                  ),
                                ],
                              ),
                            ],
                          ),
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
