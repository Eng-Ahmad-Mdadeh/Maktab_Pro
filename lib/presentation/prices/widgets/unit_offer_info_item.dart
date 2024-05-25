import 'package:flutter/material.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/presentation/widgets/body_text.dart';

class UnitOfferInfoItem extends StatelessWidget {
  const UnitOfferInfoItem({
    super.key,
    required this.title,
    this.value,
    this.valueColor,
    this.child,
  });

  final String title;
  final String? value;
  final Widget? child;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.v),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(flex: 3, child: BodyText(text: title)),
          Expanded(
            flex: 5,
            child: child != null
                ? child!
                : BodyText(
                    text: value!,
                    textAlign: TextAlign.left,
                    textColor: valueColor,
                  ),
          ),
        ],
      ),
    );
  }
}
