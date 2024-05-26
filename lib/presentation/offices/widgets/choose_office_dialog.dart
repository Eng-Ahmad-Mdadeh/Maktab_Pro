import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/presentation/resources/app_colors.dart';
import 'package:maktab/presentation/widgets/page_title.dart';

class ChooseOfficeDialog extends StatelessWidget {
  const ChooseOfficeDialog({
    super.key,
    required this.title,
    required this.officesList,
  });

  final String title;
  final Widget officesList;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: EdgeInsets.symmetric(vertical: 5.v, horizontal: 15.h),
      title: SizedBox(
        height: 200,
        width: 100,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: PageTitle(title: title)),
                IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () => context.pop(),
                  icon: const Icon(
                    Icons.close,
                    color: AppColors.lightBlack,
                  ),
                ),
              ],
            ),
            const Divider(color: AppColors.softAsh),
          ],
        ),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 5.v),
      content: SizedBox(
        height: 300,
        width: 300,
        child: officesList,
      ),
    );
  }
}
