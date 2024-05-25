import 'package:flutter/material.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/presentation/resources/app_colors.dart';

class DeleteMediaIconButton extends StatelessWidget {
  const DeleteMediaIconButton({super.key, required this.onTap});

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(5.v),
        decoration: BoxDecoration(
          color: AppColors.cherryRed,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(15.fSize),
            bottomLeft: Radius.circular(15.fSize),
          ),
          gradient: const LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              AppColors.softAsh,
              AppColors.cherryRed,
            ],
          ),
        ),
        child: const Icon(
          Icons.delete,
          color: AppColors.white,
        ),
      ),
    );
  }
}
