import 'package:flutter/material.dart';
import 'package:maktab_lessor/core/extension/date_time_extension.dart';

import '../../../../../../../../../core/helpers/size_helper.dart';
import '../../../../../../../../data/models/contract/contract_model.dart';
import '../../../../../../../resources/app_colors.dart';
import '../../../../../../../widgets/body_text.dart';
import '../../../../../../../widgets/section_title.dart';
import '../contract_grid_item1.dart';

class ContractStep3 extends StatelessWidget {
  final ContractModel contract;

  const ContractStep3({super.key, required this.contract});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 37.0.v, right: 20.0.h, left: 20.0.h),
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
                    title: "معلومات المؤجر",
                    fontSize: 16.0,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 22.0.h, right: 22.0.h, top: 6.0.v),
                  child: const BodyText(
                    text: "معلومات عامة عن المؤجر",
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
                      ContractGridItem1(title: "اسم المؤجر", value: contract.lessorFullName),
                      // 'Monthly','Quarterly Yearly','Mid Yearly','Yearly'
                      ContractGridItem1(title: "رقم الهوية", value: contract.lessorIdentityNum),
                      ContractGridItem1(title: "نوع الهوية", value: contract.lessorIdentityType),
                      ContractGridItem1(title: "تاريخ الميلاد", value: contract.lessorDateBirth?.toIso8601String().split('T').first),
                      ContractGridItem1(title: "الجنسية", value: contract.lessorNationality),
                      ContractGridItem1(title: "رقم الهاتف المحمول", value: contract.lessorPhone),
                      ContractGridItem1(title: "العنوان", value: contract.lessorAddress),
                      ContractGridItem1(title: "نوع الصك", value: contract.lessorRoyalDeedType),
                      ContractGridItem1(title: "رقم الصك", value: contract.lessorRoyalDeedNumber),
                      ContractGridItem1(title: "رقم الإبيان", value: contract.lessorIban),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 37.0.v, right: 20.0.h, left: 20.0.h),
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
                    title: "معلومات المستأجر",
                    fontSize: 16.0,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 22.0.h, right: 22.0.h, top: 6.0.v),
                  child: const BodyText(
                    text: "معلومات عامة عن المستأجر",
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
                      ContractGridItem1(title:  "اسم المستأجر", value: contract.tenantFullName),
                      // 'Monthly','Quarterly Yearly','Mid Yearly','Yearly'
                      ContractGridItem1(title: "رقم الهوية", value: contract.tenantIdentityNum),
                      ContractGridItem1(title: "نوع الهوية", value: contract.tenantIdentityType),
                      ContractGridItem1(title: "تاريخ الميلاد", value: contract.tenantDateBirth?.dayFormatWithLocale('ar')),
                      ContractGridItem1(title: "الجنسية", value: contract.tenantNationality),
                      ContractGridItem1(title: "رقم الهاتف المحمول", value: contract.tenantPhone),
                      ContractGridItem1(title:"العنوان", value: contract.tenantAddress),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 25.0.v,),
        ],
      ),
    );
  }
}
