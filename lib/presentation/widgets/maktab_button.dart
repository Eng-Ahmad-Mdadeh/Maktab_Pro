// ignore_for_file: must_be_immutable, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/presentation/resources/app_colors.dart';

class MaktabButton extends StatelessWidget {
  MaktabButton({
    super.key,
    this.text,
    this.width,
    this.height,
    this.padding,
    this.elevation,
    this.icon,
    this.backgroundColor = AppColors.mintTeal,
    this.color = Colors.white,
    this.textStyle,
    this.isBordered = false,
    this.borderRadius,
    this.borderColor,
    required this.onPressed,
    this.isLoading = false,
    this.isEnabled = true,
  });

  final String? text;
  final double? width;
  final double? elevation;
  final Icon? icon;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final Color backgroundColor;
  final Color color;
  final TextStyle? textStyle;
  final bool isBordered;
  final BorderRadiusGeometry? borderRadius;
  final Color? borderColor;
  final Function()? onPressed;
  bool isLoading;
  bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: width,
      height: height,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInCubic,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: borderRadius ?? BorderRadius.circular(15.0),
      ),
      child: ElevatedButton(
        onPressed: isLoading || !isEnabled ? () {} : onPressed,
        style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
              elevation: MaterialStatePropertyAll(elevation),
              padding: const MaterialStatePropertyAll(EdgeInsets.zero),
              backgroundColor: MaterialStatePropertyAll<Color>(backgroundColor),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: borderRadius ?? BorderRadius.circular(15.0),
                    side: isBordered
                        ? BorderSide(
                            color: borderColor ?? AppColors.softAsh, width: 1)
                        : BorderSide.none),
              ),
            ),
        child: isLoading
            ? const CircularProgressIndicator(color: AppColors.white)
            : Padding(
                padding: padding ??
                    EdgeInsets.symmetric(horizontal: 20.h, vertical: 15.v),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    icon != null
                        ? Expanded(
                            flex: 2,
                            child: Align(
                              alignment: Alignment.center,
                              child: icon!,
                            ),
                          )
                        : const SizedBox.shrink(),
                    text != null
                        ? Expanded(
                            flex: 4,
                            child: Text(
                              text!,
                              softWrap: true,
                              textAlign: TextAlign.center,
                              style: textStyle ??
                                  Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                        color: color,
                                      ),
                            ),
                          )
                        : const SizedBox.shrink()
                  ],
                )),
      ),
    );
  }
}
