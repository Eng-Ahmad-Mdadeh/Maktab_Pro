import 'package:flutter/material.dart';

import '../../../../../../widgets/body_text.dart';
import '../../../../../../widgets/section_title.dart';


class ContractGridItem1 extends StatelessWidget {
  final String title;
  final String? value;

  const ContractGridItem1({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        BodyText(
          text: title,
          fontSize: 15.0,
        ),
        SectionTitle(
          title: value ?? '',
          fontSize: 14.0,
        ),
      ],
    );
  }
}