import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/core/router/app_routes.dart';
import 'package:maktab/domain/offices/offices_cubit.dart';
import 'package:maktab/presentation/prices/widgets/office_offer_box.dart';
import 'package:maktab/presentation/widgets/maktab_app_bar.dart';
import 'package:maktab/presentation/widgets/maktab_button.dart';
import 'package:maktab/presentation/widgets/page_title.dart';

class OfferPricesScreen extends StatelessWidget {
  const OfferPricesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MaktabAppBar(title: 'أسعار العروض'),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 25.v),
          child: Column(
            children: [
              Row(
                children: [
                  const Expanded(
                    child: PageTitle(
                      title: 'اختر مكتب',
                      textAlign: TextAlign.right,
                    ),
                  ),
                  Expanded(
                    child: MaktabButton(
                      height: 60.v,
                      text: 'إنشاء عرض',
                      padding: EdgeInsets.symmetric(horizontal: 15.h),
                      icon: const Icon(Icons.add),
                      onPressed: () =>
                          context.pushNamed(AppRoutes.createOfferScreen),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.v),
              Expanded(
                child: BlocBuilder<OfficesCubit, OfficesState>(
                  builder: (context, state) {
                    return RefreshIndicator(
                      onRefresh: () =>
                          context.read<OfficesCubit>().getAllOffers(),
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          return OfficeOfferBox(
                            office: context
                                .read<OfficesCubit>()
                                .state
                                .offers[index],
                          );
                        },
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 10.v),
                        itemCount:
                            context.read<OfficesCubit>().state.offers.length,
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
