import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../../core/helpers/size_helper.dart';
import '../../../../../../../../core/network/api_endpoints.dart';
import '../../../../../../../../data/models/contract/contract_model.dart';
import '../../../../../../../../domain/settings/settings_bloc.dart';
import '../../../../../../../resources/app_colors.dart';
import '../../../../../../../widgets/maktab_image_view.dart';
import '../../../../../../../widgets/body_text.dart';
import '../../../../../../../widgets/section_title.dart';
import '../contract_grid_item1.dart';
import '../contract_grid_item2.dart';
import '../contract_grid_item3.dart';

class ContractStep2 extends StatelessWidget {
  final ContractModel contract;

  const ContractStep2({
    super.key,
    required this.contract,
  });

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
                    title: "تفاصيل العقار",
                    fontSize: 16.0,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 22.0.h, right: 22.0.h, top: 6.0.v),
                  child: const BodyText(
                    text: "معلومات عن العقارات المختارة",
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
                      ContractGridItem1(
                        title: "اسم العقار",
                        value: contract.officeName,
                      ),
                      // 'Monthly','Quarterly Yearly','Mid Yearly','Yearly'
                      ContractGridItem1(
                        title:  "نوع العقار",
                        value: contract.officeTypeAqar,
                      ),
                      ContractGridItem1(
                        title:  "نوع العقار",
                        value: contract.officeCategoryAqar,
                      ),
                      ContractGridItem1(
                        title: "رقم البناء",
                        value: contract.officeBuildingNo,
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 50.0.v,
                  color: AppColors.skyBlue.withOpacity(.16),
                  padding: EdgeInsets.only(left: 20.0.v, right: 20.0.v),
                  child: const Row(
                    children: [
                      SectionTitle(
                        title: "تفاصيل الوحدات",
                        fontSize: 16.0,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 21.0.h, right: 21.0.h, top: 28.0.v),
                  child: GridView(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 5 / 3,
                      crossAxisSpacing: 60.0.h,
                      mainAxisSpacing: 20.0.v,
                    ),
                    shrinkWrap: true,
                    children: [
                      ContractGridItem2(
                        title:  "رقم الوحدة",
                        value: contract.officeUnitNo,
                      ),
                      ContractGridItem2(
                        title: "المساحة",
                        value: contract.officeSpace,
                      ),
                      ContractGridItem2(
                        title:"رقم الطابق",
                        value: contract.officeNoFloor,
                      ),
                      ContractGridItem2(
                          title: "مشطب",
                          value: contract.officeIsMushtab == null
                              ? null
                              : contract.officeIsMushtab == '0'
                                  ? "لا"
                                  :  "نعم",
                          color: contract.officeIsMushtab == '0' ? AppColors.cherryRed : AppColors.mintGreen),
                      ContractGridItem2(
                        title: "تكييف مركزي",
                        value: contract.noCentralConditioners,
                      ),
                      if (contract.waterMoney != null)
                        ContractGridItem2(
                          title: "الماء",
                          value: contract.waterMoney,
                        ),
                      if (contract.electricityMoney != null)
                        ContractGridItem2(
                          title: "الكهرباء",
                          value: contract.electricityMoney,
                        ),
                    ],
                  ),
                ),
                if (contract.waterMoney == null) const ContractGridItem3(title:  "الماء", value:  "حسب قراءة العداد"),
                if (contract.electricityMoney == null) const ContractGridItem3(title: "الكهرباء", value: "حسب قراءة العداد"),
                Container(
                  height: 50.0.v,
                  color: AppColors.skyBlue.withOpacity(.16),
                  padding: EdgeInsets.only(left: 20.0.v, right: 20.0.v),
                  child: const Row(
                    children: [
                      SectionTitle(
                        title: "العنوان الوطني",
                        fontSize: 16.0,
                      ),
                    ],
                  ),
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
                      ContractGridItem1(
                        title:  "المدينة",
                        value: contract.officeCity,
                      ),
                      // 'Monthly','Quarterly Yearly','Mid Yearly','Yearly'
                      ContractGridItem1(
                        title: "الحي",
                        value: contract.officeNeighborhood,
                      ),
                      ContractGridItem1(
                        title:  "اسم الشارع",
                        value: contract.officeStreet,
                      ),
                      ContractGridItem1(
                        title:  "رقم البناء",
                        value: contract.officeBuildingNo,
                      ),
                      ContractGridItem1(
                        title:  "الرمز البريدي",
                        value: contract.officePostalCode,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ContractGridItem1(
                title: "رقم الصك",
                value: contract.lessorRoyalDeedNumber ?? '',
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 23.0.v),
                    child: const BodyText(text: "السجل التجاري  أو الوكالة"),
                  ),
                  BlocBuilder<GeneralSettingBloc, SettingsState>(
                    builder: (context, state) {
                      if (state is SettingsSuccess) {
                        return MaktabImageView(
                          imagePath: ApiEndpoints.siteUrl + (state.generalSettings.logo ?? ''),
                          width: 100,
                          // color: AppColors.black,
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
