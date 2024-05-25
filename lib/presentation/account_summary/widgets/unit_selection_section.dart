// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/presentation/widgets/maktab_drop_down_form_field.dart';
import 'package:maktab/presentation/widgets/section_title.dart';

class UnitSelectionSection extends StatelessWidget {
  const UnitSelectionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'اختر الوحدة'),
        SizedBox(height: 10.v),
        MaktabDropDownFormField(
          items: const ['شقة', 'محل', 'مستودع'],
          onChanged: (value) {
            // Add your logic here when the value changes
          },
        )
      ],
    );
  }
}
