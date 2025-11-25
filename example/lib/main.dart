import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

import 'blur_transition.dart';
import 'custom_toast_content_widget.dart';

void main() {
  debugPaintSizeEnabled = false;
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  bool showPerformance = false;

  onSettingCallback() {
    setState(() {
      showPerformance = !showPerformance;
    });
  }

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Styled Toast Example';
    return MaterialApp(
      title: appTitle,
      showPerformanceOverlay: showPerformance,
      home: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return MyHomePage(
            title: appTitle,
            onSetting: onSettingCallback,
          );
        },
      ),
      builder: (BuildContext context, Widget? child) {
        final isDarkMode =
            MediaQuery.of(context).platformBrightness == Brightness.dark;

        return StyledToast(
          textStyle: TextStyle(
              fontSize: 16.0, color: isDarkMode ? Colors.black : Colors.white),
          backgroundColor:
              isDarkMode ? const Color(0xCCFFFFFF) : const Color(0x99000000),
          borderRadius: BorderRadius.circular(5.0),
          textPadding:
              const EdgeInsets.symmetric(horizontal: 17.0, vertical: 10.0),
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
          child: child ?? const SizedBox.shrink(),
        );
      },
    );
  }
}

// The StatefulWidget's job is to take in some data and create a State class.
// In this case, the Widget takes a title, and creates a MyHomePageState.
class MyHomePage extends StatefulWidget {
  final String? title;

  final VoidCallback? onSetting;

  const MyHomePage({Key? key, this.title, this.onSetting}) : super(key: key);

  @override
  MyHomePageState createState() => MyHomePageState();
}

