/// features/profile/widgets/user_drawer.dart

import 'package:flutter/material.dart';
import 'package:tally_up/features/profile/help.dart';
import 'package:tally_up/features/profile/settings_screen.dart';

import '../../qr/my_qr_screen.dart';
import '../presentation/manage_profile.dart';

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
                ),
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
                MaterialPageRoute(builder: (_) => const MyQrScreen()),
              );
            },
          ),

          const Divider(),

          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text("Settings"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SettingsScreen()),
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.person),
            title: const Text("Manage Profile"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ManageProfileScreen()),
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.help),
            title: const Text("Get Help"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const HelpScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}