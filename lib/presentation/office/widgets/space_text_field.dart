import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/presentation/widgets/body_text.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_text_form_field.dart';

class SpaceTextField extends StatelessWidget {
  const SpaceTextField({
    super.key,
    required this.controller,
    required this.onChanged
  });

  final TextEditingController controller;
  final Function(String? value) onChanged;

  @override
  Widget build(BuildContext context) {
    return MaktabTextFormField(
      controller: controller,
      title: 'المساحة',
      smallTitle: '(متر مربع)',
      hintText: 'الرجاء كتابة المساحة',
      textInputType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      textFieldFontSize: 17.0,
      suffix: Padding(
        padding: EdgeInsets.only(left: 10.h),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: BodyText(text: 'متر مربع'),
            ),
          ],
        ),
      ),
      validator: (value) {
        if (value!.trim().isEmpty) {
          return 'الرجاء ادخال المساحة';
        } else if (value.trim().length > 7) {
          return 'يجب أن يكون الرقم حقيقي';
        }
        return null;
      },
      onChanged: onChanged,
    );
  }
}
