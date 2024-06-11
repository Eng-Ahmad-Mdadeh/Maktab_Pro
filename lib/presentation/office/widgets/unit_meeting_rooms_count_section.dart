import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab/domain/unit/unit_bloc.dart';
import 'package:maktab/presentation/widgets/maktab_switch.dart';
import 'package:maktab/presentation/widgets/quantity_selector.dart';
import 'package:maktab/presentation/widgets/section_title.dart';

class UnitMeetingRoomsCountSection extends StatelessWidget {
  const UnitMeetingRoomsCountSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UnitBloc, UnitState>(
      builder: (context, state) {
        return QuantitySelector(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SectionTitle(title: 'غرف الاجتماعات'),
              MaktabSwitch(
                value: state.meetingRoomsCountSelectorState == ToggleStates.on
                    ? true
                    : false,
                // activeColor: AppColors.emeraldTeal,
                // activeTrackColor: AppColors.mintGreen,
                onChanged: (value) => context
                    .read<UnitBloc>()
                    .add(ToggleMeetingRoomsCountSelectorEvent()),
              ),
            ],
          ),
          quantity: state.meetingRoomsCount.toString(),
          isEnabled: state.meetingRoomsCountSelectorState == ToggleStates.on
              ? true
              : false,
          increaseOnPressed: () => context
              .read<UnitBloc>()
              .add(IncreaseMeetingRoomsCountEvent(state.meetingRoomsCount)),
          decreaseOnPressed: () => context
              .read<UnitBloc>()
              .add(DecreaseMeetingRoomsCountEvent(state.meetingRoomsCount)),
        );
      },
    );
  }
}
