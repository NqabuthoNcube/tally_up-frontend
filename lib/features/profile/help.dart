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

        children: [

          const SizedBox(height: 20),

          const ListTile(
            leading: Icon(Icons.help_outline),
            title: Text("How to send Tally"),
          ),

          const Divider(),

          const ListTile(
            leading: Icon(Icons.qr_code),
            title: Text("Using QR payments"),
          ),

          const Divider(),

          const ListTile(
            leading: Icon(Icons.security),
            title: Text("Security tips"),
          ),

          const Divider(),

          const ListTile(
            leading: Icon(Icons.contact_support),
            title: Text("Contact support"),
          ),
        ],
      ),
    );
  }
}