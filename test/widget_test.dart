/// test/widget_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tally_up/app/app_bootstrap.dart';

void main() {
  testWidgets('App builds successfully', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: AppBootstrap(),
      ),
    );

    expect(find.byType(AppBootstrap), findsOneWidget);
  });
}