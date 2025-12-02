import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/core/router/app_routes.dart';
import 'package:maktab_lessor/domain/profile/profile_bloc.dart';
import 'package:maktab_lessor/presentation/offices/widgets/required_info_item.dart';
import 'package:maktab_lessor/presentation/resources/app_colors.dart';
import 'package:maktab_lessor/presentation/widgets/body_text.dart';

import 'package:maktab_lessor/presentation/widgets/page_title.dart';

class RequiredInfoDialog extends StatelessWidget {
  const RequiredInfoDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: EdgeInsets.symmetric(vertical: 5.v, horizontal: 15.h),
      title: Column(
        children: [
          Row(
            children: [
              const Expanded(
                child: PageTitle(
                  title: 'عذراً!',
                  textAlign: TextAlign.right,
                ),
              ),
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
      contentPadding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 5.v),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const BodyText(text: 'الرجاء التأكد من إضافة المعلومات الآتية:'),
          if (context.read<ProfileBloc>().state.user != null && !context.read<ProfileBloc>().state.user!.isNafath)
            RequiredInfoItem(
              title: 'توثيق الحساب بالنفاذ الوطني',
              onTap: () {
                context.pop();
                context.pushNamed(AppRoutes.nafazScreen);
              },
            ),
        ],
      ),
      actionsPadding: EdgeInsets.symmetric(vertical: 20.v, horizontal: 70.h),
    );
  }
}
