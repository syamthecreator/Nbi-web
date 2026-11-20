import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:nbi_web/app/app.dart';
import 'package:nbi_web/features/splash/providers/splash_provider.dart';

void main() {
  testWidgets('NBI app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const NbiApp());

    // Verify splash screen elements exist in RichText
    expect(
      find.textContaining('NOTICE BOARD', findRichText: true),
      findsOneWidget,
    );
    expect(find.textContaining('INDIA', findRichText: true), findsOneWidget);

    // Cancel timer cleanly and settle pending async tasks
    final element = tester.element(find.byType(MaterialApp));
    element.read<SplashProvider>().cancelSplashTimer();
    await tester.pump(const Duration(milliseconds: 600));
    await tester.pump(const Duration(milliseconds: 1200));
  });
}
