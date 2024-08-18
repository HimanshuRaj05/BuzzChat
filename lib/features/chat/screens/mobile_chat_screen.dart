import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_flutter/colors.dart';
import 'package:whatsapp_flutter/common/widgets/loader.dart';
import 'package:whatsapp_flutter/features/auth/controller/auth_controller.dart';

import 'package:whatsapp_flutter/features/chat/widgets/bottom_chat_field.dart';
import 'package:whatsapp_flutter/models/user_model.dart';

import 'package:whatsapp_flutter/features/chat/widgets/chat_list.dart';

class MobileChatScreen extends ConsumerWidget {
  static const String routeName = '/mobile-chat-screen';
  final String name;
  final String uid;
  final bool isGroupChat;
  final String profilePic;
  const MobileChatScreen(
      {Key? key,
      required this.name,
      required this.uid,
      required this.isGroupChat , 
      required this.profilePic})
      : super(key: key);


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
     return Scaffold(
      backgroundColor: Color.fromARGB(255, 248, 248, 252),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.grey.shade900),
          backgroundColor: Colors.white,
          title: isGroupChat
              ? Text(name, style: TextStyle(color: Colors.grey.shade900),)
              : StreamBuilder<UserModel>(
                  stream: ref.read(authControllerProvider).userDataById(uid),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Loader();
                    }
      
                    return Column(
                      children: [
                        Text(name, style: TextStyle(color: Colors.grey.shade900)),
                        Text(
                          snapshot.data!.isOnline ? 'online' : 'offline',
                          style: TextStyle(
                              fontSize: 13, color: Colors.grey,  fontWeight: FontWeight.normal),
                        )
                      ],
                    );
                  }),
          centerTitle: false,
         
        ),
        body: Column(
          children: [
            Expanded(
              child: ChatList(
                recieverUserId: uid,
                isGroupChat: isGroupChat,
              ),
            ),
            BottomChatField(
              recieverUserId: uid,
              isGroupChat: isGroupChat,
            ),
          ],
        ),
      );
    
  }
}
