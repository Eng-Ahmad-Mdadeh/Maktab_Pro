import 'package:flutter/material.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/presentation/widgets/body_text.dart';

class MaktabIconItem extends StatelessWidget {
  const MaktabIconItem({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
  });

  final String title;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: color,
          size: 60.fSize,
        ),
        SizedBox(height: 8.v),
        BodyText(
          text: title,
          textColor: color,
        ),
      ],
    );
  }
}
