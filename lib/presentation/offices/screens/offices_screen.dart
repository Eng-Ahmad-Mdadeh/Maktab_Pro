import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/domain/offices/offices_cubit.dart';
import 'package:maktab_lessor/domain/shimmer/shimmer_bloc.dart';
import 'package:maktab_lessor/presentation/offices/widgets/offices_header.dart';
import 'package:maktab_lessor/presentation/offices/widgets/offices_list.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_app_bar.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_loading.dart';
import 'package:maktab_lessor/presentation/widgets/page_title.dart';
import 'package:maktab_lessor/presentation/widgets/retry_button.dart';
import 'package:maktab_lessor/presentation/widgets/shimmer_effect.dart';

import '../../../domain/office/office_bloc.dart';
import '../../../domain/unit/unit_bloc.dart';
import '../../widgets/maktab_bottom_app_bar.dart';

class OfficesScreen extends StatefulWidget {
  const OfficesScreen({super.key});

  @override
  State<OfficesScreen> createState() => _OfficesScreenState();
}

class _OfficesScreenState extends State<OfficesScreen> {

  final GlobalKey _dropDownKey = GlobalKey();

  @override
  void initState() {
    context.read<ShimmerBloc>().add(BeginShimmerEffectEvent());
    if (context.read<OfficesCubit>().state.myOfficesApiCallState != OfficesApiCallState.success) {
      context.read<OfficesCubit>().getMyOffices();
      context.read<OfficesCubit>().getIncompleteOffices();
      context.read<OfficesCubit>().getIncompleteUnits();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MaktabAppBar(
        title: 'المكاتب والوحدات',
        leading: SizedBox(),
      ),
      body: SafeArea(
        child: BlocListener<OfficeBloc, OfficeState>(
          listener: (context, state) {
            if (state.officeApiCallState == OfficeApiCallState.success) {
              context.read<OfficesCubit>().getMyOffices();
              context.read<OfficesCubit>().getIncompleteOffices();
            }
          },
          child: BlocListener<UnitBloc, UnitState>(
            listener: (context, state) {
              if(state.unitApiCallState == UnitApiCallState.success){
                context.read<OfficesCubit>().getIncompleteUnits();
              }
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 25.v),
              child: BlocBuilder<OfficesCubit, OfficesState>(
                builder: (context, state) {
                  return ShimmerEffect(
                    isLoading: state.myOfficesApiCallState == OfficesApiCallState.loading,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        OfficesHeader(
                        _dropDownKey,
                          onIncompleteOfficeDelete: (int id) {
                            context.read<OfficeBloc>().add(DeleteOfficeEvent(id));
                          },
                          onIncompleteUnitDelete: (int id) {
                            context.read<UnitBloc>().add(DeleteUnitEvent(id));
                          },
                          onMyOfficeDelete: (int id) {
                            context.read<OfficeBloc>().add(DeleteOfficeEvent(id));
                          },
                        ),
                        SizedBox(height: 30.v),
                        const PageTitle(title: 'المكاتب:'),
                        SizedBox(height: 10.v),
                        Expanded(
                          child: RefreshIndicator(
                            onRefresh: () async => context.read<OfficesCubit>().getMyOffices(),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (state.myOfficesApiCallState == OfficesApiCallState.loading)
                                  Center(child: loadingItem())
                                else if (state.myOfficesApiCallState == OfficesApiCallState.success)
                                  OfficesList(offices: state.myOffices)
                                else if (state.myOfficesApiCallState == OfficesApiCallState.failure)
                                  RetryButton(
                                    onTap: () => context.read<OfficesCubit>().getMyOffices(),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: const MaktabBottomAppBar(),
    );
  }
}
