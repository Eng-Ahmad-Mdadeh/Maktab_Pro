import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab/domain/unit/unit_bloc.dart';
import 'package:maktab/presentation/widgets/quantity_selector.dart';
import 'package:maktab/presentation/widgets/section_title.dart';

class UnitFloorSection extends StatelessWidget {
  const UnitFloorSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UnitBloc, UnitState>(
      builder: (context, state) {
        return QuantitySelector(
          title: const SectionTitle(title: 'الدور'),
          quantity: state.floor == 0 ? 'أرضي' : state.floor.toString(),
          increaseOnPressed: () =>
              context.read<UnitBloc>().add(IncreaseFloorEvent(state.floor)),
          decreaseOnPressed: () =>
              context.read<UnitBloc>().add(DecreaseFloorEvent(state.floor)),
        );
      },
    );
  }
}
