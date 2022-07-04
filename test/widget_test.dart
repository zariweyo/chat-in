// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:hive_test/hive_test.dart';
import 'package:mockito/mockito.dart';

import 'mock_my_app.dart';
import 'mock_start_app.dart';

class MockBuildContext extends Mock implements BuildContext {}

@GenerateMocks([])
void main() {
  late MockBuildContext mockContext;

  setUpAll(() {
    mockContext = MockBuildContext();
  });

  setUp(() async {
    await setUpTestHive();
    await MockStartApp.registers(mockContext);
  });
  
  testWidgets('Add new list', (WidgetTester tester) async {
        
    await tester.pumpWidget(const MockMyApp());

    await tester.pumpAndSettle();

    expect(find.textContaining("NEW"), findsNothing);

    await tester.tap(find.byIcon(Icons.add_circle));
    await tester.pump();

    expect(find.textContaining("NEW"), findsOneWidget);
  });
}
