import 'package:flutter/material.dart';
import 'package:maktab/core/helpers/size_helper.dart';

import '../../../../../../resources/app_colors.dart';
import '../../../../../../widgets/text/body_text.dart';

class ContractStepDot extends StatelessWidget {
  final int step;
  final String title;
  final int currentStep;

  const ContractStepDot(this.step, {super.key, required this.currentStep, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: AppColors.softAsh)),
          padding: EdgeInsets.all(3.0.adaptSize),
          child: Container(
            padding: EdgeInsets.all(15.0.adaptSize),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.softAsh),
              color: currentStep == step ? AppColors.mintGreen : AppColors.gray,
            ),
            child: BodyText(
              "$step",
              textColor: AppColors.white,
            ),
          ),
        ),
        BodyText(
          title,
          fontSize: 9,
        ),
      ],
    );
  }
}