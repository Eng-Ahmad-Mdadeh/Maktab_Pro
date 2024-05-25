import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/domain/offices/offices_cubit.dart';
import 'package:maktab/presentation/offices/widgets/office_box.dart';
import 'package:maktab/presentation/widgets/body_text.dart';
import 'package:maktab/presentation/widgets/maktab_app_bar.dart';

class MarketingRequestsScreen extends StatelessWidget {
  const MarketingRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MaktabAppBar(title: 'طلبات التسويق'),
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
                          .getMarketingRequests(isUpdate: true),
                      child: context
                              .read<OfficesCubit>()
                              .state
                              .marketingRequests
                              .isNotEmpty
                          ? ListView.separated(
                              itemBuilder: (context, index) {
                                return OfficeBox(
                                    office: context
                                        .read<OfficesCubit>()
                                        .state
                                        .marketingRequests[index]);
                              },
                              separatorBuilder: (context, index) =>
                                  SizedBox(height: 15.v),
                              itemCount: context
                                  .read<OfficesCubit>()
                                  .state
                                  .marketingRequests
                                  .length,
                            )
                          : const Center(
                              child: BodyText(text: 'لا يوجد طلبات تسويق')),
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
