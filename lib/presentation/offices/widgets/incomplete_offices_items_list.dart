import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/core/router/app_routes.dart';
import 'package:maktab/domain/offices/offices_cubit.dart';
import 'package:maktab/presentation/offices/widgets/office_item.dart';
import 'package:maktab/presentation/widgets/body_text.dart';
import 'package:maktab/presentation/widgets/maktab_loading.dart';

class IncompleteOfficesItemsList extends StatefulWidget {
  const IncompleteOfficesItemsList({super.key});

  @override
  State<IncompleteOfficesItemsList> createState() =>
      _IncompleteOfficesItemsListState();
}

class _IncompleteOfficesItemsListState
    extends State<IncompleteOfficesItemsList> {
  @override
  void initState() {
    if (context.read<OfficesCubit>().state.incompleteOfficesApiCallState !=
        OfficesApiCallState.success) {
      context.read<OfficesCubit>().getIncompleteOffices();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350.v,
      child: RefreshIndicator(
        onRefresh: () async =>
            context.read<OfficesCubit>().getIncompleteOffices(),
        child: BlocBuilder<OfficesCubit, OfficesState>(
          builder: (context, state) {
            if (state.incompleteOfficesApiCallState ==
                OfficesApiCallState.loading) {
              return Center(child: loadingItem());
            } else if (state.incompleteOfficesApiCallState ==
                OfficesApiCallState.success) {
              return ListView.separated(
                itemBuilder: (context, index) {
                  return OfficeItem(
                    office: state.incompleteOffices[index],
                    mode: 'complete',
                    onTap: () {
                      context.pushNamed(AppRoutes.createOfficeScreen,
                          extra: state.incompleteOffices[index]);
                    },
                  );
                },
                separatorBuilder: (context, index) => SizedBox(height: 20.v),
                itemCount: state.incompleteOffices.length,
              );
            } else if (state.incompleteOfficesApiCallState ==
                OfficesApiCallState.failure) {
              return const Center(child: BodyText(text: 'حدث خطأ ما'));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
