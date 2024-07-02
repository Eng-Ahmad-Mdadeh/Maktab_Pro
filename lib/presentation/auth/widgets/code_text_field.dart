import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';
import 'package:smart_auth/smart_auth.dart';

import '../../../../core/helpers/size_helper.dart';
import '../../resources/app_colors.dart';
import '../../resources/app_text_styles.dart';

class CodeTextField extends StatelessWidget {
  final Function(String) onCompleted;

  const CodeTextField({
    super.key,
    required this.controller,
    required this.onCompleted,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Pinput(
        length: 4,
        controller: controller,
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        // scrollPadding: EdgeInsets.symmetric(horizontal: 20.0.h),
        animationDuration: const Duration(milliseconds: 300),
        onCompleted: onCompleted,
        keyboardType: TextInputType.number,

        // androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsUserConsentApi,
        smsRetriever: L(),
        defaultPinTheme: PinTheme(
          width: 90.0.h,
          height: 90.0.v,
          textStyle: AppTextStyles.titleLarge.copyWith(fontSize: 35.0.fSize),
          decoration: BoxDecoration(
            // color: AppColors.mintGreen,
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(
              width: 1,
              color: AppColors.softAsh,

            ),
          ),
        ),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^\d+')),
        ],
        validator: (value) {
          if (value!.isEmpty) {
            return "الرجاء ادخال الكود المرسل";
          }
          if (value.length < 4) {
            return "الرجاء ادخال كود صحيح";
          }
          return null;
        },
      ),
    );
  }
}

class L implements SmsRetriever{

  final smartAuth = SmartAuth();


  @override
  Future<void> dispose() => smartAuth.removeSmsListener();

  @override
  Future<String?> getSmsCode() async {
    final res = await smartAuth.getSmsCode();
    if (res.succeed) {
      debugPrint('SMS: ${res.code}');
      return res.code;
    } else {
      debugPrint('SMS Failure:');
      return '';
    }
  }

  @override
  bool get listenForMultipleSms => true;

}