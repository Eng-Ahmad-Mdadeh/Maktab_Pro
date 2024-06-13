// ignore_for_file: must_be_immutable, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/presentation/resources/app_colors.dart';

import 'text/body_text.dart';
import 'text/section_title.dart';

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
    this.fontSize,
    this.shadow,
    required this.onPressed,
    this.isLoading = false,
    this.isEnabled = true,
    this.bold = true,
  });

  final String? text;
  final double? width;
  final double? elevation;
  final double? fontSize;
  final Icon? icon;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final Color backgroundColor;
  final Color color;
  final TextStyle? textStyle;
  final bool isBordered;
  final BorderRadiusGeometry? borderRadius;
  final Color? borderColor;
  final void Function()? onPressed;
  final BoxShadow? shadow;
  bool isLoading;
  bool isEnabled;
  bool bold;

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
        boxShadow: shadow != null ? [
          shadow!
        ] : null,
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
                    side: isBordered ? BorderSide(color: borderColor ?? AppColors.softAsh, width: 1) : BorderSide.none),
              ),
            ),
        child: isLoading
            ? const CircularProgressIndicator(color: AppColors.white)
            : Padding(
                padding: padding ?? EdgeInsets.symmetric(horizontal: 20.h, vertical: 15.v),
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
                            child: bold
                                ? SectionTitle(
                                    title: text!,
                                    textAlign: TextAlign.center,
                                    textColor: color,
                                    fontSize: fontSize,
                                  )
                                : BodyText(
                                    text!,
                                    textAlign: TextAlign.center,
                                    textColor: color,
                                    fontSize: fontSize,
                                  ),
                          )
                        : const SizedBox.shrink()
                  ],
                )),
      ),
    );
  }
}
