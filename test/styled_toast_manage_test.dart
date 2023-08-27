import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_test/flutter_test.dart';

import 'styled_toast_test.dart';

void main() {
  group('ToastFuture', () {
    testWidgets('Create, store and dismiss a toast future',
        (WidgetTester tester) async {
      OverlayEntry entry = OverlayEntry(builder: (BuildContext context) {
        return const Text('toast future');
      });
      final GlobalKey<TestAppWidgetState> key = GlobalKey();
      final testAppWidget = TestAppWidget(overlayEntry: entry, key: key);
      await tester.pumpWidget(testAppWidget);

      ToastFuture toastFuture = ToastFuture.create(const Duration(seconds: 4), entry,
          () {}, GlobalKey(debugLabel: 'toast future global key'));
      final toastManager = ToastManager();
      toastManager.addFuture(toastFuture);

      key.currentState?.insertEntry();

      ///After inserting entry, need to trigger a new frame to paint the overlay entry.
      await tester.pump();

      expect(find.text('toast future'), findsOneWidget);

      expect(entry.mounted, true);

      toastFuture.dismiss(showAnim: true);

      await tester.pump(const Duration(seconds: 4));
      await tester.pump(const Duration(milliseconds: 100));

      expect(entry.mounted, false);
    });
  });
  group('ToastManager', () {
    testWidgets('Add and remove ToastFuture', (WidgetTester tester) async {
      OverlayEntry entry = OverlayEntry(builder: (BuildContext context) {
        return const Text('toast future');
      });
      final GlobalKey<TestAppWidgetState> key = GlobalKey();
      final testAppWidget = TestAppWidget(overlayEntry: entry, key: key);
      await tester.pumpWidget(testAppWidget);

      ToastFuture toastFuture = ToastFuture.create(const Duration(seconds: 4), entry,
          () {}, GlobalKey(debugLabel: 'toast future global key'));

      key.currentState?.insertEntry();
      toastFuture.dismiss(showAnim: true);

      expect(ToastManager().toastSet.length, 0);

      ToastManager().addFuture(toastFuture);
      expect(ToastManager().toastSet.length, 1);
      ToastManager().removeFuture(toastFuture);
      expect(ToastManager().toastSet.length, 0);
    });

    testWidgets('All toast should be dismissed', (WidgetTester tester) async {
      final GlobalKey<TestAppWidgetState> key = GlobalKey();
      final testAppWidget = TestAppWidget(key: key);
      await tester.pumpWidget(testAppWidget);
      for (int i = 0; i < 4; i++) {
        showToast('toast$i',
            dismissOtherToast: false, duration: const Duration(seconds: 10));
      }
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.text('toast0'), findsOneWidget);
      expect(find.text('toast1'), findsOneWidget);
      expect(find.text('toast2'), findsOneWidget);
      expect(find.text('toast3'), findsOneWidget);

      dismissAllToast();

      await tester.pump(const Duration(milliseconds: 100));

      expect(find.text('toast0'), findsNothing);
      expect(find.text('toast1'), findsNothing);
      expect(find.text('toast2'), findsNothing);
      expect(find.text('toast3'), findsNothing);

      for (int i = 4; i < 8; i++) {
        showToast('toast$i',
            dismissOtherToast: false, duration: const Duration(seconds: 10));
      }
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.text('toast4'), findsOneWidget);
      expect(find.text('toast5'), findsOneWidget);
      expect(find.text('toast6'), findsOneWidget);
      expect(find.text('toast7'), findsOneWidget);

      ToastManager().dismissAll(showAnim: true);

      await tester.pump(const Duration(milliseconds: 100));

      expect(find.text('toast4'), findsNothing);
      expect(find.text('toast5'), findsNothing);
      expect(find.text('toast6'), findsNothing);
      expect(find.text('toast7'), findsNothing);
    });
  });
}
