import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/core/router/app_routes.dart';
import 'package:maktab/data/models/office/office_model.dart';
import 'package:maktab/domain/offices/offices_cubit.dart';
import 'package:maktab/presentation/offices/widgets/office_item.dart';
import 'package:maktab/presentation/widgets/body_text.dart';
import 'package:maktab/presentation/widgets/loading_dialog.dart';
import 'package:maktab/presentation/widgets/maktab_loading.dart';


class IncompleteUnitItemsList extends StatefulWidget {
  final Function(int) onIncompleteUnitDelete;
  const IncompleteUnitItemsList({super.key, required this.onIncompleteUnitDelete});

  @override
  State<IncompleteUnitItemsList> createState() => _IncompleteUnitItemsListState();
}

class _IncompleteUnitItemsListState extends State<IncompleteUnitItemsList> {
  Office? selectedUnit;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350.v,
      child: RefreshIndicator(
        onRefresh: () async => context.read<OfficesCubit>().getIncompleteUnits(),
        child: BlocConsumer<OfficesCubit, OfficesState>(
          listener: (context, state) {
            if (state.unitApiCallState == OfficesApiCallState.loading) {
              LoadingDialog.show(context);
            } else if (state.unitApiCallState == OfficesApiCallState.success) {
              LoadingDialog.hide(context);
              context.pushNamed(
                AppRoutes.createUnitScreen,
                extra: {
                  'office': state.selectedOffice,
                  'unit': selectedUnit,
                },
              );
            } else if (state.unitApiCallState == OfficesApiCallState.failure) {
              LoadingDialog.hide(context);
            }
          },
          builder: (context, state) {
            if (state.incompleteUnitsApiCallState == OfficesApiCallState.loading) {
              return Center(child: loadingItem());
            } else if (state.incompleteUnitsApiCallState == OfficesApiCallState.success) {
              return ListView.separated(
                itemBuilder: (context, index) {
                  return OfficeItem(
                    office: state.incompleteUnits[index],
                    mode: 'complete',
                    onTap: () async {
                      await context.read<OfficesCubit>().getUnitById(state.myOffices[index].id);
                      selectedUnit = state.incompleteUnits[index];
                    },
                    onDelete: () => widget.onIncompleteUnitDelete(state.incompleteUnits[index].id),
                  );
                },
                separatorBuilder: (context, index) => SizedBox(height: 20.v),
                itemCount: state.incompleteUnits.length,
              );
            } else if (state.incompleteUnitsApiCallState == OfficesApiCallState.failure) {
              return const Center(child: BodyText(text: 'حدث خطأ ما'));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
