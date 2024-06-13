import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab/domain/unit/unit_bloc.dart';
import 'package:maktab/presentation/resources/app_colors.dart';
import 'package:maktab/presentation/widgets/maktab_switch.dart';
import 'package:maktab/presentation/widgets/maktab_text_form_field.dart';
import 'package:maktab/presentation/widgets/section_title.dart';

class UnitPriceFormField extends StatelessWidget {
  const UnitPriceFormField({
    super.key,
    required this.title,
    required this.controller,
    required this.option,
  });

  final String title;
  final TextEditingController controller;
  final UnitPriceOptions option;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UnitBloc, UnitState>(
      builder: (context, state) {
        return Row(
          children: [
            Expanded(child: SectionTitle(title: title)),
            Expanded(
              child: MaktabTextFormField(
                controller: controller,
                readOnly: !state.selectedUnitPriceOptions.contains(option),
                fillColor: state.selectedUnitPriceOptions.contains(option)
                    ? AppColors.white
                    : AppColors.palePlatinum,
                textInputType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onChanged: (value) {
                  context
                      .read<UnitBloc>()
                      .add(ChangeUnitPriceEvent(option, value.trim()));
                },
              ),
            ),
            Expanded(
              child: MaktabSwitch(
                value: state.selectedUnitPriceOptions.contains(option),
                // activeColor: AppColors.emeraldTeal,
                // activeTrackColor: AppColors.mintGreen,
                onChanged: (value) {
                  context.read<UnitBloc>()
                    ..add(ToggleUnitPriceOptionEvent(option))
                    ..add(ChangeUnitPriceEvent(option, controller.text.trim()));
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
