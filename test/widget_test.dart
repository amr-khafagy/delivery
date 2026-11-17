import 'package:delivery/core/services/services.dart';
import 'package:delivery/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() async {
    Get.testMode = true;
    Get.reset();
    SharedPreferences.setMockInitialValues({'language': 'en'});
    await Get.putAsync(() => MyServices().init());
  });

  tearDown(Get.reset);

  Future<void> pumpDemo(WidgetTester tester) async {
    tester.view.physicalSize = const Size(360, 690);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();
  }

  testWidgets('demo mode opens the original pending orders screen',
      (WidgetTester tester) async {
    await pumpDemo(tester);

    expect(find.text('Order Number:#3028'), findsOneWidget);
  });

  testWidgets('demo mode opens the original accepted orders screen',
      (WidgetTester tester) async {
    await pumpDemo(tester);
    await tester.tap(find.text('accept orders'));
    await tester.pumpAndSettle();

    expect(find.text('Order Number:#3019'), findsOneWidget);
  });
}
