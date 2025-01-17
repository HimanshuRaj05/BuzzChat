import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:whatsapp_flutter/colors.dart';

import 'package:whatsapp_flutter/common/widgets/loader.dart';
import 'package:whatsapp_flutter/features/chat/controller/chat_controller.dart';
import 'package:whatsapp_flutter/features/chat/screens/mobile_chat_screen.dart';
import 'package:whatsapp_flutter/models/chat_contact.dart';
import 'package:whatsapp_flutter/models/group.dart';

class ContactsList extends ConsumerWidget {
  const ContactsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Column(
        children: [
          StreamBuilder<List<Group>>(
            stream: ref.watch(chatControllerProvider).chatGroups(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Loader();
              }

              List<Group> groups = snapshot.data ?? [];
              groups.sort((a, b) => b.timeSent.compareTo(a.timeSent)); // Sort by timeSent in descending order

              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: groups.length,
                itemBuilder: (context, index) {
                  var groupData = groups[index];

                  return Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            MobileChatScreen.routeName,
                            arguments: {
                              'name': groupData.name,
                              'uid': groupData.groupId,
                              'isGroupChat': true,
                              'profilePic': groupData.groupPic,
                            },
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: ListTile(
                            title: Text(
                              groupData.name,
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 6.0),
                              child: Text(
                                groupData.lastMessage,
                                style: TextStyle(fontSize: 15, color: Colors.grey),
                              ),
                            ),
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                groupData.groupPic,
                              ),
                              radius: 30,
                            ),
                            trailing: Text(
                              DateFormat.Hm().format(groupData.timeSent),
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Divider(color: dividerColor, indent: 85),
                    ],
                  );
                },
              );
            },
          ),
          StreamBuilder<List<ChatContact>>(
            stream: ref.watch(chatControllerProvider).chatContacts(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Loader();
              }

              List<ChatContact> contacts = snapshot.data ?? [];
              contacts.sort((a, b) => b.timeSent.compareTo(a.timeSent)); // Sort by timeSent in descending order

              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: contacts.length,
                itemBuilder: (context, index) {
                  var chatContactData = contacts[index];

                  return Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            MobileChatScreen.routeName,
                            arguments: {
                              'name': chatContactData.name,
                              'uid': chatContactData.contactId,
                              'isGroupChat': false,
                              'profilePic': chatContactData.profilePic,
                            },
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: ListTile(
                            title: Text(
                              chatContactData.name,
                              style: TextStyle(
                                  fontSize: 20,   color: Colors.grey.shade700, fontWeight: FontWeight.w600),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 6.0),
                              child: Text(
                                chatContactData.lastMessage,
                                style: const TextStyle(fontSize: 15),
                              ),
                            ),
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                chatContactData.profilePic,
                              ),
                              radius: 30,
                            ),
                            trailing: Text(
                              DateFormat.Hm()
                                  .format(chatContactData.timeSent),
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Divider(color: dividerColor, indent: 85),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
