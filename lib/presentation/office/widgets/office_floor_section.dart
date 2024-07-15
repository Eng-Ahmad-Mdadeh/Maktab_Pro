import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab_lessor/domain/office/office_bloc.dart';
import 'package:maktab_lessor/presentation/widgets/quantity_selector.dart';
import 'package:maktab_lessor/presentation/widgets/section_title.dart';

class OfficeFloorSection extends StatelessWidget {
  const OfficeFloorSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OfficeBloc, OfficeState>(
      builder: (context, state) {
        return QuantitySelector(
          title: const SectionTitle(title: 'الدور'),
          quantity: state.floor == 0 ? 'أرضي' : state.floor.toString(),
          increaseOnPressed: () =>
              context.read<OfficeBloc>().add(IncreaseFloorEvent(state.floor)),
          decreaseOnPressed: () =>
              context.read<OfficeBloc>().add(DecreaseFloorEvent(state.floor)),
        );
      },
    );
  }
}
