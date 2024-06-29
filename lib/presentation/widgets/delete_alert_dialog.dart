// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/presentation/resources/app_colors.dart';
import 'package:maktab_lessor/presentation/widgets/body_text.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_button.dart';
import 'package:maktab_lessor/presentation/widgets/page_title.dart';

class DeleteAlertDialog extends StatelessWidget {
  DeleteAlertDialog({
    super.key,
    required this.alertText,
    required this.confirmOnPressed,
    required this.cancelOnPressed,
    this.isLoading = false,
  });

  final String alertText;
  final Function() confirmOnPressed;
  final Function() cancelOnPressed;
  bool isLoading;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: Icon(
        FontAwesomeIcons.xmark,
        color: AppColors.cherryRed,
        size: 80.fSize,
      ),
      title: const PageTitle(
        title: 'هل أنت متأكد؟',
      ),
      content: BodyText(
        text: alertText,
        textAlign: TextAlign.center,
      ),
      actions: [
        SizedBox(
          height: 60.v,
          child: Row(
            children: [
              Expanded(
                child: MaktabButton(
                  text: 'تأكيد',
                  isLoading: isLoading,
                  isEnabled: !isLoading,
                  backgroundColor: AppColors.cherryRed,
                  onPressed: confirmOnPressed,
                ),
              ),
              SizedBox(width: 10.h),
              Expanded(
                child: MaktabButton(
                  text: 'الغاء',
                  backgroundColor: AppColors.slateGray,
                  onPressed: cancelOnPressed,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
