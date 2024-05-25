// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maktab/presentation/widgets/country_code.dart';
import 'package:maktab/presentation/widgets/maktab_text_form_field.dart';

class PhoneTextfield extends StatelessWidget {
  const PhoneTextfield({super.key, required this.controller, this.onChanged});

  final TextEditingController controller;
  final Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return MaktabTextFormField(
      title: 'رقم الهاتف المحمول',
      controller: controller,
      textAlign: TextAlign.left,
      textInputType: TextInputType.phone,
      hintText: '5xxxxxx',
      suffix: const CountryCode(),
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(9),
      ],
      validator: (value) {
        if (value!.trim().isEmpty) {
          return 'الرجاء ادخال رقم الموبايل';
        }
        if (value.trim().length < 9) {
          return 'الرجاء ادخال رقم موبايل صحيح';
        }
        if (!value.trim().startsWith('5')) {
          return 'الرجاء ادخال رقم موبايل يبدأ ب 5';
        }
        return null;
      },
      onChanged: onChanged,
    );
  }
}
