import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerDemo extends StatefulWidget {
  @override
  _VideoPlayerDemoState createState() => _VideoPlayerDemoState();
}

class _VideoPlayerDemoState extends State<VideoPlayerDemo> {
  ChewieController chewieController;
  VideoPlayerController videoPlayerController;

  void initVideoPlayer() async {
    videoPlayerController = VideoPlayerController.network(
        'https://file-examples.com/wp-content/uploads/2017/04/file_example_MP4_480_1_5MG.mp4');

    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      aspectRatio: 16 / 9,
      autoPlay: false,
      looping: false,
    );
  }

  @override
  void initState() {
    initVideoPlayer();
    super.initState();
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.runtimeType.toString()),
      ),
      body: Chewie(
        controller: chewieController,
      ),
    );
  }
}
