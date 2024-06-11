// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/presentation/resources/app_colors.dart';
import 'package:maktab/presentation/widgets/maktab_button.dart';

import 'section_title.dart';

class QuantitySelector extends StatelessWidget {
  const QuantitySelector({
    super.key,
    required this.title,
    required this.quantity,
    this.isEnabled = true,
    required this.increaseOnPressed,
    required this.decreaseOnPressed,
  });

  final Widget title;
  final String quantity;
  final bool isEnabled;
  final Function() increaseOnPressed;
  final Function() decreaseOnPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.v),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          title,
          SizedBox(height: 10.v),
          if (isEnabled)
            Container(
              decoration: BoxDecoration(
                color: AppColors.palePlatinum,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: MaktabButton(
                      onPressed: isEnabled ? increaseOnPressed : null,
                      backgroundColor: AppColors.palePlatinum,
                      icon: const Icon(
                        FontAwesomeIcons.plus,
                        color: AppColors.lightBlack,
                        size: 18,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: EdgeInsets.only(top: 10.v),
                      child: SectionTitle(
                        title:
                        quantity,
                        textAlign: TextAlign.center,textColor: AppColors.lightBlack

                      ),
                    ),
                  ),
                  Expanded(
                    child: MaktabButton(
                      onPressed: isEnabled ? decreaseOnPressed : null,
                      backgroundColor: AppColors.palePlatinum,
                      icon: const Icon(
                        FontAwesomeIcons.minus,
                        color: AppColors.lightBlack,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ).animate().fade(),
        ],
      ),
    );
  }
}
