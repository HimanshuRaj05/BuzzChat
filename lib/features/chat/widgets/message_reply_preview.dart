import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_flutter/common/providers/message_reply_provider.dart';
import 'package:whatsapp_flutter/features/chat/widgets/display_text_image_gif.dart';
import 'package:whatsapp_flutter/features/chat/widgets/display_text_image_gif1.dart';

class MessageReplyPreview extends ConsumerWidget {
  const MessageReplyPreview({Key? key}) : super(key: key);

  void cancelReply(WidgetRef ref) {
    ref.read(messageReplyProvider.state).update((state) => null);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messageReply = ref.watch(messageReplyProvider);

    return WillPopScope(
      onWillPop: () async {
        cancelReply(ref); // Dismiss reply preview when back button is pressed
        return true;
      },
      child: Container(
        width: 350,
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    messageReply!.isMe ? 'Me' : 'Opposite',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade900,
                    ),
                  ),
                ),
                GestureDetector(
                  child:Icon(
                    Icons.close,
                    size: 16,
                    color: Colors.grey.shade900,
                  ),
                  onTap: () => cancelReply(ref),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              constraints: BoxConstraints(
                maxWidth: 300,
                maxHeight: 300,
              ), // Adjust size as needed
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: DisplayTextImageGIF1(
                  message: messageReply.message,
                  type: messageReply.messageEnum,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
