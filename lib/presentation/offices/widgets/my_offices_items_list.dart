
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/core/router/app_routes.dart';
import 'package:maktab_lessor/data/models/office/office_model.dart';
import 'package:maktab_lessor/domain/offices/offices_cubit.dart';
import 'package:maktab_lessor/presentation/offices/widgets/office_item.dart';
import 'package:maktab_lessor/presentation/widgets/body_text.dart';
import 'package:maktab_lessor/presentation/widgets/loading_dialog.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_loading.dart';


class MyOfficesItemsList extends StatelessWidget {
  final Function(int) onMyOfficeDelete;
  MyOfficesItemsList({super.key, required this.onMyOfficeDelete});

  List<Office>? myOffices;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350.v,
      child: RefreshIndicator(
        onRefresh: () async =>
            context.read<OfficesCubit>().getIncompleteOffices(),
        child: BlocConsumer<OfficesCubit, OfficesState>(
          listener: (context, state) async {
            if (state.unitApiCallState == OfficesApiCallState.loading) {
              LoadingDialog.show(context);
            } else if (state.unitApiCallState == OfficesApiCallState.success) {
              LoadingDialog.hide(context);
              context.pushNamed(
                AppRoutes.createUnitScreen,
                extra: {'office': state.selectedOffice!},
              );
            } else if (state.unitApiCallState == OfficesApiCallState.failure) {
              LoadingDialog.hide(context);
            }
          },
          builder: (context, state) {
            if (state.myOfficesApiCallState == OfficesApiCallState.loading) {
              return Center(child: loadingItem());
            } else if (state.myOfficesApiCallState ==
                OfficesApiCallState.success) {
              myOffices = state.myOffices
                  .where((office) => !office.isMarketing)
                  .toList();
              return ListView.separated(
                itemBuilder: (context, index) {
                  return OfficeItem(
                    office: myOffices![index],
                    onTap: () async => await context
                        .read<OfficesCubit>()
                        .getUnitById(myOffices![index].id),
                    onDelete: ()=> onMyOfficeDelete(state.myOffices[index].id),
                  );
                },
                separatorBuilder: (context, index) => SizedBox(height: 20.v),
                itemCount: myOffices!.length,
              );
            } else if (state.myOfficesApiCallState ==
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
