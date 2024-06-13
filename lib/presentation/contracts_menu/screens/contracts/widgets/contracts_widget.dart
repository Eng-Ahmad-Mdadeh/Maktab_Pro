import 'package:flutter/material.dart';

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
                      color: _getColor(contract.contractType!),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: ListTile(
                      onTap: ()=> onPressed(contract),
                      minLeadingWidth: 60.h,
                      leading: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SectionTitle(
                            title: contract.contractType??'',
                            textColor: AppColors.mintGreen,
                            fontSize: 14,
                          ),
                          SectionTitle(
                            title: '#${contract.contractNumber}',
                            fontSize: 14,
                          ),
                        ],
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
                                  const BodyText(
                                    text: "المؤجر",
                                    fontSize: 10,
                                  ),
                                  SizedBox(height: 7.0.v),
                                  const BodyText(
                                    text: "المستأجر",
                                    fontSize: 10,
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
  Color _getColor(String item) {
    switch (item) {
      case 'New':
        return AppColors.mintGreen;
      case 'Finished':
        return AppColors.cherryRed;
      case 'Renewed':
        return AppColors.mintGreen;
      default:
        return AppColors.mintGreen;
    }
  }
}
