import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/domain/offices/offices_cubit.dart';
import 'package:maktab/presentation/complaints/widgets/office_complaint_box.dart';
import 'package:maktab/presentation/widgets/body_text.dart';
import 'package:maktab/presentation/widgets/maktab_app_bar.dart';

class ComplaintsScreen extends StatefulWidget {
  const ComplaintsScreen({super.key});

  @override
  State<ComplaintsScreen> createState() => _ComplaintsScreenState();
}

class _ComplaintsScreenState extends State<ComplaintsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MaktabAppBar(title: 'الشكاوي'),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 25.v),
          child: Column(
            children: [
              Expanded(
                child: BlocBuilder<OfficesCubit, OfficesState>(
                  builder: (context, state) {
                    return RefreshIndicator(
                      onRefresh: () async => context
                          .read<OfficesCubit>()
                          .getComplaints(isUpdate: true),
                      child: context
                              .read<OfficesCubit>()
                              .state
                              .complaints
                              .isNotEmpty
                          ? ListView.separated(
                              itemBuilder: (context, index) {
                                return OfficeComplaintBox(
                                    office: context
                                        .read<OfficesCubit>()
                                        .state
                                        .complaints[index]);
                              },
                              separatorBuilder: (context, index) =>
                                  SizedBox(height: 15.v),
                              itemCount: context
                                  .read<OfficesCubit>()
                                  .state
                                  .complaints
                                  .length,
                            )
                          : const Center(
                              child: BodyText(text: 'لا يوجد شكاوي')),
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
