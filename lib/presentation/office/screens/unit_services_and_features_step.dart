import 'package:flutter/material.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/presentation/office/widgets/unit_additional_services_section.dart';
import 'package:maktab/presentation/office/widgets/unit_comfortS_list.dart';
import 'package:maktab/presentation/office/widgets/unit_features_list.dart';
import 'package:maktab/presentation/office/widgets/unit_services_list.dart';
import 'package:maktab/presentation/widgets/page_title.dart';

class UnitServicesAndFeaturesStep extends StatelessWidget {
  const UnitServicesAndFeaturesStep({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PageTitle(title: 'الخدمات والميزات', hint: '(اختياري)'),
          SizedBox(height: 30.v),
          UnitFeaturesList(),
          SizedBox(height: 20.v),
          UnitServicesServicesList(),
          SizedBox(height: 20.v),
          const UnitAddtitionalServicesSection(),
          SizedBox(height: 20.v),
          UnitComfortsList(),
        ],
      ),
    );
  }
}
