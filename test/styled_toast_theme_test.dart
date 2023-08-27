import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('StyledToastTheme', () {
    testWidgets('Create StyleToastTheme', (WidgetTester tester) async {
      const textStyle = TextStyle(fontSize: 16.0, color: Colors.white);
      const backgroundColor = Color(0x99000000);
      final borderRadius = BorderRadius.circular(5.0);
      const textPadding =
          EdgeInsets.symmetric(horizontal: 17.0, vertical: 10.0);
      const toastAnimation = StyledToastAnimation.size;
      const reverseAnimation = StyledToastAnimation.size;
      const startOffset = Offset(0.0, -1.0);
      const reverseEndOffset = Offset(0.0, -1.0);
      const duration = Duration(seconds: 4);
      const animDuration = Duration(seconds: 1);
      const alignment = Alignment.center;
      const toastPositions = StyledToastPosition.center;
      const curve = Curves.fastOutSlowIn;
      const reverseCurve = Curves.fastOutSlowIn;
      const dismissOtherOnShow = true;
      const fullWidth = false;
      const isHideKeyboard = false;
      const isIgnoring = true;
      final child = MaterialApp(
        home: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Container(
              width: 100,
              height: 100,
              color: Colors.blue,
              child: const Text('test1'),
            );
          },
        ),
      );

      final styledToastTheme = StyledToastTheme(
        //You have to set this parameters to your locale
        textStyle: textStyle,
        backgroundColor: backgroundColor,
        borderRadius: borderRadius,
        textPadding: textPadding,
        toastAnimation: toastAnimation,
        reverseAnimation: reverseAnimation,
        startOffset: startOffset,
        reverseEndOffset: reverseEndOffset,
        duration: duration,
        animDuration: animDuration,
        alignment: alignment,
        toastPositions: toastPositions,
        curve: curve,
        reverseCurve: reverseCurve,
        dismissOtherOnShow: dismissOtherOnShow,
        fullWidth: fullWidth,
        isHideKeyboard: isHideKeyboard,
        isIgnoring: isIgnoring,
        child: child,
      );
      await tester.pumpWidget(styledToastTheme);
      await tester.pump(const Duration(milliseconds: 1000));
      expect(styledToastTheme.textStyle,
          const TextStyle(fontSize: 16.0, color: Colors.white));
      expect(styledToastTheme.backgroundColor, const Color(0x99000000));
      expect(styledToastTheme.borderRadius, BorderRadius.circular(5.0));
      expect(styledToastTheme.textPadding,
          const EdgeInsets.symmetric(horizontal: 17.0, vertical: 10.0));
      expect(styledToastTheme.toastAnimation, StyledToastAnimation.size);
      expect(styledToastTheme.reverseAnimation, StyledToastAnimation.size);
      expect(styledToastTheme.startOffset, const Offset(0.0, -1.0));
      expect(styledToastTheme.reverseEndOffset, const Offset(0.0, -1.0));
      expect(styledToastTheme.duration, const Duration(seconds: 4));
      expect(styledToastTheme.animDuration, const Duration(seconds: 1));
      expect(styledToastTheme.alignment, Alignment.center);
      expect(styledToastTheme.toastPositions, StyledToastPosition.center);
      expect(styledToastTheme.curve, Curves.fastOutSlowIn);
      expect(styledToastTheme.reverseCurve, Curves.fastOutSlowIn);
      expect(styledToastTheme.dismissOtherOnShow, true);
      expect(styledToastTheme.fullWidth, false);
      expect(styledToastTheme.isHideKeyboard, false);
      expect(styledToastTheme.isIgnoring, true);
      expect(find.text('test1'), findsOneWidget);
    });
  });
}
