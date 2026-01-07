import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/domain/office/office_bloc.dart';
import 'package:maktab_lessor/presentation/office/widgets/feature_box.dart';
import 'package:maktab_lessor/presentation/widgets/section_title.dart';

class OfficePropertyUtilitiesList extends StatefulWidget {
  const OfficePropertyUtilitiesList({super.key});

  @override
  State<OfficePropertyUtilitiesList> createState() => _OfficePropertyUtilitiesListState();
}

class _OfficePropertyUtilitiesListState extends State<OfficePropertyUtilitiesList> {
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_initialized) return;

    final bloc = context.read<OfficeBloc>();
    final state = bloc.state;

    final propertiesUtilities = state.searchData?.propertyUtilities ?? [];
    final selectedUtilities = state.verifyLicenseNumberModel?.propertyUtilities ?? [];
    final alreadySelectedFeatureIds = state.features;

    for (final propertyUtilities in propertiesUtilities) {
      final isMatched = selectedUtilities.any((e) => e.arName == propertyUtilities.arName);
      final isAlreadySelected = alreadySelectedFeatureIds.contains(propertyUtilities.id);

      if (isMatched && !isAlreadySelected) {
        bloc.add(SelectPropertyUtilitiesEvent(propertyUtilities.id!));
      }
    }

    _initialized = true;
  }

  @override
  Widget build(BuildContext context) {
    final propertyUtilities = context.read<OfficeBloc>().state.searchData!.propertyUtilities;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'الخدمات  الأساسية'),
        SizedBox(height: 10.v),
        Center(
          child: Wrap(
            children: propertyUtilities
                .map((e) => BlocBuilder<OfficeBloc, OfficeState>(
                      builder: (context, state) {
                        return FeatureBox(
                          feature: e,
                          isSelected: state.propertyUtilities.contains(e.id),
                          onTap: () {
                            if (state.officeType == OfficeTypes.request) {
                              context.read<OfficeBloc>().add(
                                    SelectPropertyUtilitiesEvent(e.id!),
                                  );
                            }
                          },
                        );
                      },
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }
}
