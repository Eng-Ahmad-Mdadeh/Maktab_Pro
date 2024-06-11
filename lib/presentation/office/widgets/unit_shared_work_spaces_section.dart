import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab/domain/unit/unit_bloc.dart';
import 'package:maktab/presentation/widgets/maktab_switch.dart';
import 'package:maktab/presentation/widgets/quantity_selector.dart';
import 'package:maktab/presentation/widgets/section_title.dart';

class UnitSharedWorkSpacesSection extends StatelessWidget {
  const UnitSharedWorkSpacesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UnitBloc, UnitState>(
      builder: (context, state) {
        return QuantitySelector(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SectionTitle(title: 'مساحات عمل مشتركة'),
              MaktabSwitch(
                value: state.sharedWorkSpacesSelectorState == ToggleStates.on
                    ? true
                    : false,
                // activeColor: AppColors.emeraldTeal,
                // activeTrackColor: AppColors.mintGreen,
                onChanged: (value) => context
                    .read<UnitBloc>()
                    .add(ToggleSharedWorkSpacesSelectorEvent()),
              ),
            ],
          ),
          quantity: state.sharedWorkSpaces.toString(),
          isEnabled: state.sharedWorkSpacesSelectorState == ToggleStates.on
              ? true
              : false,
          increaseOnPressed: () => context
              .read<UnitBloc>()
              .add(IncreaseSharedWorkSpacesCountEvent(state.sharedWorkSpaces)),
          decreaseOnPressed: () => context
              .read<UnitBloc>()
              .add(DecreaseSharedWorkSpacesCountEvent(state.sharedWorkSpaces)),
        );
      },
    );
  }
}
