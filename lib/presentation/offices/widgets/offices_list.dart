import 'package:flutter/material.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/data/models/office/office_model.dart';
import 'package:maktab_lessor/presentation/offices/widgets/office_box.dart';
import 'package:maktab_lessor/presentation/widgets/body_text.dart';

class OfficesList extends StatelessWidget {
  const OfficesList({super.key, required this.offices});

  final List<Office> offices;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 8,
      child: offices.isNotEmpty
          ? ListView.separated(
              itemBuilder: (context, index) {
                return OfficeBox(office: offices[index]);
              },
              separatorBuilder: (context, index) => SizedBox(height: 15.v),
              itemCount: offices.length,
            )
          : const Center(child: BodyText(text: 'لا يوجد مكاتب')),
    );
  }
}
