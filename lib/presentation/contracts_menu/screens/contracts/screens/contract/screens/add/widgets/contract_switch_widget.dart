import 'package:flutter/material.dart';

import '../../../../../../../../resources/app_colors.dart';
import '../../../../../../../../widgets/maktab_switch.dart';
import '../../../../../../../../widgets/text/body_text.dart';

class ContractSwitchWidget extends StatelessWidget {
  final String title;
  final Function(bool) onSwitch;
  final bool value;

  const ContractSwitchWidget({
    super.key,
    required this.title,
    required this.onSwitch,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BodyText(title),
        MaktabSwitch(
          value: value,
          activeColor: AppColors.mintGreen,
          onChanged: onSwitch,
        ),
      ],
    );
  }
}