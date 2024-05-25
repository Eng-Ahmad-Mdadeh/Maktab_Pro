// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/presentation/auth/widgets/option_button.dart';

class MessageOptionsCard extends StatelessWidget {
  const MessageOptionsCard({super.key, required this.buttons});

  final List<OptionButton> buttons;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170.v,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.v),
        ),
        margin: EdgeInsets.symmetric(vertical: 20.v),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: buttons,
          ),
        ),
      ),
    );
  }
}
