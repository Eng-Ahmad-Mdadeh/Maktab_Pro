import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab/domain/office/office_bloc.dart';
import 'package:maktab/presentation/widgets/maktab_switch.dart';
import 'package:maktab/presentation/widgets/quantity_selector.dart';
import 'package:maktab/presentation/widgets/section_title.dart';

class OfficeTablesCountSection extends StatelessWidget {
  const OfficeTablesCountSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OfficeBloc, OfficeState>(
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
                    .read<OfficeBloc>()
                    .add(ToggleTablesCountSelectorEvent()),
              ),
            ],
          ),
          quantity: state.tablesCount.toString(),
          isEnabled:
              state.tablesCountSelectorState == ToggleStates.on ? true : false,
          increaseOnPressed: () => context
              .read<OfficeBloc>()
              .add(IncreaseTablesCountEvent(state.tablesCount)),
          decreaseOnPressed: () => context
              .read<OfficeBloc>()
              .add(DecreaseTablesCountEvent(state.tablesCount)),
        );
      },
    );
  }
}
