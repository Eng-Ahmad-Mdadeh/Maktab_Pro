import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maktab/core/helpers/size_helper.dart';

import '../../../../../../../../resources/app_colors.dart';
import '../../../../../../../../widgets/maktab_text_form_field.dart';
import '../../../../../../../../widgets/body_text.dart';

class ContractInputWidget extends StatelessWidget {
  final String title;
  final TextEditingController? controller;
  final String? hint;
  final int? maxLines;
  final void Function(String?) onChanged;
  final void Function(DateTime?)? onDatePressed;
  final bool req;
  final bool disabled;
  final bool numberMode;
  final bool phoneMode;
  final bool birthDate;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? suffix;
  final Widget? prefix;
  final String? Function(String?)? validator;

  const ContractInputWidget({
    super.key,
    required this.title,
    required this.onChanged,
    required this.controller,
    this.hint,
    this.onDatePressed,
    this.maxLines,
    this.inputFormatters,
    this.req = true,
    this.disabled = false,
    this.numberMode = false,
    this.phoneMode = false,
    this.birthDate = false,
    this.suffix,
    this.prefix,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20.0.v),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BodyText(text:
            title,
            fontSize: 15.0,
          ),
          MaktabTextFormField(
            controller: controller,
            hintText: hint,
            maxLines: maxLines,
            onChanged: onChanged,
            // autofocus: true,
            inputFormatters: inputFormatters,
            unFocusWhenTabOutside: false,
            // initialValue: initialValue,
            // disabled: disabled,
            readOnly: disabled,
            textInputType: numberMode ? TextInputType.number : phoneMode ? TextInputType.phone : null,
            suffix: suffix ?? (onDatePressed != null
                ? IconButton(
                    onPressed: () async {
                      final firstDate = birthDate ? DateTime.now().subtract(const Duration(days: 90 * 360)) : DateTime.now().subtract(const Duration(days: 360 * 100));
                      final lastDate = birthDate ? DateTime.now().subtract(const Duration(days: 18 * 360)) : DateTime.now().add(const Duration(days: 360 * 100));
                      final date = await showDatePicker(
                        context: context,
                        initialDate: birthDate ? lastDate : DateTime.now(),
                        firstDate: firstDate,
                        lastDate: lastDate,
                      );
                      onDatePressed?.call(date);
                    },
                    highlightColor: AppColors.mintGreen.withOpacity(0.1),
                    icon: const Icon(
                      Icons.date_range,
                      color: AppColors.mintGreen,
                    ),
                  )
                : null),
            prefix: prefix,
            validator: req ? (value){
              if((value??'').isEmpty){
                return 'هذا القسم اجباري';
              }
              return validator?.call(value);
            } : null,
          ),
        ],
      ),
    );
  }
}
