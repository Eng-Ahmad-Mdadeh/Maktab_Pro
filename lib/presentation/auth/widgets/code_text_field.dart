// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/presentation/resources/app_colors.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class CodeTextField extends StatelessWidget {
  const CodeTextField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.v),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: PinCodeTextField(
          length: 4,
          appContext: context,
          controller: controller,
          enableActiveFill: true,
          animationType: AnimationType.fade,
          animationDuration: const Duration(milliseconds: 300),
          pinTheme: PinTheme(
            fieldWidth: 50,
            borderRadius: BorderRadius.circular(15),
            shape: PinCodeFieldShape.box,
            activeFillColor: AppColors.softAsh,
            inactiveFillColor: AppColors.softAsh,
            selectedFillColor: AppColors.softAsh,
            selectedColor: AppColors.softAsh,
            activeColor: AppColors.softAsh,
            errorBorderColor: AppColors.softAsh,
            inactiveBorderWidth: 0,
            errorBorderWidth: 0,
            disabledBorderWidth: 0,
          ),
          boxShadows: const [
            BoxShadow(
              color: AppColors.softAsh,
              blurRadius: 1.0,
              spreadRadius: 1.0,
            ),
          ],
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d+')),
          ],
          validator: (value) {
            if (value!.isEmpty) {
              return 'الرجاء ادخال الكود المرسل';
            }
            if (value.length < 4) {
              return 'الرجاء ادخال كود صحيح';
            }
            return null;
          },
        ),
      ),
    );
  }
}
