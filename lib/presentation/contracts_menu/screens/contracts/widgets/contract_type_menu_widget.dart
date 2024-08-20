import 'package:flutter/material.dart';

import '../../../../../../core/helpers/size_helper.dart';
import '../../../../../data/models/contract/contract_model.dart';
import '../../../../resources/app_colors.dart';
import '../../../../widgets/body_text.dart';

class ContractTypeMenuWidget extends StatelessWidget {
  final List<ContractType> contractTypesValue;
  final List<String> contractTypesTitle;
  final Function(ContractType?) onSelected;
  final ContractType value;
  final Color? textColor;

  const ContractTypeMenuWidget({
    super.key,
    required this.contractTypesTitle,
    required this.contractTypesValue,
    required this.onSelected,
    required this.value,
    this.textColor,
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
        child: DropdownButton<ContractType>(
          isExpanded: true,
          icon: Icon(
            Icons.arrow_drop_down,
            color: AppColors.black,
            size: 35.adaptSize,
          ),
          underline: const SizedBox(),
          value: value,
          items: List.generate(contractTypesValue.length, (i) {
            return DropdownMenuItem<ContractType>(
              value: contractTypesValue[i],
              child: BodyText(
                text: contractTypesTitle[i],
                textColor: _getColor(contractTypesValue[i]),
              ),
            );
          }),
          onChanged: onSelected,
        ),
      ),
    );
  }

  Color _getColor(ContractType type) {
    switch(type){
      case ContractType.waiting:
        return AppColors.orangeAccent;
      case ContractType.accepted:
        return AppColors.mintGreen;
      case ContractType.expired:
        return AppColors.deepCrimson;
      case ContractType.canceled:
        return AppColors.cherryRed;
      case ContractType.none:
        return AppColors.black;
    }
  }
}
