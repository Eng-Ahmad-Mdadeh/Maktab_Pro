import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab_lessor/domain/video/video_bloc.dart';
import 'package:video_player/video_player.dart';

class MaktabVideoPlayer extends StatefulWidget {
  const MaktabVideoPlayer(
      {super.key, this.videoLink = '', this.videoFile = ''});

  final String videoLink;
  final String videoFile;

  @override
  State<MaktabVideoPlayer> createState() => _MaktabVideoPlayerState();
}

class _MaktabVideoPlayerState extends State<MaktabVideoPlayer> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    if (widget.videoFile.isNotEmpty) {
      log('controller initial video file: ${widget.videoFile}');
      File file = File(widget.videoFile);
      _controller = VideoPlayerController.file(file)
        ..initialize().then((_) {
          context.read<VideoBloc>().add(InitVideoEvent());
        }).catchError((e) {
          log(e.toString());
        });
    } else {
      log('controller initial video link: ${widget.videoLink}');
      _controller =
          VideoPlayerController.networkUrl(Uri.parse(widget.videoLink))
            ..initialize().then((_) {
              context.read<VideoBloc>().add(InitVideoEvent());
            })
            ..addListener(() {
              if (_controller.value.position == _controller.value.duration) {
                context.read<VideoBloc>().add(EndVideoEvent());
              }
            });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VideoBloc, VideoState>(listener: (context, state) {
      if (state.isPlaying == true) {
        _controller.play();
      } else if (state.isPlaying == false) {
        _controller.pause();
      }
    }, builder: (context, state) {
      log(state.isPlaying.toString());
      return Center(
          child: GestureDetector(
        onTap: () {
          if (state.isPlaying == true) {
            context.read<VideoBloc>().add(PauseVideoEvent());
          } else {
            context.read<VideoBloc>().add(PlayVideoEvent());
          }
        },
        child: AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: Stack(
            alignment: Alignment.center,
            children: [
              VideoPlayer(_controller),
              state.isPlaying == true
                  ? const CircleAvatar(child: Icon(Icons.pause))
                  : const CircleAvatar(child: Icon(Icons.play_arrow))
            ],
          ),
        ),
      ));
    });
  }
}
