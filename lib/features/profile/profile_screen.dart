/// features/profile/presentation/profile_screen.dart

import 'package:flutter/material.dart';

import 'settings.dart';
import 'manage_profile.dart';
import 'help.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("You"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const CircleAvatar(
            radius: 40,
            child: Icon(Icons.person, size: 40),
          ),

          const SizedBox(height: 20),

          const Center(
            child: Text(
              "Tendai Moyo",
              style: TextStyle(fontSize: 20),
            ),
          ),

          const SizedBox(height: 30),

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