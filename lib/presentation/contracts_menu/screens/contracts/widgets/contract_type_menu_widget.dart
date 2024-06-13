import 'package:flutter/material.dart';

import '../../../../../../core/helpers/size_helper.dart';
import '../../../../resources/app_colors.dart';
import '../../../../widgets/text/body_text.dart';

class ContractTypeMenuWidget extends StatelessWidget {
  final List<String> contractTypesValue;
  final List<String> contractTypesTitle;
  final Function(String?) onSelected;
  final String value;

  const ContractTypeMenuWidget({
    super.key,
    required this.contractTypesTitle,
    required this.contractTypesValue,
    required this.onSelected,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(.11),
            spreadRadius: 1,
            blurRadius: 14,
            offset: const Offset(0, 1),
          )
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.h),
        child: DropdownButton<String>(
          isExpanded: true,
          icon: Icon(
            Icons.arrow_drop_down,
            color: AppColors.black,
            size: 35.adaptSize,
          ),
          underline: const SizedBox(),
          value: value,
          items: List.generate(contractTypesValue.length, (i) {
            return DropdownMenuItem<String>(
              value: contractTypesValue[i],
              child: BodyText(contractTypesTitle[i]),
            );
          }),
          onChanged: onSelected,
        ),
      ),
    );
  }
}
