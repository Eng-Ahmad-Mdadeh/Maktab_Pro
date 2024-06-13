import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:maktab/core/helpers/size_helper.dart';

import '../../../../../../../../resources/app_colors.dart';
import '../../../../../../../../widgets/maktab_button.dart';
import '../../../../../../../../widgets/body_text.dart';
import 'contract_input_widget.dart';

class ContractGroupButton<T extends Enum> extends StatelessWidget {
  final String title;
  final Function(T) onButtonSelected;
  final List<T> items;
  final List<String> itemsText;
  final T value;
  final void Function(String?)? onTextChanged;
  final TextEditingController? controller;

  const ContractGroupButton({
    super.key,
    required this.title,
    required this.onButtonSelected,
    required this.items,
    required this.itemsText,
    required this.value,
    this.controller,
    this.onTextChanged,
  }) : assert(itemsText.length == items.length, "itemsText length and items length must be equal");

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 14.0.v),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BodyText(text: title),
          SizedBox(
            height: 7.0.v,
          ),
          Wrap(
            children: items
                .mapIndexed((i, e) => MaktabButton(
                      width: SizeHelper.width * .45,
                      // height: 50,
                      borderRadius: BorderRadius.zero,
                      text: itemsText[i],
                      onPressed: () => onButtonSelected(e),
                      backgroundColor: value == e ? AppColors.mintGreen : AppColors.white,
                      color: value == e ? AppColors.white : AppColors.black,
                      bold: false,
                      fontSize: 15.0,
                      shadow: BoxShadow(
                        color: AppColors.black.withOpacity(0.1),
                        spreadRadius: 3,
                        blurRadius: 9,
                      ),
                    ))
                .toList(),
          ),
          if (onTextChanged != null)
            if (items.length >= 2)
              if (value == items[1])
                ContractInputWidget(
                  controller: controller,
                  title: "المبلغ",
                  hint: "0 ريال",
                  numberMode: true,
                  onChanged: onTextChanged!,
                  req: false,
                ),
        ],
      ),
    );
  }
}
