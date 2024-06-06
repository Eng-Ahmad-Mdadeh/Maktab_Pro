// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/presentation/resources/app_colors.dart';
import 'package:maktab/presentation/widgets/section_title.dart';

class MaktabTextFormField extends StatelessWidget {
  const MaktabTextFormField({
    super.key,
    this.title,
    this.initialValue,
    this.smallTitle,
    this.width,
    this.scrollPadding,
    this.controller,
    this.focusNode,
    this.textStyle,
    this.textAlign,
    this.obscureText = false,
    this.textInputAction = TextInputAction.next,
    this.textInputType = TextInputType.text,
    this.maxLines = 1,
    this.minLines,
    this.hintText,
    this.hintStyle,
    this.prefix,
    this.prefixConstraints,
    this.suffix,
    this.suffixConstraints,
    this.contentPadding,
    this.borderDecoration,
    this.fillColor,
    this.filled = true,
    this.errorStyle,
    this.readOnly = false,
    this.disabled = false,
    this.autofocus = false,
    this.unFocusWhenTabOutside = true,
    this.inputFormatters,
    this.validator,
    this.onChanged,
    this.onSaved,
    this.onTap,
  });

  final String? title;
  final String? initialValue;
  final String? smallTitle;
  final double? width;
  final TextEditingController? scrollPadding;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextStyle? textStyle;
  final TextAlign? textAlign;
  final bool? obscureText;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final int? maxLines;
  final int? minLines;
  final String? hintText;
  final TextStyle? hintStyle;
  final Widget? prefix;
  final BoxConstraints? prefixConstraints;
  final Widget? suffix;
  final BoxConstraints? suffixConstraints;
  final EdgeInsets? contentPadding;
  final InputBorder? borderDecoration;
  final Color? fillColor;
  final bool readOnly;
  final bool? filled;
  final bool disabled;
  final bool autofocus;
  final bool unFocusWhenTabOutside;
  final TextStyle? errorStyle;
  final List<TextInputFormatter>? inputFormatters;
  final FormFieldValidator<String>? validator;
  final Function(String?)? onChanged;
  final Function(String?)? onSaved;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        title != null
            ? Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 5.v),
                  child: Row(
                    children: [
                      SectionTitle(title: title.toString()),
                      smallTitle != null
                          ? Padding(
                              padding: EdgeInsets.only(right: 5.h),
                              child: Text(
                                smallTitle!,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(color: AppColors.slateGray),
                              ),
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                ),
              )
            : const SizedBox.shrink(),
        TextFormField(
          controller: controller,
          initialValue: initialValue,
          focusNode: focusNode,
          autofocus: autofocus,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          style: textStyle ?? Theme.of(context).textTheme.titleMedium,
          obscureText: obscureText!,
          textInputAction: textInputAction,
          keyboardType: textInputType,
          textAlign: textAlign ?? TextAlign.right,
          maxLines: maxLines,
          minLines: minLines,
          readOnly: readOnly,
          enabled: !disabled,
          decoration:
              (const InputDecoration()).applyDefaults(Theme.of(context).inputDecorationTheme).copyWith(
                    fillColor: fillColor,
                    hintText: hintText,
                    prefixIcon: prefix,
                    suffixIcon: suffix,
                    errorStyle: errorStyle,
                  ),
          inputFormatters: inputFormatters,
          validator: validator,
          onTapOutside: (event) {
            if (unFocusWhenTabOutside) {
              FocusManager.instance.primaryFocus?.unfocus();
            }
          },
          onChanged: onChanged,
          onSaved: onSaved,
          onTap: onTap,
        ),
      ],
    );
  }
}
