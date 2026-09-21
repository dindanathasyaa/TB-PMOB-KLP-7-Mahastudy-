import 'package:flutter_test/flutter_test.dart';
import 'package:belajar_flutter/main.dart';

void main() {
  testWidgets('Mahastudy app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MahastudyApp());
    expect(find.text('Mahastudy'), findsOneWidget);
  });
}
