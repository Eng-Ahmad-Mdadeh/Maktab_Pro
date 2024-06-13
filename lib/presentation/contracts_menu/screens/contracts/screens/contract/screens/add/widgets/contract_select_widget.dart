import 'package:collection/collection.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:maktab/core/helpers/size_helper.dart';

import '../../../../../../../../resources/app_colors.dart';
import '../../../../../../../../widgets/text/body_text.dart';

class ContractSelectWidget<T> extends StatelessWidget {
  final String title;
  final List<T> items;
  final List<String> children;
  final void Function(T?) onChanged;
  final bool req;
  final T? value;

  const ContractSelectWidget({
    super.key,
    required this.title,
    required this.items,
    required this.value,
    required this.children,
    required this.onChanged,
    this.req = true,
  }) : assert(items.length == children.length, "items and children count must be same");

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20.0.v),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BodyText(
            title,
            fontSize: 15.0,
          ),
          DropdownButtonFormField2<T>(
            isDense: true,
            isExpanded: true,
            value: value,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            iconStyleData: const IconStyleData(
              icon: Icon(
                Icons.keyboard_arrow_down_sharp,
                color: AppColors.slateGray,
                size: 25,
              ),
              openMenuIcon: Icon(
                Icons.keyboard_arrow_up_sharp,
                color: AppColors.slateGray,
                size: 25,
              ),
            ),
            items: items
                .mapIndexed(
                  (i,item) => DropdownMenuItem(
                value: item,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    children[i],
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ),
            )
                .toList(),
            validator: req ? (value){
              if(value == null){
                return 'هذا القسم اجباري';
              }
              return null;
            } : null,
            onChanged: onChanged,
          ),

        ],
      ),
    );
  }
}