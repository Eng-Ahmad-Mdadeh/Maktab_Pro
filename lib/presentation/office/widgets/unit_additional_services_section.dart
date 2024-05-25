import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/domain/unit/unit_bloc.dart';
import 'package:maktab/presentation/office/widgets/additional_service_form.dart';
import 'package:maktab/presentation/resources/app_colors.dart';
import 'package:maktab/presentation/widgets/maktab_button.dart';
import 'package:maktab/presentation/widgets/section_title.dart';

class UnitAddtitionalServicesSection extends StatefulWidget {
  const UnitAddtitionalServicesSection({super.key});

  @override
  State<UnitAddtitionalServicesSection> createState() =>
      _UnitAddtitionalServicesSectionState();
}

class _UnitAddtitionalServicesSectionState
    extends State<UnitAddtitionalServicesSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(
          title: 'خدمات إضافية',
          textFontWeight: FontWeight.w500,
        ),
        SizedBox(height: 20.v),
        BlocBuilder<UnitBloc, UnitState>(
          builder: (context, state) {
            return Column(
              children: [
                ...state.additionalServiceKeys.keys.mapIndexed(
                  (index, key) => AdditionalServiceForm(key: key),
                ),
              ],
            );
          },
        ),
        SizedBox(height: 20.v),
        MaktabButton(
          width: 80.h,
          height: 60.v,
          backgroundColor: AppColors.mintTeal,
          icon: Icon(
            FontAwesomeIcons.plus,
            color: AppColors.white,
            size: 25.fSize,
          ),
          onPressed: () {
            context.read<UnitBloc>().add(AddAddtionalServiceEvent());
          },
        ),
      ],
    );
  }
}
