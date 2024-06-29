import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/core/router/app_routes.dart';
import 'package:maktab_lessor/domain/contract_models/contract_model/contract_model_bloc.dart';
import 'package:maktab_lessor/presentation/resources/app_colors.dart';
import 'package:maktab_lessor/presentation/widgets/loading_widget.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_button.dart';

import '../../../../../domain/contract_models/contract_models_bloc.dart';
import '../../../../widgets/confirm_alert_dialog.dart';
import '../../../../widgets/maktab_app_bar.dart';
import '../../../../widgets/body_text.dart';
import '../../../../widgets/section_title.dart';

class ContractsModelsScreen extends StatelessWidget {
  const ContractsModelsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MaktabAppBar(
        title: "نماذج العقود",
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ContractModelsBloc, ContractModelsState>(
              builder: (context, state) {
                if (state is ContractModelsLoading) return const LoadingWidget(1);
                if (state is ContractModelsSuccess) {
                  return ListView.separated(
                    itemCount: state.contractModels.length,
                    itemBuilder: (context, i) {
                      final contractModel = state.contractModels[i];
                      return ListTile(
                        title: SectionTitle(
                          title: contractModel.name ?? '',
                          fontSize: 15.0,
                        ),
                        subtitle: BodyText(text: contractModel.description ?? ''),
                        // leading: Container(
                        //   padding: EdgeInsets.all(13.0.adaptSize),
                        //   decoration: BoxDecoration(
                        //     color: contractModel.status == '1' ? AppColors.mintGreen : AppColors.cherryRed,
                        //     borderRadius: BorderRadius.circular(10.0.adaptSize),
                        //   ),
                        //   child: BodyText(
                        //     text:contractModel.status == '1' ? 'Active' : 'Passive',
                        //     textColor: AppColors.white,
                        //   ),
                        // ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            InkWell(
                              onTap: () {
                                context
                                    .read<ContractModelBloc>()
                                    .add(GetContractModel(contractModel.id.toString()));
                                context.pushNamed(AppRoutes.contractsModelScreen);
                              },
                              child: const Icon(
                                Icons.remove_red_eye,
                                color: AppColors.mintGreen,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                context
                                    .read<ContractModelBloc>()
                                    .add(GetContractModel(contractModel.id.toString()));
                                context.pushNamed(AppRoutes.editContractsModelScreen,
                                    extra: contractModel.id.toString());
                              },
                              child: const Icon(
                                Icons.edit,
                                color: AppColors.mintGreen,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context2) {
                                    return ConfirmAlertDialog(
                                      alertText: 'سوف يتم الحذف',
                                      confirmOnPressed: () {
                                        context
                                            .read<ContractModelsBloc>()
                                            .add(DeleteContractModels(contractModel.id.toString()));
                                        context.pop();
                                      },
                                      cancelOnPressed: () => context.pop(),
                                    );
                                  },
                                );
                              },
                              child: const Icon(
                                Icons.delete,
                                color: AppColors.cherryRed,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, i) {
                      return const Divider(
                        color: AppColors.softAsh,
                      );
                    },
                  );
                }
                return const SizedBox();
              },
            ),
          ),
          MaktabButton(
            text: "إنشاء نموذج",
            onPressed: () {},
          ),
          SizedBox(height: 10.0.v,),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     context.pushNamed(AppRoutes.addContractsModelScreen);
      //   },
      //   backgroundColor: AppColors.mintGreen,
      //   foregroundColor: AppColors.white,
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}
