import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/domain/offices/offices_cubit.dart';
import 'package:maktab_lessor/presentation/prices/widgets/unit_offer_details_box.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_app_bar.dart';

class UnitOffersScreen extends StatelessWidget {
  const UnitOffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OfficesCubit, OfficesState>(
      builder: (context, state) {
        return Scaffold(
          appBar: MaktabAppBar(
              title: 'عروض الوحدة: ${state.selectedOffice!.title}'),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 25.v),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        return UnitOfferDetailsBox(
                          unit: state.selectedOffice!,
                          offer: state.selectedOffice!.offers[index],
                        );
                      },
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 10.v),
                      itemCount: state.selectedOffice!.offers.length,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