// The State class is responsible for two things: holding some data you can
// update and building the UI using that data.
class MyHomePageState extends State<MyHomePage>
    with TickerProviderStateMixin<MyHomePage> {
  // Whether the green box should be visible or invisible

  String dismissRemind = '';

  TextEditingController controller = TextEditingController();

  late AnimationController mController;

  late AnimationController mReverseController;

  @override
  void initState() {
    super.initState();
    mController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    mReverseController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title ?? ''),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              widget.onSetting?.call();
            },
          )
        ],
      ),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
          children: <Widget>[
            TextField(
              controller: TextEditingController(),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 10.0),
              padding: const EdgeInsets.only(left: 15.0),
              height: 35.0,
              alignment: Alignment.centerLeft,
              child: const Text('Normal Toast'),
              color: const Color(0xFFDDDDDD),
            ),

            ListTile(
              title: const Text('Normal toast'),
              onTap: () {
                showToast('This is toast',
                    context: context,
                    axis: Axis.horizontal,
                    alignment: Alignment.center,
                    position: StyledToastPosition.bottom);
              },
            ),
            const Divider(
              height: 0.5,
            ),
            ListTile(
              title: const Text('Permanent toast'),
              onTap: () {
                showToast(
                  'This is a permanent toast',
                  context: context,
                  duration: Duration.zero,
                );
              },
            ),
            const Divider(
              height: 0.5,
            ),
            ListTile(
              title: const Text('Normal toast full width'),
              onTap: () {
                showToast(
                  'This is normal',
                  context: context,
                  axis: Axis.horizontal,
                  alignment: Alignment.center,
                  position: StyledToastPosition.bottom,
                  borderRadius: BorderRadius.zero,
                  toastHorizontalMargin: 0,
                  fullWidth: true,
                );
              },
            ),
            const Divider(
              height: 0.5,
            ),
            ListTile(
              title:
                  const Text('Normal toast full width with horizontal margin'),
              onTap: () {
                showToast(
                  'This is normal',
                  context: context,
                  axis: Axis.horizontal,
                  alignment: Alignment.center,
                  position: StyledToastPosition.bottom,
                  toastHorizontalMargin: 20,
                  fullWidth: true,
                );
              },
            ),
            const Divider(
              height: 0.5,
            ),
            ListTile(
              title: const Text(
                'Normal toast(custom borderRadius textStyle etc)',
              ),
              onTap: () {
                showToast('This is normal toast',
                    context: context,
                    textStyle:
                        const TextStyle(fontSize: 20.0, color: Colors.red),
                    backgroundColor: Colors.yellow,
                    textPadding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 30.0),
                    borderRadius: const BorderRadius.vertical(
                        top: Radius.elliptical(10.0, 20.0),
                        bottom: Radius.elliptical(10.0, 20.0)),
                    textAlign: TextAlign.justify,
                    textDirection: TextDirection.rtl);
              },
            ),
            const Divider(
              height: 0.5,
            ),
            ListTile(
              title: const Text(
                'Normal toast(position)',
              ),
              onTap: () {
                showToast('This is normal toast',
                    context: context,
                    alignment: Alignment.center,
                    position: const StyledToastPosition(
                        align: Alignment.bottomCenter, offset: 20.0));
              },
            ),
            const Divider(
              height: 0.5,
            ),
            ListTile(
              title: const Text(
                'Normal toast(custom position)',
              ),
              onTap: () {
                showToast('This is toast',
                    context: context,
                    toastHorizontalMargin: 10.0,
                    position: const StyledToastPosition(
                        align: Alignment.topLeft, offset: 20.0));
              },
            ),
            const Divider(
              height: 0.5,
            ),
            ListTile(
              title: const Text(
                'Normal toast(fade anim)',
              ),
              onTap: () {
                showToast('This is normal toast with fade animation',
                    context: context,
                    animation: StyledToastAnimation.fade,
                    curve: Curves.linear,
                    reverseCurve: Curves.linear);
              },
            ),
            const Divider(
              height: 0.5,
            ),
            ListTile(
              title: const Text(
                'Normal toast(slideFromTop anim)',
              ),
              onTap: () {
                showToast('This is normal toast with animation',
                    context: context,
                    animation: StyledToastAnimation.slideFromTop,
                    reverseAnimation: StyledToastAnimation.slideToTop,
                    position: StyledToastPosition.top,
                    startOffset: const Offset(0.0, -3.0),
                    reverseEndOffset: const Offset(0.0, -3.0),
                    duration: const Duration(seconds: 4),
                    //Animation duration   animDuration * 2 <= duration
                    animDuration: const Duration(seconds: 1),
                    curve: Curves.elasticOut,
                    reverseCurve: Curves.fastOutSlowIn);
              },
            ),
            const Divider(
              height: 0.5,
            ),
            ListTile(
              title: const Text(
                'Normal toast(slideFromTopFade anim)',
              ),
              onTap: () {
                showToast('This is normal toast with animation',
                    context: context,
                    animation: StyledToastAnimation.slideFromTopFade,
                    reverseAnimation: StyledToastAnimation.slideToTopFade,
                    position: const StyledToastPosition(
                        align: Alignment.topCenter, offset: 0.0),
                    startOffset: const Offset(0.0, -3.0),
                    reverseEndOffset: const Offset(0.0, -3.0),
                    duration: const Duration(seconds: 4),
                    //Animation duration   animDuration * 2 <= duration
                    animDuration: const Duration(seconds: 1),
                    curve: Curves.fastLinearToSlowEaseIn,
                    reverseCurve: Curves.fastOutSlowIn);
              },
            ),
            const Divider(
              height: 0.5,
            ),
            ListTile(
              title: const Text(
                'Normal toast(slideFromBottom anim)',
              ),
              onTap: () {
                showToast('This is normal toast with animation',
                    context: context,
                    animation: StyledToastAnimation.slideFromBottom,
                    reverseAnimation: StyledToastAnimation.slideToBottom,
                    startOffset: const Offset(0.0, 3.0),
                    reverseEndOffset: const Offset(0.0, 3.0),
                    position: StyledToastPosition.bottom,
                    duration: const Duration(seconds: 4),
                    //Animation duration   animDuration * 2 <= duration
                    animDuration: const Duration(seconds: 1),
                    curve: Curves.elasticOut,
                    reverseCurve: Curves.fastOutSlowIn);
              },
            ),
            const Divider(
              height: 0.5,
            ),
            ListTile(
              title: const Text(
                'Normal toast(slideFromBottomFade anim)',
              ),
              onTap: () {
                showToast('This is normal toast with animation',
                    context: context,
                    animation: StyledToastAnimation.slideFromBottomFade,
                    reverseAnimation: StyledToastAnimation.slideToBottomFade,
                    startOffset: const Offset(0.0, 3.0),
                    reverseEndOffset: const Offset(0.0, 3.0),
                    position: const StyledToastPosition(
                        align: Alignment.bottomCenter, offset: 0.0),
                    duration: const Duration(seconds: 4),
                    //Animation duration   animDuration * 2 <= duration
                    animDuration: const Duration(milliseconds: 400),
                    curve: Curves.linearToEaseOut,
                    reverseCurve: Curves.fastOutSlowIn);
              },
            ),
            const Divider(
              height: 0.5,
            ),
            ListTile(
              title: const Text(
                'normal toast(slideFromLeft anim)',
              ),
              onTap: () {
                showToast('This is normal toast with animation',
                    context: context,
                    animation: StyledToastAnimation.slideFromLeft,
                    reverseAnimation: StyledToastAnimation.slideToTop,
                    position: StyledToastPosition.top,
                    startOffset: const Offset(-1.0, 0.0),
                    reverseEndOffset: const Offset(-1.0, 0.0),
                    //Toast duration   animDuration * 2 <= duration
                    duration: const Duration(seconds: 4),
                    //Animation duration   animDuration * 2 <= duration
                    animDuration: const Duration(seconds: 1),
                    curve: Curves.elasticOut,
                    reverseCurve: Curves.fastOutSlowIn);
              },
            ),
            const Divider(
              height: 0.5,
            ),
            ListTile(
              title: const Text(
                'normal toast(slideFromLeftFade anim)',
              ),
              onTap: () {
                showToast('This is normal toast with animation',
                    context: context,
                    animation: StyledToastAnimation.slideFromLeftFade,
                    reverseAnimation: StyledToastAnimation.slideToTopFade,
                    toastHorizontalMargin: 0.0,
                    position: const StyledToastPosition(
                        align: Alignment.topLeft, offset: 20.0),
                    startOffset: const Offset(-1.0, 0.0),
                    reverseEndOffset: const Offset(-1.0, 0.0),
                    //Toast duration   animDuration * 2 <= duration
                    duration: const Duration(seconds: 4),
                    //Animation duration   animDuration * 2 <= duration
                    animDuration: const Duration(seconds: 1),
                    curve: Curves.linearToEaseOut,
                    reverseCurve: Curves.fastOutSlowIn);
              },
            ),
            const Divider(
              height: 0.5,
            ),
            ListTile(
              title: const Text(
                'Normal toast(slideFromRight anim)',
              ),
              onTap: () {
                showToast('This is normal toast with animation',
                    context: context,
                    animation: StyledToastAnimation.slideFromRight,
                    reverseAnimation: StyledToastAnimation.slideToRight,
                    position: StyledToastPosition.top,
                    startOffset: const Offset(1.0, 0.0),
                    reverseEndOffset: const Offset(1.0, 0.0),
                    animDuration: const Duration(seconds: 1),
                    duration: const Duration(seconds: 4),
                    curve: Curves.linearToEaseOut,
                    reverseCurve: Curves.fastOutSlowIn);
              },
            ),
            const Divider(
              height: 0.5,
            ),
            ListTile(
              title: const Text(
                'Normal toast(slideFromRightFade anim)',
              ),
              onTap: () {
                showToast('This is normal toast with animation',
                    context: context,
                    animation: StyledToastAnimation.slideFromRightFade,
                    reverseAnimation: StyledToastAnimation.slideToRightFade,
                    toastHorizontalMargin: 0.0,
                    position: const StyledToastPosition(
                        align: Alignment.topRight, offset: 20.0),
                    startOffset: const Offset(1.0, 0.0),
                    reverseEndOffset: const Offset(1.0, 0.0),
                    animDuration: const Duration(seconds: 1),
                    duration: const Duration(seconds: 4),
                    curve: Curves.linearToEaseOut,
                    reverseCurve: Curves.fastOutSlowIn);
              },
            ),
            const Divider(
              height: 0.5,
            ),
            ListTile(
              title: const Text(
                'normal toast(size anim)',
              ),
              onTap: () {
                showToast('This is normal toast with animation',
                    context: context,
                    animation: StyledToastAnimation.size,
                    reverseAnimation: StyledToastAnimation.size,
                    axis: Axis.horizontal,
                    position: StyledToastPosition.center,
                    animDuration: const Duration(milliseconds: 400),
                    duration: const Duration(seconds: 2),
                    curve: Curves.linear,
                    reverseCurve: Curves.linear);
              },
            ),
            const Divider(
              height: 0.5,
            ),
            ListTile(
              title: const Text(
                'normal toast(sizefade anim)',
              ),
              onTap: () {
                showToast('This is normal toast with animation',
                    context: context,
                    animation: StyledToastAnimation.sizeFade,
                    reverseAnimation: StyledToastAnimation.sizeFade,
                    axis: Axis.horizontal,
                    position: StyledToastPosition.center,
                    animDuration: const Duration(milliseconds: 400),
                    duration: const Duration(seconds: 2),
                    curve: Curves.linear,
                    reverseCurve: Curves.linear);
              },
            ),
            const Divider(
              height: 0.5,
            ),
            ListTile(
              title: const Text(
                'normal toast(scale anim)',
              ),
              onTap: () {
                showToast('This is normal toast with animation',
                    context: context,
                    animation: StyledToastAnimation.scale,
                    reverseAnimation: StyledToastAnimation.fade,
                    position: StyledToastPosition.center,
                    animDuration: const Duration(seconds: 1),
                    duration: const Duration(seconds: 4),
                    curve: Curves.elasticOut,
                    reverseCurve: Curves.linear);
              },
            ),
            const Divider(
              height: 0.5,
            ),
            ListTile(
              title: const Text(
                'Normal toast(fadeScale anim)',
              ),
              onTap: () {
                showToast('This is normal toast with animation',
                    context: context,
                    animation: StyledToastAnimation.fadeScale,
                    reverseAnimation: StyledToastAnimation.scaleRotate,
                    position: StyledToastPosition.center,
                    animDuration: const Duration(seconds: 1),
                    duration: const Duration(seconds: 4),
                    curve: Curves.linear,
                    reverseCurve: Curves.linear);
              },
            ),
            const Divider(
              height: 0.5,
            ),
            ListTile(
              title: const Text(
                'Normal toast(rotate anim)',
              ),
              onTap: () {
                showToast('This is normal toast with animation',
                    context: context,
                    animation: StyledToastAnimation.rotate,
                    reverseAnimation: StyledToastAnimation.fadeRotate,
                    position: StyledToastPosition.center,
                    animDuration: const Duration(seconds: 1),
                    duration: const Duration(seconds: 4),
                    curve: Curves.elasticOut,
                    reverseCurve: Curves.elasticIn);
              },
            ),
            const Divider(
              height: 0.5,
            ),
            ListTile(
              title: const Text(
                'Normal toast(fadeRotate anim)',
              ),
              onTap: () {
                showToast('This is normal toast with animation',
                    context: context,
                    animation: StyledToastAnimation.fadeRotate,
                    reverseAnimation: StyledToastAnimation.fadeScale,
                    position: StyledToastPosition.center,
                    animDuration: const Duration(seconds: 1),
                    duration: const Duration(seconds: 4),
                    curve: Curves.linear,
                    reverseCurve: Curves.linear);
              },
            ),
            const Divider(
              height: 0.5,
            ),
            ListTile(
              title: const Text(
                'Normal toast(scaleRotate anim)',
              ),
              onTap: () {
                showToast('This is normal toast with animation',
                    context: context,
                    animation: StyledToastAnimation.scaleRotate,
                    reverseAnimation: StyledToastAnimation.fade,
                    position: StyledToastPosition.center,
                    animDuration: const Duration(seconds: 1),
                    duration: const Duration(seconds: 4),
                    curve: Curves.elasticOut,
                    reverseCurve: Curves.linear);
              },
            ),
            const Divider(
              height: 0.5,
            ),
            ListTile(
              title: Text(
                'Normal toast with onDismissed($dismissRemind)',
              ),
              onTap: () {
                setState(() {
                  dismissRemind = '';
                });
                showToast(
                  'This is normal toast with onDismissed',
                  context: context,
                  animation: StyledToastAnimation.fade,
                  duration: const Duration(seconds: 2),
                  animDuration: const Duration(milliseconds: 1000),
                  onDismiss: () {
                    setState(() {
                      dismissRemind = 'dismissed';
                    });
                  },
                  curve: Curves.decelerate,
                  reverseCurve: Curves.linear,
                );
              },
            ),
            const Divider(
              height: 10,
              thickness: 10,
            ),
            ListTile(
              title: const Text(
                'Normal toast(custom anim)',
              ),
              onTap: () async {
                showToast(
                  'This is normal toast with custom animation',
                  context: context,
                  animationBuilder: (
                    BuildContext context,
                    AnimationController controller,
                    Duration duration,
                    Widget child,
                  ) {
                    return SlideTransition(
                      position: getAnimation<Offset>(const Offset(0.0, 3.0),
                          const Offset(0, 0), controller,
                          curve: Curves.bounceInOut),
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
                      position: getAnimation<Offset>(const Offset(0.0, 0.0),
                          const Offset(-3.0, 0), controller,
                          curve: Curves.bounceInOut),
                      child: child,
                    );
                  },
                  position: StyledToastPosition.bottom,
                  animDuration: const Duration(milliseconds: 1000),
                  duration: const Duration(seconds: 4),
                  curve: Curves.elasticOut,
                  reverseCurve: Curves.linear,
                );
              },
            ),
            const Divider(
              height: 0.5,
            ),
            ListTile(
              title: const Text(
                'Normal toast(custom multiple anim)',
              ),
              onTap: () async {
                showToast(
                  'This is normal toast with custom multiple animation',
                  context: context,
                  animationBuilder: (context, controller, duration, child) {
                    final scale = Tween<double>(begin: 1.3, end: 1.0).animate(
                      CurvedAnimation(
                          parent: controller,
                          curve: Curves.easeInSine,
                          reverseCurve: Curves.easeOutSine),
                    );
                    final sigma = Tween<double>(begin: 0.0, end: 8.0).animate(
                      CurvedAnimation(
                          parent: controller,
                          curve: Curves.easeInSine,
                          reverseCurve: Curves.easeOutSine),
                    );
                    final opacity = Tween<double>(begin: 0.0, end: 1.0).animate(
                      CurvedAnimation(
                          parent: controller,
                          curve: Curves.easeInSine,
                          reverseCurve: Curves.easeOutSine),
                    );
                    return ScaleTransition(
                        scale: scale,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: BlurTransition(
                              sigma: sigma,
                              child: FadeTransition(
                                opacity: opacity,
                                child: child,
                              ),
                            )));
                  },
                  reverseAnimBuilder: (context, controller, duration, child) {
                    final sigma = Tween<double>(begin: 10.0, end: 0.0).animate(
                      CurvedAnimation(
                          parent: controller,
                          curve: Curves.easeOutSine,
                          reverseCurve: Curves.easeInSine),
                    );
                    final opacity = Tween<double>(begin: 1.0, end: 0.0).animate(
                      CurvedAnimation(
                          parent: controller,
                          curve: Curves.easeOutSine,
                          reverseCurve: Curves.easeInSine),
                    );
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: BlurTransition(
                        sigma: sigma,
                        child: FadeTransition(
                          opacity: opacity,
                          child: child,
                        ),
                      ),
                    );
                  },
                  position: StyledToastPosition.bottom,
                  animDuration: const Duration(milliseconds: 1000),
                  duration: const Duration(seconds: 4),
                  curve: Curves.elasticOut,
                  reverseCurve: Curves.linear,
                );
              },
            ),
            const Divider(
              height: 0.5,
            ),
            ListTile(
              title: const Text(
                'Normal toast(custom anim with custom animation controller)',
              ),
              onTap: () async {
                showToast(
                  'This is normal toast with custom animation',
                  context: context,
                  onInitState:
                      (Duration toastDuration, Duration animDuration) async {
                    try {
                      await mController.forward().orCancel;
                      Future.delayed(toastDuration - animDuration, () async {
                        await mReverseController.forward().orCancel;
                        mController.reset();
                        mReverseController.reset();
                      });
                    } on TickerCanceled {
                      return;
                    }
                  },
                  animationBuilder: (
                    BuildContext context,
                    AnimationController controller,
                    Duration duration,
                    Widget child,
                  ) {
                    return SlideTransition(
                      position: getAnimation<Offset>(const Offset(0.0, 3.0),
                          const Offset(0, 0), mController,
                          curve: Curves.bounceInOut),
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
                      position: getAnimation<Offset>(const Offset(0.0, 0.0),
                          const Offset(-3.0, 0), mReverseController,
                          curve: Curves.bounceInOut),
                      child: child,
                    );
                  },
                  position: StyledToastPosition.bottom,
                  animDuration: const Duration(milliseconds: 1000),
                  duration: const Duration(seconds: 4),
                  curve: Curves.elasticOut,
                  reverseCurve: Curves.linear,
                );
              },
            ),

            ///Custom toast content widget
            Container(
              margin: const EdgeInsets.only(bottom: 10.0, top: 50.0),
              padding: const EdgeInsets.only(left: 15.0),
              height: 35.0,
              alignment: Alignment.centerLeft,
              child: const Text('Custom toast content widget'),
              color: const Color(0xFFDDDDDD),
            ),
            ListTile(
              title: const Text(
                'Custom toast content widget',
              ),
              onTap: () {
                showToastWidget(BannerToastWidget.fail(msg: 'Request failed'),
                    context: context,
                    animation: StyledToastAnimation.slideFromLeft,
                    reverseAnimation: StyledToastAnimation.slideToLeft,
                    alignment: Alignment.centerLeft,
                    axis: Axis.horizontal,
                    position: const StyledToastPosition(
                        align: Alignment.topCenter, offset: 0.0),
                    startOffset: const Offset(-1.0, 0.0),
                    reverseEndOffset: const Offset(-1.0, 0.0),
                    animDuration: const Duration(milliseconds: 400),
                    duration: const Duration(seconds: 2),
                    curve: Curves.linearToEaseOut,
                    reverseCurve: Curves.fastOutSlowIn);
              },
            ),
            const Divider(
              height: 0.5,
            ),
            ListTile(
              title: const Text('Interactive toast'),
              onTap: () {
                showToastWidget(
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    margin: const EdgeInsets.symmetric(horizontal: 50.0),
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      color: Colors.green[600],
                    ),
                    child: Row(
                      children: [
                        const Text(
                          'Jump to new page',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            dismissAllToast(showAnim: true);
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const SecondPage();
                            }));
                          },
                          icon: const Icon(
                            Icons.add_circle_outline_outlined,
                            color: Colors.white,
                          ),
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    ),
                  ),
                  context: context,
                  isIgnoring: false,
                  duration: Duration.zero,
                );
              },
            ),
            const Divider(
              height: 0.5,
            ),
            ListTile(
              title: const Text(
                'Custom toast content widget with icon convinient fail',
              ),
              onTap: () {
                showToastWidget(IconToastWidget.fail(msg: 'failed'),
                    context: context,
                    position: StyledToastPosition.center,
                    animation: StyledToastAnimation.scale,
                    reverseAnimation: StyledToastAnimation.fade,
                    duration: const Duration(seconds: 4),
                    animDuration: const Duration(seconds: 1),
                    curve: Curves.elasticOut,
                    reverseCurve: Curves.linear);
              },
            ),
            const Divider(
              height: 0.5,
            ),
            ListTile(
              title: const Text(
                'Custom toast content widget with icon convenient success',
              ),
              onTap: () {
                showToastWidget(IconToastWidget.success(msg: 'success'),
                    context: context,
                    position: StyledToastPosition.center,
                    animation: StyledToastAnimation.scale,
                    reverseAnimation: StyledToastAnimation.fade,
                    duration: const Duration(seconds: 4),
                    animDuration: const Duration(seconds: 1),
                    curve: Curves.elasticOut,
                    reverseCurve: Curves.linear);
              },
            ),
            const Divider(
              height: 0.5,
            ),
          ],
        ),
      ),
    );
  }
}

