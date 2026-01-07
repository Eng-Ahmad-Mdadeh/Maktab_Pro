import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab_lessor/domain/office/office_bloc.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_drop_down_form_field.dart';
import 'package:maktab_lessor/presentation/widgets/section_title.dart';
import 'package:collection/collection.dart';

class OfficeAgeSection extends StatefulWidget {
  const OfficeAgeSection({super.key});

  @override
  State<OfficeAgeSection> createState() => _OfficeAgeSectionState();
}

class _OfficeAgeSectionState extends State<OfficeAgeSection> {
  late OfficeState state;

  @override
  void initState() {
    state = context.read<OfficeBloc>().state;

    // type = state.searchData!.officeTypes.firstWhereOrNull((type) => type.id == context.read<OfficeBloc>().state.type);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (state.verifyLicenseNumberModel != null) {
      if (state.verifyLicenseNumberModel!.propertyAgeId != null) {
        final propertyAge = state.verifyLicenseNumberModel!.propertyAge;

        context.read<OfficeBloc>().add(SetOfficeAgeEvent(propertyAge!.id!));
      }
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OfficeBloc, OfficeState>(
      builder: (context, state) {
        final propertyAges = state.searchData?.propertyAges ?? [];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionTitle(title: "عمر المكتب"),
            MaktabDropDownFormField(
              readOnly: state.licenseOfficeState == VisibilityStates.show,
              initialValue: state.officeAgeId != null || state.officeAge != null
                  ? propertyAges
                      .firstWhereOrNull((element) => element.id == int.parse(state.officeAgeId ?? state.officeAge!))
                      ?.nameAr
                  : '',
              items: propertyAges.map((interface) => interface.nameAr!).toList(),
              fontSize: 17.0,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'الرجاء إختيار نوع العقار';
                }
                return null;
              },
              onChanged: (value) {
                final id = propertyAges.firstWhere((element) => element.nameAr == value).id;
                context.read<OfficeBloc>().add(SetOfficeAgeEvent(id!));
              },
            ),
            const SizedBox(height: 10),
          ],
        );
      },
    );
  }
}
