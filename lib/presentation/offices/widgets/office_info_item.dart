import 'package:flutter/material.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/presentation/widgets/body_text.dart';

class OfficeInfoItem extends StatelessWidget {
  const OfficeInfoItem({
    super.key,
    required this.title,
    this.value,
    this.valueColor,
    this.valueWidget,
  });

  final String title;
  final String? value;
  final Color? valueColor;
  final Widget? valueWidget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.v),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 3,
            child: BodyText(text: title),
          ),
          Expanded(
            flex: 5,
            child: value != null
                ? BodyText(
                    text: value!,
                    textAlign: TextAlign.left,
                    textColor: valueColor,
                  )
                : Padding(
                    padding: EdgeInsets.only(right: 15.h),
                    child: valueWidget!,
                  ),
          ),
        ],
      ),
    );
  }
}
