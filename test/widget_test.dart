import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:picture_pop/main.dart';

void main() {
  testWidgets('checks an answer and moves to the next picture', (tester) async {
    await tester.pumpWidget(const PicturePopApp());

    expect(find.text('🍎'), findsOneWidget);
    await tester.enterText(find.byType(TextField), 'apple');
    await tester.tap(find.text('Check answer'));
    await tester.pump();

    expect(find.text('Great job! 🎉'), findsOneWidget);
    expect(find.text('1 / 6'), findsOneWidget);

    await tester.tap(find.textContaining('Next picture'));
    await tester.pump();
    expect(find.text('🚗'), findsOneWidget);
  });
}
