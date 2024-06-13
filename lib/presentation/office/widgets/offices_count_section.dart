import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab/domain/office/office_bloc.dart';
import 'package:maktab/presentation/widgets/maktab_switch.dart';
import 'package:maktab/presentation/widgets/quantity_selector.dart';
import 'package:maktab/presentation/widgets/section_title.dart';

class OfficesCountSection extends StatelessWidget {
  const OfficesCountSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OfficeBloc, OfficeState>(
      builder: (context, state) {
        return QuantitySelector(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SectionTitle(title: 'عدد المكاتب'),
              MaktabSwitch(
                value: state.officesCountSelectorState == ToggleStates.on
                    ? true
                    : false,
                // activeColor: AppColors.emeraldTeal,
                // activeTrackColor: AppColors.mintGreen,
                onChanged: (value) => context
                    .read<OfficeBloc>()
                    .add(ToggleOfficesCountSelectorEvent()),
              ),
            ],
          ),
          quantity: state.officesCount.toString(),
          isEnabled:
              state.officesCountSelectorState == ToggleStates.on ? true : false,
          increaseOnPressed: () => context
              .read<OfficeBloc>()
              .add(IncreaseOfficesCountEvent(state.officesCount)),
          decreaseOnPressed: () => context
              .read<OfficeBloc>()
              .add(DecreaseOfficesCountEvent(state.officesCount)),
        );
      },
    );
  }
}
