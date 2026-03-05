import 'package:flutter/material.dart';
import '../../core/theme/theme_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final themeController = ref.read(themeProvider.notifier);

    return Scaffold(

      appBar: AppBar(
        title: const Text("Settings"),
      ),

      body: ListView(

        children: [

          const SizedBox(height: 20),

          ListTile(
            leading: const Icon(Icons.dark_mode),
            title: const Text("Dark Mode"),
            subtitle: const Text("Toggle dark theme"),
            onTap: () {
              themeController.toggleTheme();
            },
          ),

          const Divider(),

          const ListTile(
            leading: Icon(Icons.notifications),
            title: Text("Notifications"),
          ),

          const Divider(),

          const ListTile(
            leading: Icon(Icons.lock),
            title: Text("Security"),
          ),

          const Divider(),

          const ListTile(
            leading: Icon(Icons.info),
            title: Text("About Tally"),
          ),
        ],
      ),
    );
  }
}