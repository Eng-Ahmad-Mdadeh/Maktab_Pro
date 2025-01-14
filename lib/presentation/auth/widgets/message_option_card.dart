
import 'package:flutter/material.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/presentation/auth/widgets/option_button.dart';

import '../../resources/app_colors.dart';
import '../../widgets/section_title.dart';

class MessageOptionsCard extends StatelessWidget {
  const MessageOptionsCard({
    super.key,
    required this.buttons,
    required this.title,
    this.onClose,
  });

  final List<OptionButton> buttons;
  final String title;
  final Function()? onClose;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 320.v,
      child: Card(
        elevation: 5,
        color: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.v),
        ),
        margin: EdgeInsets.symmetric(vertical: 5.v),
        child: Padding(
          padding: EdgeInsets.all(10.adaptSize),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: onClose,
                    icon: Container(
                      padding: EdgeInsets.all(7.0.adaptSize),
                      decoration: const BoxDecoration(
                        color: AppColors.softAsh,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close,
                        color: AppColors.white,
                      ),
                    ),
                  )
                ],
              ),
              SectionTitle(title: title),
              SizedBox(
                height: 10.0.v,
              ),
              ...buttons
            ],
          ),
        ),
      ),
    );
  }
}
