import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../core/extension/image_type_extension.dart';
import '../resources/app_colors.dart';

class MaktabImageView extends StatelessWidget {
  const MaktabImageView({
    super.key,
    required this.imagePath,
    this.id,
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
    this.isExpanded = false,
    this.showControls = true,
  });

  final String imagePath;
  final String? id;
  final double? height;
  final double? width;
  final Color? color;
  final BoxFit? fit;
  final Icon placeHolder;
  final Alignment? alignment;
  final EdgeInsetsGeometry? margin;
  final BorderRadius? radius;
  final BoxBorder? border;
  final VoidCallback? onTap;
  final bool isExpanded;
  final bool showControls;

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
          border: border,
          borderRadius: radius,
        ),
        child: _buildImageView(),
      );
    } else {
      return _buildImageView();
    }
  }

  Widget _buildImageView() {
    switch (imagePath.imageType) {
      case ImageType.svg:
        return SizedBox(
          height: height,
          width: width,
          child: SvgPicture.asset(
            imagePath,
            height: height,
            width: width,
            fit: fit ?? BoxFit.contain,
            colorFilter: color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
          ),
        );
      case ImageType.networkSvg:
        if (isExpanded) {
          return Container(
            height: height,
            width: width,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: SvgPicture.network(
              imagePath,
              height: height,
              width: width,
              fit: fit ?? BoxFit.contain,
              colorFilter: color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
            ),
          );
        }
        return SizedBox(
          height: height,
          width: width,
          child: SvgPicture.network(
            imagePath,
            height: height,
            width: width,
            fit: fit ?? BoxFit.contain,
            colorFilter: color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
          ),
        );
      case ImageType.networkPng:
        if (isExpanded) {
          return Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: CachedNetworkImageProvider(
                  imagePath,
                ),
                colorFilter: color == null ? null : ColorFilter.mode(color!, BlendMode.color),
                fit: fit,
              ),
            ),
          );
        } else {
          return CachedNetworkImage(
            fit: fit,
            height: height,
            width: width,
            imageUrl: imagePath,
            color: color,
            placeholder: (context, url) => const SizedBox(
              height: 30,
              width: 30,
              child: LinearProgressIndicator(
                color: AppColors.palePlatinum,
                backgroundColor: AppColors.lightGray,
              ),
            ),
          );
        }
      case ImageType.file:
        return Image.file(
          File(imagePath),
          height: height,
          width: width,
          fit: fit ?? BoxFit.cover,
          color: color,
        );
      case ImageType.networkMp4:
        return const SizedBox();
        // return Container(
        //   color: AppColors.white,
        //   width: width,
        //   height: height,
        //   child: VideoPlayerItemWidget(
        //     id: id!,
        //     videoUrl: imagePath,
        //     showControls: showControls,
        //   ),
        // );
      case ImageType.empty:
        return const SizedBox();
      case ImageType.png:
      default:
        return Image.asset(
          imagePath,
          height: height,
          width: width,
          fit: fit ?? BoxFit.cover,
          color: color,
        );
    }
  }
}
//
// class VideoPlayerItemWidget extends StatelessWidget {
//   final String id;
//   final String videoUrl;
//   final bool showControls;
//
//   const VideoPlayerItemWidget({super.key, required this.id, required this.videoUrl, this.showControls = true});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => VideoBloc()..add(LoadVideo(id, videoUrl)),
//       child: BlocBuilder<VideoBloc, VideoState>(
//         builder: (context, state) {
//           if (state is VideoLoading && state.id == id) {
//             return const Center(child: LoadingWidget(1));
//           } else if (state is VideoLoaded && state.id == id) {
//             return VideoPlayerItemBody(
//               controller: state.controller,
//               id: id,
//               isPlaying: false,
//               showControls: showControls,
//             );
//           } else if (state is VideoPlaying && state.id == id) {
//             return VideoPlayerItemBody(
//               controller: state.controller,
//               id: id,
//               isPlaying: true,
//               showControls: showControls,
//             );
//           } else if (state is VideoPaused && state.id == id) {
//             return VideoPlayerItemBody(
//               controller: state.controller,
//               id: id,
//               isPlaying: false,
//               showControls: showControls,
//             );
//           } else {
//             return const Center(child: Text('No video loaded.'));
//           }
//         },
//       ),
//     );
//   }
// }
//
// class VideoPlayerItemBody extends StatelessWidget {
//   final VideoPlayerController controller;
//   final bool showControls;
//   final String id;
//   final bool isPlaying;
//
//   const VideoPlayerItemBody({
//     super.key,
//     required this.controller,
//     required this.showControls,
//     required this.id,
//     required this.isPlaying,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Align(
//           alignment: Alignment.topCenter,
//           child: VideoPlayer(controller),
//         ),
//         if (showControls)
//           Align(
//             alignment: Alignment.center,
//             child: VideoControls(
//               id: id,
//               isPlaying: isPlaying,
//             ),
//           ),
//       ],
//     );
//   }
// }
//
// class VideoControls extends StatelessWidget {
//   final String id;
//   final bool isPlaying;
//
//   const VideoControls({super.key, required this.id, this.isPlaying = false});
//
//   @override
//   Widget build(BuildContext context) {
//     return !isPlaying
//         ? IconButton(
//       icon: Container(
//         padding: const EdgeInsets.all(5),
//         decoration: BoxDecoration(
//           color: AppColors.black.withOpacity(.7),
//           borderRadius: BorderRadius.circular(3),
//         ),
//         child: const Icon(
//           Icons.play_arrow,
//           color: AppColors.white,
//         ),
//       ),
//       onPressed: () {
//         // context.read<VideoBloc>().add(PlayVideo(id));
//       },
//     )
//         : IconButton(
//       icon: Container(
//         padding: const EdgeInsets.all(5),
//         decoration: BoxDecoration(
//           color: AppColors.black.withOpacity(.7),
//           borderRadius: BorderRadius.circular(3),
//         ),
//         child: const Icon(
//           Icons.pause,
//           color: AppColors.white,
//         ),
//       ),
//       onPressed: () {
//         // context.read<VideoBloc>().add(PauseVideo(id));
//       },
//     );
//   }
// }
