/// features/profile/presentation/help.dart

import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Help & Support"),
      ),
      body: ListView(
        children: const [
          SizedBox(height: 20),

          ListTile(
            leading: Icon(Icons.help_outline),
            title: Text("How to send Tally"),
          ),

          Divider(),

          ListTile(
            leading: Icon(Icons.qr_code),
            title: Text("Using QR payments"),
          ),

          Divider(),

          ListTile(
            leading: Icon(Icons.security),
            title: Text("Security tips"),
          ),

          Divider(),

          ListTile(
            leading: Icon(Icons.contact_support),
            title: Text("Contact support"),
          ),
        ],
      ),
    );
  }
}