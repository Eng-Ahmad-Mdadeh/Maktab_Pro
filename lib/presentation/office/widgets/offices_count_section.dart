// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:maktab_lessor/domain/office/office_bloc.dart';
// import 'package:maktab_lessor/presentation/widgets/maktab_switch.dart';
// import 'package:maktab_lessor/presentation/widgets/quantity_selector.dart';
// import 'package:maktab_lessor/presentation/widgets/section_title.dart';
//
// class OfficesCountSection extends StatelessWidget {
//   const OfficesCountSection({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<OfficeBloc, OfficeState>(
//       builder: (context, state) {
//         return QuantitySelector(
//           title: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               const SectionTitle(title: 'عدد المكاتب'),
//               MaktabSwitch(
//                 value: state.officesCountSelectorState == ToggleStates.on
//                     ? true
//                     : false,
//                 // activeColor: AppColors.emeraldTeal,
//                 // activeTrackColor: AppColors.mintGreen,
//                 onChanged: (value) => context
//                     .read<OfficeBloc>()
//                     .add(ToggleOfficesCountSelectorEvent()),
//               ),
//             ],
//           ),
//           quantity: state.officesCount.toString(),
//           isEnabled:
//               state.officesCountSelectorState == ToggleStates.on ? true : false,
//           increaseOnPressed: () => context
//               .read<OfficeBloc>()
//               .add(IncreaseOfficesCountEvent(state.officesCount)),
//           decreaseOnPressed: () => context
//               .read<OfficeBloc>()
//               .add(DecreaseOfficesCountEvent(state.officesCount)),
//         );
//       },
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab_lessor/domain/office/office_bloc.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_switch.dart';
import 'package:maktab_lessor/presentation/widgets/quantity_selector.dart';
import 'package:maktab_lessor/presentation/widgets/section_title.dart';

class OfficesCountSection extends StatefulWidget {
  const OfficesCountSection({super.key});

  @override
  State<OfficesCountSection> createState() => _OfficesCountSectionState();
}

class _OfficesCountSectionState extends State<OfficesCountSection> {
  late OfficeState state;

  @override
  void initState() {
    state = context.read<OfficeBloc>().state;

    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (state.verifyLicenseNumberModel != null) {
      if (state.verifyLicenseNumberModel!.adsDetails.isNotEmpty) {
        final adDetails = state.verifyLicenseNumberModel!.adsDetails;
        context.read<OfficeBloc>().add(SetOfficesCountEvent(adDetails.first.numberDetails!));
      }
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OfficeBloc, OfficeState>(
      builder: (context, state) {
        return AbsorbPointer(
          absorbing: state.licenseOfficeState == VisibilityStates.show,
          child: QuantitySelector(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SectionTitle(title: 'عدد الغرف'),
                MaktabSwitch(
                  value: true,
                  // activeColor: AppColors.emeraldTeal,
                  // activeTrackColor: AppColors.mintGreen,
                  // onChanged: (value) => context.read<OfficeBloc>().add(ToggleOfficesCountSelectorEvent()),
                  onChanged: (p0) {},
                ),
              ],
            ),
            quantity: state.officesCount.toString(),
            isEnabled: state.officesCountSelectorState == ToggleStates.on ? true : false,
            increaseOnPressed: () => context.read<OfficeBloc>().add(IncreaseOfficesCountEvent(state.officesCount)),
            decreaseOnPressed: () => context.read<OfficeBloc>().add(DecreaseOfficesCountEvent(state.officesCount)),
          ),
        );
      },
    );
  }
}
