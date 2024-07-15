import 'package:flutter/material.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/presentation/office/widgets/office_additional_services_section.dart';
import 'package:maktab_lessor/presentation/office/widgets/office_comforts_list.dart';
import 'package:maktab_lessor/presentation/office/widgets/office_features_list.dart';
import 'package:maktab_lessor/presentation/office/widgets/office_sevices_list.dart';
import 'package:maktab_lessor/presentation/widgets/page_title.dart';

class OfficeServicesAndFeaturesStep extends StatelessWidget {
  const OfficeServicesAndFeaturesStep({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PageTitle(title: 'الخدمات والميزات(اختياري)'),
          SizedBox(height: 30.v),
          const OfficeFeaturesList(),
          SizedBox(height: 20.v),
          const OfficeServicesList(),
          SizedBox(height: 20.v),
          const OfficeAddtitionalServicesSection(),
          SizedBox(height: 20.v),
          const OfficeComfortsList(),
        ],
      ),
    );
  }
}
