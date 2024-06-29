import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_text_form_field.dart';

class LicenseTextFields extends StatelessWidget {
  const LicenseTextFields({
    super.key,
    required this.licenseLinkController,
    required this.licenseNumberController,
  });

  final TextEditingController licenseLinkController;
  final TextEditingController licenseNumberController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20.v),
        MaktabTextFormField(
          title: 'اضافة رابط الرخصة*',
          controller: licenseLinkController,
          textInputType: TextInputType.text,
          hintText: 'أدخل رابط الرخصة',
          validator: (value) {
            if (value!.isEmpty) {
              return 'الرجاء ادخال رابط الرخصة';
            }
            return null;
          },
        ),
        SizedBox(height: 20.v),
        MaktabTextFormField(
          title: 'اضافة رقم الرخصة*',
          controller: licenseNumberController,
          textInputType: TextInputType.text,
          hintText: 'أدخل رقم الرخصة',
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
            LengthLimitingTextInputFormatter(11),
          ],
          validator: (value) {
            if (value!.isEmpty) {
              return 'الرجاء ادخال رقم الرخصة';
            }
            if (value.length < 7) {
              return 'الرجاء ادخال رقم الرخصة صحيح';
            }
            return null;
          },
        ),
      ],
    );
  }
}
