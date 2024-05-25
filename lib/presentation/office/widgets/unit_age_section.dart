import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab/domain/unit/unit_bloc.dart';
import 'package:maktab/presentation/widgets/quantity_selector.dart';
import 'package:maktab/presentation/widgets/section_title.dart';

class UnitAgeSection extends StatelessWidget {
  const UnitAgeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UnitBloc, UnitState>(
      builder: (context, state) {
        return QuantitySelector(
          title: const SectionTitle(title: 'عمر المكتب'),
          quantity: state.officeAge == 1 ? 'جديد' : state.officeAge.toString(),
          increaseOnPressed: () => context
              .read<UnitBloc>()
              .add(IncreaseOfficeAgeEvent(state.officeAge)),
          decreaseOnPressed: () => context.read<UnitBloc>().add(
                DecreaseOfficeAgeEvent(state.officeAge),
              ),
        );
      },
    );
  }
}