// The StatefulWidget's job is to take in some data and create a State class.
// In this case, the Widget takes a title, and creates a _MyHomePageState.
class SecondPage extends StatefulWidget {
  final String? title;

  const SecondPage({Key? key, this.title}) : super(key: key);

  @override
  SecondPageState createState() => SecondPageState();
}

// The State class is responsible for two things: holding some data you can
// update and building the UI using that data.
class SecondPageState extends State<SecondPage> {
  // Whether the green box should be visible or invisible

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<WidgetState> states) {
      const Set<WidgetState> interactiveStates = <WidgetState>{
        WidgetState.pressed,
        WidgetState.hovered,
        WidgetState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.red;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title ?? 'Second Page'),
      ),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(4),
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(bottom: 10.0),
              padding: const EdgeInsets.only(left: 15.0),
              height: 35.0,
              alignment: Alignment.centerLeft,
              child: const Text('second page Toast'),
              color: const Color(0xFFDDDDDD),
            ),
            Container(
              height: 50.0,
              margin: const EdgeInsets.only(bottom: 20.0),
              child: ElevatedButton(
                onPressed: () {
                  showToast(
                    'This is normal toast',
                  );
                },
                style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.resolveWith(getColor)),
                child: const Text(
                  'normal toast',
                  style: TextStyle(fontSize: 15.0, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
