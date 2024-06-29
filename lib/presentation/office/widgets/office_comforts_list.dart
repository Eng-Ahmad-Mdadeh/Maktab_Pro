import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/domain/office/office_bloc.dart';
import 'package:maktab_lessor/presentation/office/widgets/comfort_box.dart';
import 'package:maktab_lessor/presentation/widgets/page_title.dart';

class OfficeComfortsList extends StatelessWidget {
  const OfficeComfortsList({super.key});


  @override
  Widget build(BuildContext context) {
    final comforts = context
        .read<OfficeBloc>()
        .state
        .searchData!
        .comforts;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PageTitle(title: 'وسائل الراحة (اختياري)'),
        SizedBox(height: 10.v),
        Center(
          child: Wrap(
            children: comforts.map((e) => BlocBuilder<OfficeBloc, OfficeState>(
              builder: (context, state) {
                return ComfortBox(
                  comfort: e,
                  isSelected: state.comforts.contains(e.id),
                  onTap: () => context
                      .read<OfficeBloc>()
                      .add(SelectComfortEvent(e.id)),
                );
              },
            )).toList(),
          ),
        ),
      ],
    );
  }
}
