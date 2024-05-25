// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';

import 'package:maktab/presentation/resources/app_colors.dart';

class DropDownButton extends StatefulWidget {
  const DropDownButton({Key? key}) : super(key: key);

  @override
  State<DropDownButton> createState() => _DropDownButtonState();
}

class _DropDownButtonState extends State<DropDownButton> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.white,
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: DropdownButton<String>(
          value: 'شقة',
          onChanged: (String? newValue) {},
          items: [
            'شقة',
            'غرفة',
            'محل',
            'مكتب',
            'مستودع',
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            );
          }).toList(),
          icon: const Icon(
            Icons.arrow_drop_down,
            color: AppColors.black,
          ),
          elevation: 2,
          underline: Container(
            height: 0,
          ),
          isExpanded: false,
        ),
      ),
    );
  }
}
