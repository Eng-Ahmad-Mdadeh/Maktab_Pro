import 'package:flutter/material.dart';
import 'package:maktab/core/extension/num_extension.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/presentation/resources/app_colors.dart';
import 'package:maktab/presentation/widgets/section_title.dart';

class MaktabRatingBar extends StatelessWidget {
  const MaktabRatingBar({super.key, required this.rate});

  final double rate;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 3.0.v),
          child: SectionTitle(title: "(${rate.toStringAsFixedWithCheck(1)})"),
        ),
        const Icon(
          Icons.star,
          color: AppColors.yellow,
        ),
      ],
    );
  }
}
/*
Column(
      children: [
        RatingBar(
          initialRating: rate,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemSize: 25.adaptSize,
          ratingWidget: RatingWidget(
            full: const Icon(
              Icons.star,
              color: AppColors.yellow,
            ),
            half: const Icon(
              Icons.star_half,
              color: AppColors.yellow,
            ),
            empty: const Icon(
              Icons.star_border,
              color: AppColors.softAsh,
            ),
          ),
          onRatingUpdate: (rating) {},
        ),
      ],
    )
 */
