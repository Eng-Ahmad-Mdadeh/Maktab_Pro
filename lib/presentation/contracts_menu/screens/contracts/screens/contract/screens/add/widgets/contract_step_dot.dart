import 'package:flutter/material.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';

import '../../../../../../../../resources/app_colors.dart';
import '../../../../../../../../widgets/body_text.dart';

class ContractStepDot extends StatelessWidget {
  final int step;
  final String title;
  final int currentStep;
  final bool isCompletedStep;

  const ContractStepDot(
    this.step, {
    super.key,
    required this.currentStep,
    required this.title,
    this.isCompletedStep = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: AppColors.softAsh)),
          padding: const EdgeInsets.all(3),
          child: Container(
            padding: EdgeInsets.all(isCompletedStep ? 11.0.adaptSize : 15.0.adaptSize),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.softAsh),
              color: currentStep == step ? AppColors.mintGreen : AppColors.gray,
            ),
            child: isCompletedStep
                ? Icon(
                    Icons.check,
              size: 18.0.adaptSize,
                  )
                : BodyText(
                 text: "$step",
                    textColor: AppColors.white,
                  ),
          ),
        ),
        BodyText(
          text: title,
          fontSize: 9,
        ),
      ],
    );
  }
}
