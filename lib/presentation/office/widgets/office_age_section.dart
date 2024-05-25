import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab/domain/office/office_bloc.dart';
import 'package:maktab/presentation/widgets/quantity_selector.dart';
import 'package:maktab/presentation/widgets/section_title.dart';

class OfficeAgeSection extends StatelessWidget {
  const OfficeAgeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OfficeBloc, OfficeState>(
      builder: (context, state) {
        return QuantitySelector(
          title: const SectionTitle(title: 'عمر المكتب'),
          quantity: state.officeAge == 1 ? 'جديد' : state.officeAge.toString(),
          increaseOnPressed: () => context
              .read<OfficeBloc>()
              .add(IncreaseOfficeAgeEvent(state.officeAge)),
          decreaseOnPressed: () => context.read<OfficeBloc>().add(
                DecreaseOfficeAgeEvent(state.officeAge),
              ),
        );
      },
    );
  }
}
