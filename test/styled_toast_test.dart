import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('TestAppWidget has a styled toast global configuration', (WidgetTester tester) async {
    // Test code goes here.
    await tester.pumpWidget(TestAppWidget());
    // Create the Finders.
  });
}


class TestAppWidget extends StatefulWidget {
  @override
  _TestAppWidgetState createState() => _TestAppWidgetState();
}

class _TestAppWidgetState extends State<TestAppWidget> {
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
            return Container(color: Colors.blue,);
          },
        ),
      ),
    );
  }
}
