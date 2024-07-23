import 'package:flutter/material.dart';
import 'package:maktab_lessor/core/extension/date_time_extension.dart';

import '../../../../../../core/helpers/size_helper.dart';
import '../../../../../data/models/contract/contract_model.dart';
import '../../../../resources/app_assets.dart';
import '../../../../resources/app_colors.dart';
import '../../../../widgets/maktab_image_view.dart';
import '../../../../widgets/body_text.dart';
import '../../../../widgets/section_title.dart';

class ContractsWidget extends StatelessWidget {
  final Function(ContractModel) onPressed;
  final List<ContractModel> contracts;

  const ContractsWidget({
    super.key,
    required this.onPressed,
    required this.contracts,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: contracts.length,
        itemBuilder: (context, index) {
          final ContractModel contract = contracts[index];
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 3.0.v),
            child: Container(
              height: 90.v,
              decoration: BoxDecoration(
                color: AppColors.white,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withOpacity(.1),
                    blurRadius: 4,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Container(
                    width: 3.0,
                    decoration: BoxDecoration(
                      color: _getColor(_getType(contract)),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: ListTile(
                      onTap: ()=> onPressed(contract),
                      minLeadingWidth: 60.h,
                      leading: SizedBox(
                        width: 60.h,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SectionTitle(
                              title: _getText(_getType(contract)),
                              textColor: _getColor(_getType(contract)),
                              fontSize: 13,
                              textAlign: TextAlign.center,
                            ),
                            SectionTitle(
                              title: '${contract.contractNumber}',
                              fontSize: 14,
                            ),
                          ],
                        ),
                      ),
                      title: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 15.0.v, bottom: 20.v),
                            child: VerticalDivider(
                              color: AppColors.black.withOpacity(.2),
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  BodyText(
                                    text: "المؤجر",
                                    fontSize: 10,
                                    textColor: AppColors.black.withOpacity(.6),
                                  ),
                                  SizedBox(height: 7.0.v),
                                  BodyText(
                                    text: "المستأجر",
                                    fontSize: 10,
                                    textColor: AppColors.black.withOpacity(.6),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 10.0.h,
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SectionTitle(
                                    title: '${contract.tenantFullName}',
                                    fontSize: 10,
                                  ),
                                  SizedBox(height: 7.0.v),
                                  SectionTitle(
                                    title: '${contract.lessorFullName}',
                                    fontSize: 10,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MaktabImageView(imagePath: AppAssets.viewListDetails),
                          const BodyText(
                            text: "تفاصيل",
                            fontSize: 12,
                          ),
                          BodyText(
                            text: contract.updatedAt?.dayFormatWithLocale('ar')??'',
                            fontSize: 12,
                            textColor: AppColors.gray,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // 'New', 'Renewed', 'Finished'
  Color _getColor(ContractType type) {
    switch(type){
      case ContractType.waiting:
        return AppColors.orangeAccent;
      case ContractType.accepted:
        return AppColors.mintGreen;
      case ContractType.expired:
        return AppColors.deepCrimson;
      case ContractType.canceled:
        return AppColors.cherryRed;
      case ContractType.none:
        return AppColors.mintGreen;
    }
  }

  String _getText(ContractType type){
    switch(type){
      case ContractType.waiting:
        return 'بأنتظار الموافقة';
      case ContractType.accepted:
        return 'مقبول';
      case ContractType.expired:
        return 'منتهي';
      case ContractType.canceled:
        return 'ملغي';
      case ContractType.none:
        return '';
    }
  }

  // 'New', 'Renewed', 'Finished'
  // 'منتهي', 'ملغي', 'بأنتظار الموافقة', 'مقبول'
  ContractType _getType(ContractModel contract) {
    if(contract.contractEndDate!.isBefore(DateTime.now())) return ContractType.expired;
    if((contract.lessorApproved??false) && (contract.tenantApproved??false)) {
      if(contract.requiredApprove == '1') return ContractType.canceled;
      if(contract.requiredApprove == '2') return ContractType.none;
    }
    if(contract.contractType == '') {
      if(contract.requiredApprove == '1') return ContractType.waiting;
      if(contract.requiredApprove == '2') return ContractType.none;
    }
    if(contract.contractType == 'New') {
      if(contract.requiredApprove == '1') return ContractType.accepted;
      if(contract.requiredApprove == '2') return ContractType.none;
    }
    return ContractType.none;
  }
}


