import 'package:flutter/material.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/presentation/resources/app_colors.dart';
import 'package:maktab/presentation/widgets/body_text.dart';

class MoneyTransferItem extends StatelessWidget {
  const MoneyTransferItem({
    super.key,
    required this.title,
    required this.text,
    this.amount = '',
  });

  final String title;
  final String text;
  final String amount;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BodyText(text: title),
        amount.isNotEmpty
            ? RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: amount,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppColors.emeraldTeal,
                          ),
                    ),
                    WidgetSpan(child: SizedBox(width: 5.h)),
                    TextSpan(
                      text: 'ريال',
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppColors.black,
                          ),
                    ),
                  ],
                ),
              )
            : Text(
                text,
                textAlign: TextAlign.center,
                softWrap: true,
                style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w500, color: AppColors.lightBlack),
              ),
      ],
    );
  }
}
