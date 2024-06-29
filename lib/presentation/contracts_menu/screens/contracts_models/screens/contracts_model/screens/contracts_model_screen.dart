import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/presentation/resources/app_text_styles.dart';
import 'package:maktab_lessor/presentation/widgets/loading_widget.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_app_bar.dart';

import '../../../../../../../domain/contract_models/contract_model/contract_model_bloc.dart';
import '../../../../../../widgets/body_text.dart';

class ContractsModelScreen extends StatelessWidget {
  const ContractsModelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContractModelBloc, ContractModelState>(
      builder: (context, state) {
        if (state is ContractModelLoading) {
          return const Scaffold(
            body: LoadingWidget(1),
          );
        }
        if (state is ContractModelSuccess) {
          return Scaffold(
            appBar: MaktabAppBar(
              title: state.contractModel.name ?? '',
            ),
            body: BlocBuilder<ContractModelBloc, ContractModelState>(
              builder: (context, state) {
                if (state is ContractModelSuccess) {
                  return Padding(
                    padding: EdgeInsets.all(21.0.adaptSize),
                    child: HtmlWidget(
                      state.contractModel.contentContractModel ?? '',
                      textStyle: AppTextStyles.bodyLarge.copyWith(
                        fontSize: 17.0.fSize
                      ),
                    ),
                  );
                }
                return const Center(
                  child: BodyText(text: "هنالك شيء لايعمل"),
                );
              },
            ),
          );
        }
        return const Scaffold(
          body: Center(
            child: BodyText(text: "لا يوجد شيء لعرضه حاول مرة اخرى"),
          ),
        );
      },
    );
  }
}
