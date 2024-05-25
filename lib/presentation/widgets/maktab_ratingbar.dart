import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/presentation/resources/app_colors.dart';

class MaktabRatingBar extends StatelessWidget {
  const MaktabRatingBar({super.key, required this.rate});

  final double rate;

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}
