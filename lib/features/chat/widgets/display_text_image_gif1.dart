import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:whatsapp_flutter/common/enums/message_enum.dart';
import 'package:whatsapp_flutter/features/chat/widgets/video_player_item.dart';
import 'package:audioplayers/audioplayers.dart';

class DisplayTextImageGIF1 extends StatelessWidget {
  final String message;
  final MessageEnum type;
  const DisplayTextImageGIF1(
      {super.key, required this.message, required this.type});

  @override
  Widget build(BuildContext context) {
    bool isPlaying = false;

    final AudioPlayer audioPlayer = AudioPlayer();

    return type == MessageEnum.text
        ? Text(
            message,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          )
        : type == MessageEnum.audio
            ? StatefulBuilder(builder: (context, setState) {
                return IconButton(
                  constraints: const BoxConstraints(minWidth: 100),
                  onPressed: () async {
                    if (isPlaying) {
                      await audioPlayer.pause();
                      setState(() {
                        isPlaying = false;
                      });
                    } else {
                      await audioPlayer.play(UrlSource(message));
                      setState(() {
                        isPlaying = true;
                      });
                    }
                  },
                  icon:
                      Icon(isPlaying ? Icons.pause_circle : Icons.play_circle),
                );
              })
            : type == MessageEnum.video
                ? VideoPlayerItem(videoUrl: message)
                : type == MessageEnum.gif
                    ? CachedNetworkImage(imageUrl: message)
                    : CachedNetworkImage(imageUrl: message);
  }
}
