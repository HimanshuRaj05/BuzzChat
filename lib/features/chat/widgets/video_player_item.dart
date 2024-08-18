import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerItem extends StatefulWidget {
  final String videoUrl;
  const VideoPlayerItem({super.key, required this.videoUrl});

  @override
  State<VideoPlayerItem> createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
  late VideoPlayerController _videoPlayerController;
  bool isPlay = false;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(
            () {}); // Ensure the first frame is shown after the video is initialized
        _videoPlayerController.setVolume(1);
      });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: _videoPlayerController.value.aspectRatio,
      child: Stack(
        children: [
          VideoPlayer(_videoPlayerController),
          Align(
            alignment: Alignment.center,
            child: IconButton(
              onPressed: () {
                if (isPlay) {
                  _videoPlayerController.pause();
                } else {
                  _videoPlayerController.play();
                }
                setState(() {
                  isPlay = !isPlay;
                });
              },
              icon: Icon(isPlay ? Icons.pause_circle : Icons.play_circle),
            ),
          ),
        ],
      ),
    );
  }
}
