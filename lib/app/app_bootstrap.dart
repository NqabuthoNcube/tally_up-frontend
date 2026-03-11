import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/theme/app_theme.dart';
import '../core/theme/theme_controller.dart';
import 'flow_router.dart';

/// Root bootstrap for the Flutter application.
/// 
/// Responsibilities:
/// - Apply global theme configuration
/// - Mount the application router
/// - Provide Riverpod context
class AppBootstrap extends ConsumerWidget {
  const AppBootstrap({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Tally Up',

      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,

      // Router handles the entire navigation flow
      home: const FlowRouter(),
    );
  }
}