import 'package:flutter/material.dart';

import '../../../../../../../../../core/helpers/size_helper.dart';
import '../../../../../../../../data/models/contract/contract_model.dart';
import '../../../../../../../resources/app_colors.dart';
import '../../../../../../../widgets/text/body_text.dart';
import '../../../../../../../widgets/text/section_title.dart';
import '../contract_grid_item1.dart';

class ContractStep4 extends StatelessWidget {
  final ContractModel contract;
  const ContractStep4({super.key, required this.contract});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 37.0.v, right: 20.0.h, left: 20.0.h, bottom: 25.0.v),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(.15),
            offset: const Offset(0, 1),
            blurRadius: 14,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 22.0.h, right: 22.0.h, top: 21.0.v),
            child: const SectionTitle(
              title: "معلومات الدفع بالنسبة للمستأجر",
              fontSize: 16.0,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 22.0.h, right: 22.0.h, top: 6.0.v),
            child: const BodyText(
              "معلومات وطرق الدفع",
              fontSize: 14.0,
            ),
          ),
          const Divider(
            color: AppColors.softAsh,
          ),
          Padding(
            padding: EdgeInsets.only(left: 21.0.h, right: 21.0.h, top: 28.0.v),
            child: GridView(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2 / 1,
                crossAxisSpacing: 60.0.h,
              ),
              shrinkWrap: true,
              children: [
                ContractGridItem1(title: "قيمة العربون المدفوع", value: contract.downPayment),
                // 'Monthly','Quarterly Yearly','Mid Yearly','Yearly'
                ContractGridItem1(title:  "قيمة التأمين المسترد", value: contract.insuranceAmount),
                ContractGridItem1(title: "المبلغ الإجمالي", value: contract.totalPrice),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
