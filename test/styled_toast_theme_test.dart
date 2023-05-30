import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('StyledToastTheme', () {
    testWidgets('Create StyleToastTheme', (WidgetTester tester) async {
      final textStyle = TextStyle(fontSize: 16.0, color: Colors.white);
      final backgroundColor = Color(0x99000000);
      final borderRadius = BorderRadius.circular(5.0);
      final textPadding =
          EdgeInsets.symmetric(horizontal: 17.0, vertical: 10.0);
      final toastAnimation = StyledToastAnimation.size;
      final reverseAnimation = StyledToastAnimation.size;
      final startOffset = Offset(0.0, -1.0);
      final reverseEndOffset = Offset(0.0, -1.0);
      final duration = Duration(seconds: 4);
      final animDuration = Duration(seconds: 1);
      final alignment = Alignment.center;
      final toastPositions = StyledToastPosition.center;
      final curve = Curves.fastOutSlowIn;
      final reverseCurve = Curves.fastOutSlowIn;
      final dismissOtherOnShow = true;
      final fullWidth = false;
      final isHideKeyboard = false;
      final isIgnoring = true;
      final child = MaterialApp(
        home: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Container(
              width: 100,
              height: 100,
              color: Colors.blue,
              child: Text('test1'),
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
      await tester.pump(Duration(milliseconds: 1000));
      expect(styledToastTheme.textStyle,
          TextStyle(fontSize: 16.0, color: Colors.white));
      expect(styledToastTheme.backgroundColor, Color(0x99000000));
      expect(styledToastTheme.borderRadius, BorderRadius.circular(5.0));
      expect(styledToastTheme.textPadding,
          EdgeInsets.symmetric(horizontal: 17.0, vertical: 10.0));
      expect(styledToastTheme.toastAnimation, StyledToastAnimation.size);
      expect(styledToastTheme.reverseAnimation, StyledToastAnimation.size);
      expect(styledToastTheme.startOffset, Offset(0.0, -1.0));
      expect(styledToastTheme.reverseEndOffset, Offset(0.0, -1.0));
      expect(styledToastTheme.duration, Duration(seconds: 4));
      expect(styledToastTheme.animDuration, Duration(seconds: 1));
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
