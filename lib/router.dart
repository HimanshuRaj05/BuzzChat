import 'dart:io';

import 'package:flutter/material.dart';
import 'package:whatsapp_flutter/common/widgets/error.dart';
import 'package:whatsapp_flutter/features/auth/screens/login_screen.dart';
import 'package:whatsapp_flutter/features/auth/screens/otp_screen.dart';
import 'package:whatsapp_flutter/features/auth/screens/user_information_screen.dart';
import 'package:whatsapp_flutter/features/group/screens/create_group_screen.dart';
import 'package:whatsapp_flutter/features/select_contacts/screens/select_contacts_screen.dart';
import 'package:whatsapp_flutter/features/chat/screens/mobile_chat_screen.dart';
import 'package:whatsapp_flutter/models/status_model.dart';
import 'package:whatsapp_flutter/screens/confirm_status_screen.dart';
import 'package:whatsapp_flutter/screens/status_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      );
    case OTPScreen.routeName:
      final verificationId = settings.arguments as String;
      return MaterialPageRoute(
        builder: (context) => OTPScreen(
          verificationId: verificationId,
        ),
      );
    case UserInformationScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const UserInformationScreen(),
      );
    case SelectContactsScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const SelectContactsScreen(),
      );
    case MobileChatScreen.routeName:
      final arguments = settings.arguments;
      if (arguments is Map<String, dynamic>) {
        final name = arguments['name'] as String?;
        final uid = arguments['uid'] as String?;
        final isGroupChat = arguments['isGroupChat'] as bool? ?? false;
        final profilePic = arguments['profilePic'] as String?;

        if (name != null && uid != null) {
          return MaterialPageRoute(
            builder: (context) => MobileChatScreen(
              name: name,
              uid: uid,
              isGroupChat: isGroupChat,
              profilePic: profilePic ??
                  '', // Provide a default value if profilePic is null
            ),
          );
        } else {
          return MaterialPageRoute(
            builder: (context) => const Scaffold(
              body:
                  ErrorScreen(error: 'Invalid arguments for MobileChatScreen'),
            ),
          );
        }
      } else {
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: ErrorScreen(error: 'Invalid arguments for MobileChatScreen'),
          ),
        );
      }
    case ConfirmStatusScreen.routeName:
      final file = settings.arguments as File;
      return MaterialPageRoute(
        builder: (context) => ConfirmStatusScreen(
          file: file,
        ),
      );
    case StatusScreen.routeName:
      final status = settings.arguments as Status;
      return MaterialPageRoute(
        builder: (context) => StatusScreen(
          status: status,
        ),
      );
    case CreateGroupScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const CreateGroupScreen(),
      );
    default:
      return MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: ErrorScreen(error: 'This page doesn\'t exist'),
        ),
      );
  }
}
