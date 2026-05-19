/// features/send/presentation/contacts_screen.dart
library;

import 'package:flutter/material.dart';

import 'amount_screen.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Send Tally"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search contacts or Tally ID",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _contactTile(context, "Tendai Moyo", "TU-4421-87"),
                _contactTile(context, "Samu Khumalo", "TU-8834-02"),
                _contactTile(context, "Nyasha Dube", "TU-2211-92"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _contactTile(BuildContext context, String name, String id) {
    return ListTile(
      leading: CircleAvatar(
        child: Text(name[0]),
      ),
      title: Text(name),
      subtitle: Text(id),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => AmountScreen(recipient: name),
          ),
        );
      },
    );
  }
}