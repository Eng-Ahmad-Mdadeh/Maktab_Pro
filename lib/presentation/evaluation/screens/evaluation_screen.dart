import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/presentation/evaluation/widgets/office_evaluation_box.dart';
import 'package:maktab_lessor/presentation/widgets/body_text.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_app_bar.dart';

import '../../../domain/evaluation/evaluation_bloc.dart';

class EvaluationScreen extends StatelessWidget {
  const EvaluationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MaktabAppBar(title: 'التقييمات'),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 25.v),
          child: Column(
            children: [
              Expanded(
                child: BlocBuilder<EvaluationBloc, EvaluationState>(
                  builder: (context, state) {
                    return RefreshIndicator(
                      onRefresh: () async => context.read<EvaluationBloc>().add(GetEvaluationsEvent()),
                      child: state is EvaluationSuccess
                          ? state.evaluations.isNotEmpty
                              ? ListView.separated(
                                  itemBuilder: (context, index) {
                                    return OfficeEvaluationBox(office: state.evaluations[index]);
                                  },
                                  separatorBuilder: (context, index) => SizedBox(height: 15.v),
                                  itemCount: state.evaluations.length,
                                )
                              : const Center(child: BodyText(text: 'لا يوجد تقيمات'))
                          : const Center(child: BodyText(text: 'لا يوجد تقيمات')),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
