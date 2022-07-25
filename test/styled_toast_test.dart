import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('StyleToastWidget', () {
    testWidgets('Create StyleToastWidget', (WidgetTester tester) async {
      final locale = Locale('en', 'US');
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

      final styledToast = StyledToast(
        //You have to set this parameters to your locale
        locale: locale,
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
      await tester.pumpWidget(styledToast);
      await tester.pump(Duration(milliseconds: 1000));
      expect(styledToast.locale, Locale('en', 'US'));
      expect(styledToast.textStyle,
          TextStyle(fontSize: 16.0, color: Colors.white));
      expect(styledToast.backgroundColor, Color(0x99000000));
      expect(styledToast.borderRadius, BorderRadius.circular(5.0));
      expect(styledToast.textPadding,
          EdgeInsets.symmetric(horizontal: 17.0, vertical: 10.0));
      expect(styledToast.toastAnimation, StyledToastAnimation.size);
      expect(styledToast.reverseAnimation, StyledToastAnimation.size);
      expect(styledToast.startOffset, Offset(0.0, -1.0));
      expect(styledToast.reverseEndOffset, Offset(0.0, -1.0));
      expect(styledToast.duration, Duration(seconds: 4));
      expect(styledToast.animDuration, Duration(seconds: 1));
      expect(styledToast.alignment, Alignment.center);
      expect(styledToast.toastPositions, StyledToastPosition.center);
      expect(styledToast.curve, Curves.fastOutSlowIn);
      expect(styledToast.reverseCurve, Curves.fastOutSlowIn);
      expect(styledToast.dismissOtherOnShow, true);
      expect(styledToast.fullWidth, false);
      expect(styledToast.isHideKeyboard, false);
      expect(styledToast.isIgnoring, true);
      expect(find.text('test1'), findsOneWidget);
    });
  });

  group('show a toast', () {
    testWidgets('showToast', (WidgetTester tester) async {
      final GlobalKey<TestAppWidgetState> key = GlobalKey();
      final testAppWidget = TestAppWidget(key: key);
      await tester.pumpWidget(testAppWidget);
      showToast(
        'toast0',
        duration: Duration(seconds: 4),
        animDuration: Duration(seconds: 2),
        position: StyledToastPosition.bottom,
        textStyle: TextStyle(fontSize: 20, color: Colors.green[700]),
        textPadding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
        toastHorizontalMargin: 40,
        backgroundColor: Colors.black45,
        borderRadius: BorderRadius.circular(20),
        shapeBorder: RoundedRectangleBorder(
            side: BorderSide(
                color: Colors.blue, width: 1.0, style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(5)),
        onDismiss: () {},
        textDirection: TextDirection.ltr,
        dismissOtherToast: true,
        animation: StyledToastAnimation.slideFromBottom,
        reverseAnimation: StyledToastAnimation.slideToLeftFade,
        alignment: Alignment.center,
        axis: Axis.horizontal,
        startOffset: Offset(0, 1.0),
        endOffset: Offset(0, 0),
        reverseStartOffset: Offset(0, 0),
        reverseEndOffset: Offset(-1, 0),
        textAlign: TextAlign.center,
        curve: Curves.decelerate,
        reverseCurve: Curves.linear,
        fullWidth: false,
        isHideKeyboard: true,
        isIgnoring: true,
      );
      await tester.pump(Duration(milliseconds: 100));

      expect(find.text('toast0'), findsOneWidget);

      await tester.pump(Duration(seconds: 4));

      expect(find.text('toast0'), findsNothing);
    });

    testWidgets('showToastWidget', (WidgetTester tester) async {
      final GlobalKey<TestAppWidgetState> key = GlobalKey();
      final testAppWidget = TestAppWidget(key: key);
      await tester.pumpWidget(testAppWidget);
      showToastWidget(
        Container(
          child: Text('custom widget'),
        ),
        duration: Duration(seconds: 4),
        animDuration: Duration(seconds: 2),
        position: StyledToastPosition.bottom,
        onDismiss: () {},
        textDirection: TextDirection.ltr,
        dismissOtherToast: true,
        animation: StyledToastAnimation.slideFromBottom,
        reverseAnimation: StyledToastAnimation.slideToLeftFade,
        alignment: Alignment.center,
        axis: Axis.horizontal,
        startOffset: Offset(0, 1.0),
        endOffset: Offset(0, 0),
        reverseStartOffset: Offset(0, 0),
        reverseEndOffset: Offset(-1, 0),
        curve: Curves.decelerate,
        reverseCurve: Curves.linear,
        isHideKeyboard: true,
        isIgnoring: true,
      );
      await tester.pump(Duration(milliseconds: 100));

      expect(find.text('custom widget'), findsOneWidget);

      await tester.pump(Duration(seconds: 4));

      expect(find.text('custom widget'), findsNothing);
    });

    testWidgets('CustomAnimation', (WidgetTester tester) async {
      final GlobalKey<TestAppWidgetState> key = GlobalKey();
      final testAppWidget = TestAppWidget(key: key);
      await tester.pumpWidget(testAppWidget);
      showToastWidget(
        Container(
          child: Text('custom widget'),
        ),
        duration: Duration(seconds: 4),
        animDuration: Duration(seconds: 2),
        position: StyledToastPosition.bottom,
        onDismiss: () {},
        textDirection: TextDirection.ltr,
        dismissOtherToast: true,
        animation: StyledToastAnimation.slideFromBottom,
        reverseAnimation: StyledToastAnimation.slideToLeftFade,
        alignment: Alignment.center,
        axis: Axis.horizontal,
        startOffset: Offset(0, 1.0),
        endOffset: Offset(0, 0),
        reverseStartOffset: Offset(0, 0),
        reverseEndOffset: Offset(-1, 0),
        curve: Curves.decelerate,
        reverseCurve: Curves.linear,
        isHideKeyboard: true,
        isIgnoring: true,
      );
      await tester.pump(Duration(milliseconds: 100));

      expect(find.text('custom widget'), findsOneWidget);

      await tester.pump(Duration(seconds: 4));

      expect(find.text('custom widget'), findsNothing);
    });
  });
}

class TestAppWidget extends StatefulWidget {
  final OverlayEntry? overlayEntry;

  final GlobalKey<TestAppWidgetState> key;

  TestAppWidget({
    this.overlayEntry,
    required this.key,
  });

  @override
  TestAppWidgetState createState() => TestAppWidgetState();
}

class TestAppWidgetState extends State<TestAppWidget> {
  late BuildContext _context;

  void insertEntry() {
    if (widget.overlayEntry != null) {
      Overlay.of(_context)?.insert(widget.overlayEntry!);
    }
  }

  StyledToastTheme? getStyleToastTheme() {
    return StyledToastTheme.of(_context);
  }

  @override
  Widget build(BuildContext context) {
    final appTitle = 'Styled Toast Example';
    return StyledToast(
      locale: const Locale('en', 'US'),
      //You have to set this parameters to your locale
      textStyle: TextStyle(fontSize: 16.0, color: Colors.white),
      backgroundColor: Color(0x99000000),
      borderRadius: BorderRadius.circular(5.0),
      textPadding: EdgeInsets.symmetric(horizontal: 17.0, vertical: 10.0),
      toastAnimation: StyledToastAnimation.size,
      reverseAnimation: StyledToastAnimation.size,
      startOffset: Offset(0.0, -1.0),
      reverseEndOffset: Offset(0.0, -1.0),
      duration: Duration(seconds: 4),
      animDuration: Duration(seconds: 1),
      alignment: Alignment.center,
      toastPositions: StyledToastPosition.center,
      curve: Curves.fastOutSlowIn,
      reverseCurve: Curves.fastOutSlowIn,
      dismissOtherOnShow: true,
      fullWidth: false,
      isHideKeyboard: false,
      isIgnoring: true,
      child: MaterialApp(
        title: appTitle,
        home: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            _context = context;
            return Container(
              color: Colors.blue,
            );
          },
        ),
      ),
    );
  }
}
