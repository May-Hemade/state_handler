import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:state_handler/state_handler.dart';

void main() {
  testWidgets('StateHandler shows loading widget when in loading state', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: StateHandler(
          state: ViewState.loading,
          content: Text("Loaded Content"),
        ),
      ),
    );

    // Check if CircularProgressIndicator (default loading widget) is present
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text("Loaded Content"), findsNothing);
  });

  testWidgets('StateHandler shows content when in content state', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: StateHandler(
          state: ViewState.content,
          content: Text("Loaded Content"),
        ),
      ),
    );

    // Content should be visible
    expect(find.text("Loaded Content"), findsOneWidget);
  });

  testWidgets('StateHandler shows error widget when in error state', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: StateHandler(
          state: ViewState.error,
          content: const Text("Loaded Content"),
        ),
      ),
    );

    // Check if default error message is shown
    expect(find.text("An error occurred"), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
  });

  testWidgets(
    'StateHandler shows network error widget when in network error state',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: StateHandler(
            state: ViewState.networkError,
            content: const Text("Loaded Content"),
          ),
        ),
      );

      // Check if default network error message is shown
      expect(find.text("No internet connection"), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    },
  );

  testWidgets('StateHandler retry button triggers onRetry callback', (
    WidgetTester tester,
  ) async {
    bool retried = false;

    await tester.pumpWidget(
      MaterialApp(
        home: StateHandler(
          state: ViewState.error,
          content: const Text("Loaded Content"),
          onRetry: () {
            retried = true;
          },
        ),
      ),
    );

    // Tap on Retry button
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    // Check if onRetry was called
    expect(retried, true);
  });
}
