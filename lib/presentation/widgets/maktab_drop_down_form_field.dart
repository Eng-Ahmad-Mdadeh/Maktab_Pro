// ignore_for_file: depend_on_referenced_packages

import 'package:collection/collection.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:maktab/presentation/resources/app_colors.dart';

class MaktabDropDownFormField extends StatelessWidget {
  const MaktabDropDownFormField({
    super.key,
    required this.items,
    this.title,
    this.idItems,
    this.initialValue,
    this.hint,
    this.fillColor,
    this.icon,
    this.validator,
    this.onChanged,
    this.onSaved,
  });

  final List<String>? idItems;
  final List<String> items;
  final String? title;
  final String? initialValue;
  final Widget? hint;
  final Color? fillColor;
  final Widget? icon;
  final FormFieldValidator<String>? validator;
  final void Function(String?)? onChanged;
  final Function(String?)? onSaved;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2(
      value: (initialValue??'').isNotEmpty ? initialValue : null,
      isDense: true,
      isExpanded: true,
      hint: hint,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      iconStyleData: IconStyleData(
        icon: icon ??
            const Icon(
              Icons.keyboard_arrow_down_sharp,
              color: AppColors.slateGray,
              size: 25,
            ),
        openMenuIcon: const Icon(
          Icons.keyboard_arrow_up_sharp,
          color: AppColors.slateGray,
          size: 25,
        ),
      ),
      items: items
          .mapIndexed(
            (i, item) => DropdownMenuItem(
              value: idItems != null ? idItems![i] : item,
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  item,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ),
          )
          .toList(),
      decoration: (const InputDecoration())
          .applyDefaults(Theme.of(context).inputDecorationTheme)
          .copyWith(
            fillColor: fillColor,
          ),
      validator: validator,
      onChanged: onChanged,
      onSaved: onSaved,
    );
  }
}
