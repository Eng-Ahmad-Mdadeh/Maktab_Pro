
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:maktab_lessor/core/helpers/date_formatter_helper.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/data/models/office/office_model.dart';
import 'package:maktab_lessor/presentation/resources/app_colors.dart';
import 'package:maktab_lessor/presentation/widgets/body_text.dart';
import 'package:maktab_lessor/presentation/widgets/section_title.dart';

import '../../widgets/confirm_alert_dialog.dart';

class OfficeItem extends StatelessWidget {
  const OfficeItem({
    super.key,
    required this.office,
    this.mode = 'add',
    required this.onTap,
    required this.onDelete,
  });

  final Office office;
  final String mode;
  final Function() onTap;
  final Function() onDelete;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SectionTitle(
                  title: office.title ?? '',
                  textAlign: TextAlign.right,
                ),
                SizedBox(height: 5.v),
                mode == 'add'
                    ? BodyText(text: office.categoryAqar != null ? office.categoryAqar!.arName : '')
                    : BodyText(
                        text: DateFormatterHelper.getFormated(office.createdAt),
                      ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return ConfirmAlertDialog(
                    alertText: 'سوف يتم الحذف',
                    confirmOnPressed: (){
                      context.pop();
                      onDelete();
                    },
                    cancelOnPressed: () => context.pop(),
                  );
                },
              );
            },
            icon: const Icon(
              Icons.delete,
              color: AppColors.cherryRed,
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios,
            color: AppColors.slateGray,
          ),
        ],
      ),
    );
  }
}
