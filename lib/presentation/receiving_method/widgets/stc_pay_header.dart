import 'package:flutter/material.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/presentation/resources/app_assets.dart';
import 'package:maktab/presentation/resources/app_colors.dart';
import 'package:maktab/presentation/widgets/maktab_image_view.dart';
import 'package:maktab/presentation/widgets/page_title.dart';

class StcPayHeader extends StatelessWidget {
  const StcPayHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Align(
          alignment: Alignment.topLeft,
          child: CloseButton(
            color: AppColors.cherryRed,
          ),
        ),
        SizedBox(height: 20.v),
        const PageTitle(
          title: 'سياسة تحويل المبالغ بواسطة STC Pay',
        ),
        MaktabImageView(
          imagePath: AppAssets.stcPay,
          fit: BoxFit.fill,
        ),
      ],
    );
  }
}
