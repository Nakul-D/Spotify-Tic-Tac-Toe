import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app/gameWidgets/gameWidget.dart';

void main() {

  testWidgets('Play button test', (WidgetTester tester) async {

    await tester.pumpWidget(MaterialApp(home: GameWidget(width: 720, height: 1440)));

    expect(find.widgetWithText(GestureDetector, "Play"), findsOneWidget);

    await tester.tap(find.widgetWithText(GestureDetector, "Play"));
    await tester.pump();

    expect(find.widgetWithText(GestureDetector, "Play"), findsNothing);
    expect(find.byType(GridView), findsOneWidget);
  });

}