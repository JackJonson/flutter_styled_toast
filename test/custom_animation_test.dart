import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('custom animation', () {
    testWidgets('CustomAnimation', (WidgetTester tester) async {
      final GlobalKey<CustomAnimationTestAppWidgetState> key = GlobalKey();
      final testAppWidget = CustomAnimationTestAppWidget(key: key);
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
        animationBuilder: (
          BuildContext context,
          AnimationController controller,
          Duration duration,
          Widget child,
        ) {
          return SlideTransition(
            position: getAnimation<Offset>(
              const Offset(0.0, 3.0),
              const Offset(0, 0),
              key.currentState!.animationController,
              curve: Curves.bounceInOut,
            ),
            child: child,
          );
        },
        reverseAnimBuilder: (
          BuildContext context,
          AnimationController controller,
          Duration duration,
          Widget child,
        ) {
          return SlideTransition(
            position: getAnimation<Offset>(
              const Offset(0.0, 0.0),
              const Offset(-3.0, 0),
              key.currentState!.reverseAnimationController,
              curve: Curves.bounceInOut,
            ),
            child: child,
          );
        },
      );
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.text('custom widget'), findsOneWidget);

      await tester.pump(const Duration(seconds: 4));

      expect(find.text('custom widget'), findsNothing);
    });
  });
}

class CustomAnimationTestAppWidget extends StatefulWidget {
  const CustomAnimationTestAppWidget({super.key});

  @override
  CustomAnimationTestAppWidgetState createState() =>
      CustomAnimationTestAppWidgetState();
}

class CustomAnimationTestAppWidgetState
    extends State<CustomAnimationTestAppWidget> with TickerProviderStateMixin {
  late AnimationController _mController;
  late AnimationController _mReverseController;

  AnimationController get animationController => _mController;
  AnimationController get reverseAnimationController => _mReverseController;

  @override
  void initState() {
    super.initState();

    _mController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _mReverseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
  }

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Styled Toast Example';
    return StyledToast(
      textStyle: const TextStyle(fontSize: 16.0, color: Colors.white),
      backgroundColor: const Color(0x99000000),
      borderRadius: BorderRadius.circular(5.0),
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
      fullWidth: false,
      isHideKeyboard: false,
      isIgnoring: true,
      child: MaterialApp(
        title: appTitle,
        home: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Container(
              color: Colors.blue,
            );
          },
        ),
      ),
    );
  }
}
