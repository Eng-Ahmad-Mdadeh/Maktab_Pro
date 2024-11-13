import 'package:flutter/material.dart';
import 'package:maktab_lessor/presentation/resources/app_colors.dart';
import 'package:maktab_lessor/presentation/widgets/section_title.dart';

class MaktabRadioListTile<T> extends StatelessWidget {
  MaktabRadioListTile({
    super.key,
    required this.title,
    required this.value,
    required this.groupValue,
    this.onChanged,
  });

  final String title;
  final T value;
  final T groupValue;
  void Function(T?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Transform.scale(
          scale: 1.2,
          child: Radio<T>(
            value: value,
            fillColor:
                WidgetStateColor.resolveWith((states) => AppColors.mintTeal),
            activeColor: AppColors.mintTeal,
            groupValue: groupValue,
            onChanged: onChanged,
          ),
        ),
        SectionTitle(
          title: title,
          textColor: AppColors.lightBlack,
          textFontWeight: FontWeight.w500,
        ),
      ],
    );
  }
}
