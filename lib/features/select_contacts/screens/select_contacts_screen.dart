import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_flutter/common/widgets/error.dart';
import 'package:whatsapp_flutter/common/widgets/loader.dart';
import 'package:whatsapp_flutter/features/select_contacts/controller/select_contact_controller.dart';

class SelectContactsScreen extends ConsumerWidget {
  static const String routeName = '/select-contact';
  const SelectContactsScreen({Key? key}) : super(key: key);

  void selectContact(
      WidgetRef ref, Contact selectedContact, BuildContext context) {
    ref
        .read(selectContactControllerProvider)
        .selectContact(selectedContact, context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.grey.shade900),
        title: Text(
          'Select contact',
          style: TextStyle(color: Colors.grey.shade900),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: ref.watch(getContactsProvider).when(
            data: (contactList) => ListView.builder(
              itemCount: contactList.length,
              itemBuilder: (context, index) {
                final contact = contactList[index];
                return InkWell(
                  onTap: () => selectContact(ref, contact, context),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: ListTile(
                      title: Text(
                        contact.displayName ??
                            'Unknown', // Handle null displayName
                        style: TextStyle(
                            fontSize: 18, color: Colors.grey.shade900),
                      ),
                      leading: contact.photo == null
                          ? CircleAvatar(child: Icon(Icons.person,), radius: 30)
                          : CircleAvatar(
                              backgroundImage: MemoryImage(contact.photo!),
                              radius: 30,
                            ),
                    ),
                  ),
                );
              },
            ),
            error: (err, trace) => ErrorScreen(error: err.toString()),
            loading: () => const Loader(),
          ),
    );
  }
}
