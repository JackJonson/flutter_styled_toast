import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('custom size transition', () {
    var statusList = <AnimationStatus>[];
    testWidgets('Custom size transition', (WidgetTester tester) async {
      final child = MaterialApp(
        home: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return TestWidget(statusList.add);
          },
        ),
      );
      await tester.pumpWidget(child);
      await tester.pump(Duration(milliseconds: 10));
      await tester.pump(Duration(milliseconds: 1000));

      expect(statusList, [AnimationStatus.forward, AnimationStatus.completed]);
    });
  });
}

class TestWidget extends StatefulWidget {
  final Function(AnimationStatus value) valueCallback;

  TestWidget(this.valueCallback);

  @override
  _TestWidgetState createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController animationController;
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    animationController.addStatusListener((status) {
      widget.valueCallback(status);
    });
    animation = Tween(begin: 0.0, end: 1.0).animate(
      animationController,
    );
    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomSizeTransition(
      sizeFactor: animation,
      child: Container(
        width: 100,
        height: 100,
        color: Colors.blue,
        child: Text('test1'),
      ),
    );
  }
}
