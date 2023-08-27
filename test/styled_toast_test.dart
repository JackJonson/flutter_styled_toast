import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('StyleToastWidget', () {
    testWidgets('Create StyleToastWidget', (WidgetTester tester) async {
      const textStyle = TextStyle(fontSize: 16.0, color: Colors.white);
      const backgroundColor = Color(0x99000000);
      const borderRadius = BorderRadius.all(Radius.circular(5.0));
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

      final styledToast = StyledToast(
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
        locale: const Locale('en', 'US'),
        fullWidth: fullWidth,
        isHideKeyboard: isHideKeyboard,
        isIgnoring: isIgnoring,
        child: child,
      );
      await tester.pumpWidget(styledToast);
      await tester.pump(const Duration(milliseconds: 1000));
      expect(styledToast.locale, const Locale('en', 'US'));
      expect(styledToast.textStyle,
          const TextStyle(fontSize: 16.0, color: Colors.white));
      expect(styledToast.backgroundColor, const Color(0x99000000));
      expect(styledToast.borderRadius, BorderRadius.circular(5.0));
      expect(styledToast.textPadding,
          const EdgeInsets.symmetric(horizontal: 17.0, vertical: 10.0));
      expect(styledToast.toastAnimation, StyledToastAnimation.size);
      expect(styledToast.reverseAnimation, StyledToastAnimation.size);
      expect(styledToast.startOffset, const Offset(0.0, -1.0));
      expect(styledToast.reverseEndOffset, const Offset(0.0, -1.0));
      expect(styledToast.duration, const Duration(seconds: 4));
      expect(styledToast.animDuration, const Duration(seconds: 1));
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
        duration: const Duration(seconds: 4),
        animDuration: const Duration(seconds: 2),
        position: StyledToastPosition.bottom,
        textStyle: TextStyle(fontSize: 20, color: Colors.green[700]),
        textPadding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
        toastHorizontalMargin: 40,
        backgroundColor: Colors.black45,
        borderRadius: BorderRadius.circular(20),
        shapeBorder: RoundedRectangleBorder(
            side: const BorderSide(
                color: Colors.blue, width: 1.0, style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(5)),
        onDismiss: () {},
        textDirection: TextDirection.ltr,
        dismissOtherToast: true,
        animation: StyledToastAnimation.slideFromBottom,
        reverseAnimation: StyledToastAnimation.slideToLeftFade,
        alignment: Alignment.center,
        axis: Axis.horizontal,
        startOffset: const Offset(0, 1.0),
        endOffset: const Offset(0, 0),
        reverseStartOffset: const Offset(0, 0),
        reverseEndOffset: const Offset(-1, 0),
        textAlign: TextAlign.center,
        curve: Curves.decelerate,
        reverseCurve: Curves.linear,
        fullWidth: false,
        isHideKeyboard: true,
        isIgnoring: true,
      );
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.text('toast0'), findsOneWidget);

      await tester.pump(const Duration(seconds: 4));

      expect(find.text('toast0'), findsNothing);
    });

    testWidgets('showToastWidget', (WidgetTester tester) async {
      final GlobalKey<TestAppWidgetState> key = GlobalKey();
      final testAppWidget = TestAppWidget(key: key);
      await tester.pumpWidget(testAppWidget);
      showToastWidget(
        const Text('custom widget'),
        duration: const Duration(seconds: 4),
        animDuration: const Duration(seconds: 2),
        position: StyledToastPosition.bottom,
        onDismiss: () {},
        textDirection: TextDirection.ltr,
        dismissOtherToast: true,
        animation: StyledToastAnimation.slideFromBottom,
        reverseAnimation: StyledToastAnimation.slideToLeftFade,
        alignment: Alignment.center,
        axis: Axis.horizontal,
        startOffset: const Offset(0, 1.0),
        endOffset: const Offset(0, 0),
        reverseStartOffset: const Offset(0, 0),
        reverseEndOffset: const Offset(-1, 0),
        curve: Curves.decelerate,
        reverseCurve: Curves.linear,
        isHideKeyboard: true,
        isIgnoring: true,
      );
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.text('custom widget'), findsOneWidget);

      await tester.pump(const Duration(seconds: 4));

      expect(find.text('custom widget'), findsNothing);
    });

    testWidgets('CustomAnimation', (WidgetTester tester) async {
      final GlobalKey<TestAppWidgetState> key = GlobalKey();
      final testAppWidget = TestAppWidget(key: key);
      await tester.pumpWidget(testAppWidget);
      showToastWidget(
        const Text('custom widget'),
        duration: const Duration(seconds: 4),
        animDuration: const Duration(seconds: 2),
        position: StyledToastPosition.bottom,
        onDismiss: () {},
        textDirection: TextDirection.ltr,
        dismissOtherToast: true,
        animation: StyledToastAnimation.slideFromBottom,
        reverseAnimation: StyledToastAnimation.slideToLeftFade,
        alignment: Alignment.center,
        axis: Axis.horizontal,
        startOffset: const Offset(0, 1.0),
        endOffset: const Offset(0, 0),
        reverseStartOffset: const Offset(0, 0),
        reverseEndOffset: const Offset(-1, 0),
        curve: Curves.decelerate,
        reverseCurve: Curves.linear,
        isHideKeyboard: true,
        isIgnoring: true,
      );
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.text('custom widget'), findsOneWidget);

      await tester.pump(const Duration(seconds: 4));

      expect(find.text('custom widget'), findsNothing);
    });
  });
}

class TestAppWidget extends StatefulWidget {
  final OverlayEntry? overlayEntry;

  const TestAppWidget({super.key, this.overlayEntry});

  @override
  TestAppWidgetState createState() => TestAppWidgetState();
}

class TestAppWidgetState extends State<TestAppWidget> {
  late BuildContext _context;

  void insertEntry() {
    if (widget.overlayEntry != null) {
      Overlay.of(_context).insert(widget.overlayEntry!);
    }
  }

  StyledToastTheme? getStyleToastTheme() {
    return StyledToastTheme.maybeOf(_context);
  }

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Styled Toast Example';
    return StyledToast(
      textStyle: const TextStyle(fontSize: 16.0, color: Colors.white),
      backgroundColor: const Color(0x99000000),
      borderRadius: const BorderRadius.all(Radius.circular(5.0)),
      textPadding: const EdgeInsets.symmetric(horizontal: 17.0, vertical: 10.0),
      toastAnimation: StyledToastAnimation.size,
      reverseAnimation: StyledToastAnimation.size,
      startOffset: const Offset(0.0, -1.0),
      reverseEndOffset: const Offset(0.0, -1.0),
      duration: const Duration(seconds: 4),
      animDuration: const Duration(seconds: 1),
      alignment: Alignment.center,
      toastPositions: StyledToastPosition.center,
      curve: Curves.fastOutSlowIn,
      reverseCurve: Curves.fastOutSlowIn,
      dismissOtherOnShow: true,
      locale: const Locale('en', 'US'),
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
