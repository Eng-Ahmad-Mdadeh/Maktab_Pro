import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab_lessor/domain/unit/unit_bloc.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_switch.dart';
import 'package:maktab_lessor/presentation/widgets/quantity_selector.dart';
import 'package:maktab_lessor/presentation/widgets/section_title.dart';

class UnitTablesCountSection extends StatelessWidget {
  const UnitTablesCountSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UnitBloc, UnitState>(
      builder: (context, state) {
        return QuantitySelector(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SectionTitle(title: 'عدد الطاولات'),
              MaktabSwitch(
                value: state.tablesCountSelectorState == ToggleStates.on
                    ? true
                    : false,
                // activeColor: AppColors.emeraldTeal,
                // activeTrackColor: AppColors.mintGreen,
                onChanged: (value) => context
                    .read<UnitBloc>()
                    .add(ToggleTablesCountSelectorEvent()),
              ),
            ],
          ),
          quantity: state.tablesCount.toString(),
          isEnabled:
              state.tablesCountSelectorState == ToggleStates.on ? true : false,
          increaseOnPressed: () => context
              .read<UnitBloc>()
              .add(IncreaseTablesCountEvent(state.tablesCount)),
          decreaseOnPressed: () => context
              .read<UnitBloc>()
              .add(DecreaseTablesCountEvent(state.tablesCount)),
        );
      },
    );
  }
}
