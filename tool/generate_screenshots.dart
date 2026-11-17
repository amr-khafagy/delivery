import 'dart:io';

import 'package:delivery/main.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    final loader = FontLoader('Cairo')
      ..addFont(_fontData('assets/fonts/cairo/Cairo-Regular (1).ttf'))
      ..addFont(_fontData('assets/fonts/cairo/Cairo-Bold (1).ttf'));
    final materialIcons = FontLoader('MaterialIcons')
      ..addFont(_fontData('assets/fonts/MaterialIcons-Regular.otf'));
    await loader.load();
    await materialIcons.load();
  });

  testWidgets('renders dashboard screenshot', (tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(const DeliveryDemoApp());
    await tester.pumpAndSettle();

    await expectLater(
      find.byType(DashboardScreen),
      matchesGoldenFile('../assets/screenshots/dashboard.png'),
    );
  });

  testWidgets('renders tracking screenshot', (tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(const DeliveryDemoApp());
    await tester.tap(find.text('View live route'));
    await tester.pumpAndSettle();

    await expectLater(
      find.byType(TrackingScreen),
      matchesGoldenFile('../assets/screenshots/tracking.png'),
    );
  });
}

Future<ByteData> _fontData(String path) async {
  final bytes = await File(path).readAsBytes();
  return ByteData.sublistView(bytes);
}
