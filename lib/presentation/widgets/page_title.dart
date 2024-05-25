// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/presentation/resources/app_colors.dart';

class PageTitle extends StatelessWidget {
  const PageTitle({
    super.key,
    required this.title,
    this.textAlign,
    this.hint,
  });

  final String title;
  final String? hint;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return hint != null
        ? Row(
            children: [
              Text(
                title,
                textAlign: textAlign ?? TextAlign.center,
                softWrap: true,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              if (hint != null)
                Padding(
                  padding: EdgeInsets.only(right: 10.h),
                  child: Text(
                    hint!,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: AppColors.slateGray),
                  ),
                ),
            ],
          )
        : Text(
            title,
            textAlign: textAlign ?? TextAlign.center,
            softWrap: true,
            style: Theme.of(context).textTheme.titleLarge,
          );
  }
}
