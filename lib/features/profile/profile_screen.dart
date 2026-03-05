import 'package:flutter/material.dart';

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

        children: const [

          CircleAvatar(
            radius: 40,
            child: Icon(Icons.person, size: 40),
          ),

          SizedBox(height: 20),

          Center(
            child: Text(
              "Tendai Moyo",
              style: TextStyle(fontSize: 20),
            ),
          ),

          SizedBox(height: 30),

          ListTile(
            leading: Icon(Icons.settings),
            title: Text("Settings"),
          ),

          ListTile(
            leading: Icon(Icons.person),
            title: Text("Manage Profile"),
          ),

          ListTile(
            leading: Icon(Icons.help),
            title: Text("Get Help"),
          ),
        ],
      ),
    );
  }
}