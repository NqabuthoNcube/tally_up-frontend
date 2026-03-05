import 'package:flutter/material.dart';

class TallyScreen extends StatelessWidget {

  const TallyScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Tally's"),
      ),

      body: ListView(

        padding: const EdgeInsets.all(20),

        children: const [

          ListTile(
            leading: CircleAvatar(child: Text("T")),
            title: Text("Tendai Moyo"),
            subtitle: Text("TU-4421-87"),
          ),

          ListTile(
            leading: CircleAvatar(child: Text("S")),
            title: Text("Samu Khumalo"),
            subtitle: Text("TU-8834-02"),
          ),
        ],
      ),
    );
  }
}