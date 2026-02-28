import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab_lessor/domain/office/office_bloc.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_switch.dart';
import 'package:maktab_lessor/presentation/widgets/quantity_selector.dart';
import 'package:maktab_lessor/presentation/widgets/section_title.dart';

class OfficeTablesCountSection extends StatefulWidget {
  const OfficeTablesCountSection({super.key});

  @override
  State<OfficeTablesCountSection> createState() => _OfficeTablesCountSectionState();
}

class _OfficeTablesCountSectionState extends State<OfficeTablesCountSection> {
  late OfficeState state;

  @override
  void initState() {
    state = context.read<OfficeBloc>().state;

    super.initState();
  }

  @override
  void didChangeDependencies() {

    if ( state.createdUnit?.details!=null) {

      if (state.createdUnit!.details.isNotEmpty && state.createdUnit!.details.any((element) => element.arName=="عدد الطاولات",)) {

        context.read<OfficeBloc>().add(ToggleTablesCountSelectorEvent());
        final adDetails = state.createdUnit!.details;
        context.read<OfficeBloc>().add(IncreaseTablesCountEvent(adDetails
            .firstWhere(
              (element) => element.arName == "عدد الطاولات",
            )
            .numberDetails
            .toInt(),true));
      }
    }
    super.didChangeDependencies();
  }

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
                value: state.tablesCountSelectorState == ToggleStates.on ? true : false,
                // activeColor: AppColors.emeraldTeal,
                // activeTrackColor: AppColors.mintGreen,
                onChanged: (value) => context.read<OfficeBloc>().add(ToggleTablesCountSelectorEvent()),
              ),
            ],
          ),
          quantity: state.tablesCount.toString(),
          isEnabled: state.tablesCountSelectorState == ToggleStates.on ? true : false,
          increaseOnPressed: () => context.read<OfficeBloc>().add(IncreaseTablesCountEvent(state.tablesCount,false)),
          decreaseOnPressed: () => context.read<OfficeBloc>().add(DecreaseTablesCountEvent(state.tablesCount)),
        );
      },
    );
  }
}
