import 'package:flutter/material.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/presentation/office/widgets/office_description_form.dart';
import 'package:maktab/presentation/widgets/body_text.dart';
import 'package:maktab/presentation/widgets/page_title.dart';

class OfficeDescriptionStep extends StatefulWidget {
  const OfficeDescriptionStep({super.key});

  @override
  State<OfficeDescriptionStep> createState() => _OfficeDescriptionStepState();
}

class _OfficeDescriptionStepState extends State<OfficeDescriptionStep> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PageTitle(title: 'وصف المكتب'),
          SizedBox(height: 30.v),
          const BodyText(
              text: 'أضف وصف مميز لمكتبك و ايش يتوقع الضيف أن يجد فيه'),
          SizedBox(height: 10.v),
          const BodyText(
              text:
                  '73% من المضيفين المميزين (الذين لديهم حجوزات ومبيعات عالية) يكتبوا وصف مميز و واضح'),
          SizedBox(height: 20.v),
          const OfficeDescriptionForm(),
        ],
      ),
    );
  }
}
