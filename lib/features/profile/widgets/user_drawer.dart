// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import '../../qr/my_qr_screen.dart';
import '../settings_screen.dart';


class UserDrawer extends StatelessWidget {

  const UserDrawer({super.key});

  @override
  Widget build(BuildContext context) {

    return Drawer(

      child: Column(

        children: [

          Container(
            padding: const EdgeInsets.all(20),
            color: const Color(0xFF13223B),

            child: const Row(
              children: [

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text(
                        "Tendai Moyo",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),

                      SizedBox(height: 6),

                      Text(
                        "Tally ID: TU-4421-87",
                        style: TextStyle(color: Colors.white70),
                      ),

                      Text(
                        "+263771234567",
                        style: TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ),

                CircleAvatar(
                  radius: 24,
                  child: Icon(Icons.person),
                )
              ],
            ),
          ),

          const SizedBox(height: 20),

          ListTile(
            leading: const Icon(Icons.qr_code),
            title: const Text("My QR Code"),

            onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SettingsScreen()),
            );
            },
          ),

          const Divider(),

          const ListTile(
            leading: Icon(Icons.settings),
            title: Text("Settings"),
          ),

          const ListTile(
            leading: Icon(Icons.person),
            title: Text("Manage Profile"),
          ),

          const ListTile(
            leading: Icon(Icons.help),
            title: Text("Get Help"),
          ),
        ],
      ),
    );
  }
}