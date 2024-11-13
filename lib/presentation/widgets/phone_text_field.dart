
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/presentation/widgets/country_code.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_text_form_field.dart';

import '../resources/app_colors.dart';
import '../resources/app_text_styles.dart';

class PhoneTextfield extends StatelessWidget {
  const PhoneTextfield({
    super.key,
    required this.controller,
    this.onChanged,
    this.onTapOutside,
    this.titleSize,
    this.textFieldFontSize,
    this.hintSize,
    this.countryCodeSize,
  });

  final TextEditingController controller;
  final Function(String)? onChanged;
  final Function()? onTapOutside;
  final double? titleSize;
  final double? textFieldFontSize;
  final double? hintSize;
  final double? countryCodeSize;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: MaktabTextFormField(
        title: "رقم الهاتف المحمول",
        titleSize: titleSize ?? 19.0,
        controller: controller,
        textAlign: TextAlign.left,
        textInputType: TextInputType.phone,
        hintText: '5xxxxxx',
        textFieldFontSize: textFieldFontSize ?? 19.0.fSize,
        hintStyle: AppTextStyles.bodyMediun.copyWith(
          fontSize: hintSize ?? 19.0.fSize,
          color: AppColors.black.withOpacity(0.5),
        ),
        // textStyle: AppTextStyles.bodyMedium.copyWith(fontSize: 12.0.fSize),
        suffix: CountryCode(size: countryCodeSize),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^\d+')),
          LengthLimitingTextInputFormatter(9),
        ],
        onChanged: onChanged,
        onTapOutside: onTapOutside,
        validator: (value) {
          if (value!.isEmpty) {
            return "الرجاء ادخال رقم الموبايل";
          }
          if (value.length < 9) {
            return "الرجاء ادخال رقم موبايل صحيح";
          }
          if (!value.trim().startsWith('5')) {
            return "الرجاء ادخال رقم موبايل يبدأ ب 5";
          }
          return null;
        },
      ),
    );
  }
}
