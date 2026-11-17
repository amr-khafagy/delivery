import 'package:delivery/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('opens the active delivery route', (tester) async {
    await tester.pumpWidget(const DeliveryDemoApp());

    expect(find.text("Today's deliveries"), findsOneWidget);

    await tester.tap(find.text('View live route'));
    await tester.pumpAndSettle();

    expect(find.text('Live delivery route'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.text('Complete delivery'),
      250,
    );
    expect(find.text('Complete delivery'), findsOneWidget);
  });
}
