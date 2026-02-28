import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab_lessor/domain/office/office_bloc.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_switch.dart';
import 'package:maktab_lessor/presentation/widgets/quantity_selector.dart';
import 'package:maktab_lessor/presentation/widgets/section_title.dart';

class OfficeSharedWorkSpacesSection extends StatefulWidget {
  const OfficeSharedWorkSpacesSection({super.key});

  @override
  State<OfficeSharedWorkSpacesSection> createState() => _OfficeSharedWorkSpacesSectionState();
}

class _OfficeSharedWorkSpacesSectionState extends State<OfficeSharedWorkSpacesSection> {
  late OfficeState state;

  @override
  void initState() {
    state = context.read<OfficeBloc>().state;

    super.initState();
  }

  @override
  void didChangeDependencies() {

    if ( state.createdUnit?.details!=null) {

      if (state.createdUnit!.details.isNotEmpty && state.createdUnit!.details.any((element) => element.arName=="مساحات عمل مشتركة",)) {

        context.read<OfficeBloc>().add(ToggleSharedWorkSpacesSelectorEvent());
        final adDetails = state.createdUnit!.details;


        context.read<OfficeBloc>().add(IncreaseSharedWorkSpacesCountEvent(adDetails
        .firstWhere(
              (element) => element.arName == "مساحات عمل مشتركة",
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
              const SectionTitle(title: 'مساحات عمل مشتركة'),
              MaktabSwitch(
                value: state.sharedWorkSpacesSelectorState == ToggleStates.on
                    ? true
                    : false,
                // activeColor: AppColors.emeraldTeal,
                // activeTrackColor: AppColors.mintGreen,
                onChanged: (value) => context
                    .read<OfficeBloc>()
                    .add(ToggleSharedWorkSpacesSelectorEvent()),
              ),
            ],
          ),
          quantity: state.sharedWorkSpaces.toString(),
          isEnabled: state.sharedWorkSpacesSelectorState == ToggleStates.on
              ? true
              : false,
          increaseOnPressed: () => context
              .read<OfficeBloc>()
              .add(IncreaseSharedWorkSpacesCountEvent(state.sharedWorkSpaces,false)),
          decreaseOnPressed: () => context
              .read<OfficeBloc>()
              .add(DecreaseSharedWorkSpacesCountEvent(state.sharedWorkSpaces)),
        );
      },
    );
  }
}
