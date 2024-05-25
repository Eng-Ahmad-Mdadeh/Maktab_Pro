// ignore_for_file: must_be_immutable, depend_on_referenced_packages

import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:maktab/core/extension/image_type_extension.dart';
import 'package:maktab/presentation/resources/app_colors.dart';

class MaktabImageView extends StatelessWidget {
  MaktabImageView({
    super.key,
    this.imagePath,
    this.height,
    this.width,
    this.color,
    this.fit,
    this.alignment,
    this.onTap,
    this.radius,
    this.margin,
    this.border,
    this.placeHolder = const Icon(FontAwesomeIcons.cameraRetro),
  });

  final String? imagePath;
  final double? height;
  final double? width;
  final Color? color;
  final BoxFit? fit;
  final Icon placeHolder;
  final Alignment? alignment;
  final EdgeInsetsGeometry? margin;
  final BorderRadius? radius;
  BoxBorder? border;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment!,
            child: _buildWidget(),
          )
        : _buildWidget();
  }

  Widget _buildWidget() {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: InkWell(
        splashColor: Colors.transparent,
        onTap: onTap,
        child: _buildCircleImage(),
      ),
    );
  }

  Widget _buildCircleImage() {
    if (radius != null) {
      return ClipRRect(
        borderRadius: radius ?? BorderRadius.zero,
        child: _buildImageWithBorder(),
      );
    } else {
      return _buildImageWithBorder();
    }
  }

  Widget _buildImageWithBorder() {
    if (border != null) {
      return Container(
        decoration: BoxDecoration(
            border: border, borderRadius: radius, color: Colors.transparent),
        child: _buildImageView(),
      );
    } else {
      return _buildImageView();
    }
  }

  Widget _buildImageView() {
    if (imagePath != null) {
      switch (imagePath!.imageType) {
        case ImageType.svg:
          return SizedBox(
            height: height,
            width: width,
            child: SvgPicture.asset(
              imagePath!,
              height: height,
              width: width,
              fit: fit ?? BoxFit.cover,
              colorFilter:
                  ColorFilter.mode(color ?? AppColors.black, BlendMode.srcIn),
            ),
          );
        case ImageType.file:
          return Image.file(
            File(imagePath!),
            height: height,
            width: width,
            fit: fit ?? BoxFit.cover,
            color: color,
          );
        case ImageType.network:
          return CachedNetworkImage(
            height: height,
            width: width,
            fit: fit ?? BoxFit.cover,
            imageUrl: imagePath!,
            color: color,
            placeholder: (context, url) => const SizedBox(
              height: 30,
              width: 30,
              child: LinearProgressIndicator(
                color: AppColors.palePlatinum,
                backgroundColor: AppColors.lightGray,
              ),
            ),
            // errorWidget: (context, url, error) => Image.asset(
            //   placeHolder,
            //   height: height,
            //   width: width,
            //   fit: fit ?? BoxFit.cover,
            // ),
          );
        case ImageType.png:
        default:
          return Image.asset(
            imagePath!,
            height: height,
            width: width,
            fit: fit ?? BoxFit.cover,
            color: color,
          );
      }
    }
    return const SizedBox.shrink();
  }
}
