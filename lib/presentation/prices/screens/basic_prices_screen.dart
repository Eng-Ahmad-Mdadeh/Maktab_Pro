import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/domain/offices/offices_cubit.dart';
import 'package:maktab_lessor/presentation/prices/widgets/office_price_box.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_app_bar.dart';

class BasicPricesScreen extends StatelessWidget {
  const BasicPricesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MaktabAppBar(title: 'الأسعار الأساسية'),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 25.v),
          child: Column(
            children: [
              Expanded(
                child: BlocBuilder<OfficesCubit, OfficesState>(
                  builder: (context, state) {
                    return RefreshIndicator(
                      onRefresh: () =>
                          context.read<OfficesCubit>().getAllPrices(),
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          return OfficePriceBox(
                            office: context
                                .read<OfficesCubit>()
                                .state
                                .prices[index],
                          );
                        },
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 10.v),
                        itemCount:
                            context.read<OfficesCubit>().state.prices.length,
                      ),
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
