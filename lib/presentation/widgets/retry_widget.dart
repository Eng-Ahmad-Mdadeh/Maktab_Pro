import 'package:flutter/material.dart';

import 'body_text.dart';


class RetryWidget extends StatelessWidget {
  final Function() onReload;
  final bool showText;
  final Color? iconColor;

  const RetryWidget({
    super.key,
    required this.onReload,
    this.showText = true,
    this.iconColor
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.refresh),
            color: iconColor,
            onPressed: onReload,
          ),
          if(showText) const BodyText(text: "فشل التحميل حاول مرة اخرى"),
        ],
      ),
    );
  }
}
