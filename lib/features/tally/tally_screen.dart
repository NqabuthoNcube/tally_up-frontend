/// features/tally/presentation/tally_screen.dart

import 'package:flutter/material.dart';

class TallyScreen extends StatelessWidget {
  const TallyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const tallies = [
      {"name": "Tendai Moyo", "id": "TU-4421-87"},
      {"name": "Samu Khumalo", "id": "TU-8834-02"},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Tallies"),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: tallies.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, index) {
          final tally = tallies[index];

          final name = tally["name"]!;
          final id = tally["id"]!;

          return ListTile(
            leading: CircleAvatar(
              child: Text(name[0]),
            ),
            title: Text(name),
            subtitle: Text(id),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          );
        },
      ),
    );
  }
}