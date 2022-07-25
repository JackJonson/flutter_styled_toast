import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

import 'blur_transition.dart';
import 'custom_toast_content_widget.dart';

void main() {
  debugPaintSizeEnabled = false;
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
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
    // TODO: implement build
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
        showPerformanceOverlay: showPerformance,
        home: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return MyHomePage(
              title: appTitle,
              onSetting: onSettingCallback,
            );
          },
        ),
      ),
    );
  }
}

// The StatefulWidget's job is to take in some data and create a State class.
// In this case, the Widget takes a title, and creates a _MyHomePageState.
class MyHomePage extends StatefulWidget {
  final String? title;

  final VoidCallback? onSetting;

  MyHomePage({Key? key, this.title, this.onSetting}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

// The State class is responsible for two things: holding some data you can
// update and building the UI using that data.
class _MyHomePageState extends State<MyHomePage>
    with TickerProviderStateMixin<MyHomePage> {
  // Whether the green box should be visible or invisible

  String dismissRemind = '';

  TextEditingController controller = TextEditingController();

  late AnimationController mController;

  late AnimationController mReverseController;

  @override
  void initState() {
    super.initState();
    mController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    mReverseController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title ?? ''),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              widget.onSetting?.call();
            },
          )
        ],
      ),
      body: Center(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
          children: <Widget>[
            TextField(
              controller: TextEditingController(),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10.0),
              padding: EdgeInsets.only(left: 15.0),
              height: 35.0,
              alignment: Alignment.centerLeft,
              child: Text('Normal Toast'),
              color: const Color(0xFFDDDDDD),
            ),

            ListTile(
              title: Text('Normal toast'),
              onTap: () {
                showToast('This is toast',
                    context: context,
                    axis: Axis.horizontal,
                    alignment: Alignment.center,
                    position: StyledToastPosition.bottom);
              },
            ),
            Divider(
              height: 0.5,
            ),
            ListTile(
              title: Text('Permanent toast'),
              onTap: () {
                showToast(
                  'This is a permanent toast',
                  context: context,
                  duration: Duration.zero,
                );
              },
            ),
            Divider(
              height: 0.5,
            ),
            ListTile(
              title: Text('Normal toast full width'),
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
            Divider(
              height: 0.5,
            ),
            ListTile(
              title: Text('Normal toast full width with horizontal margin'),
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
            Divider(
              height: 0.5,
            ),
            ListTile(
              title: Text(
                "Normal toast(custom borderRadius textStyle etc)",
              ),
              onTap: () {
                showToast('This is normal toast',
                    context: context,
                    textStyle: TextStyle(fontSize: 20.0, color: Colors.red),
                    backgroundColor: Colors.yellow,
                    textPadding:
                        EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
                    borderRadius: BorderRadius.vertical(
                        top: Radius.elliptical(10.0, 20.0),
                        bottom: Radius.elliptical(10.0, 20.0)),
                    textAlign: TextAlign.justify,
                    textDirection: TextDirection.rtl);
              },
            ),
            Divider(
              height: 0.5,
            ),
            ListTile(
              title: Text(
                "Normal toast(position)",
              ),
              onTap: () {
                showToast('This is normal toast',
                    context: context,
                    alignment: Alignment.center,
                    position: StyledToastPosition(
                        align: Alignment.bottomCenter, offset: 20.0));
              },
            ),
            Divider(
              height: 0.5,
            ),
            ListTile(
              title: Text(
                "Normal toast(custom position)",
              ),
              onTap: () {
                showToast('This is toast',
                    context: context,
                    toastHorizontalMargin: 10.0,
                    position: StyledToastPosition(
                        align: Alignment.topLeft, offset: 20.0));
              },
            ),
            Divider(
              height: 0.5,
            ),
            ListTile(
              title: Text(
                "Normal toast(fade anim)",
              ),
              onTap: () {
                showToast('This is normal toast with fade animation',
                    context: context,
                    animation: StyledToastAnimation.fade,
                    curve: Curves.linear,
                    reverseCurve: Curves.linear);
              },
            ),
            Divider(
              height: 0.5,
            ),
            ListTile(
              title: Text(
                "Normal toast(slideFromTop anim)",
              ),
              onTap: () {
                showToast('This is normal toast with animation',
                    context: context,
                    animation: StyledToastAnimation.slideFromTop,
                    reverseAnimation: StyledToastAnimation.slideToTop,
                    position: StyledToastPosition.top,
                    startOffset: Offset(0.0, -3.0),
                    reverseEndOffset: Offset(0.0, -3.0),
                    duration: Duration(seconds: 4),
                    //Animation duration   animDuration * 2 <= duration
                    animDuration: Duration(seconds: 1),
                    curve: Curves.elasticOut,
                    reverseCurve: Curves.fastOutSlowIn);
              },
            ),
            Divider(
              height: 0.5,
            ),
            ListTile(
              title: Text(
                "Normal toast(slideFromTopFade anim)",
              ),
              onTap: () {
                showToast('This is normal toast with animation',
                    context: context,
                    animation: StyledToastAnimation.slideFromTopFade,
                    reverseAnimation: StyledToastAnimation.slideToTopFade,
                    position: StyledToastPosition(
                        align: Alignment.topCenter, offset: 0.0),
                    startOffset: Offset(0.0, -3.0),
                    reverseEndOffset: Offset(0.0, -3.0),
                    duration: Duration(seconds: 4),
                    //Animation duration   animDuration * 2 <= duration
                    animDuration: Duration(seconds: 1),
                    curve: Curves.fastLinearToSlowEaseIn,
                    reverseCurve: Curves.fastOutSlowIn);
              },
            ),
            Divider(
              height: 0.5,
            ),
            ListTile(
              title: Text(
                "Normal toast(slideFromBottom anim)",
              ),
              onTap: () {
                showToast('This is normal toast with animation',
                    context: context,
                    animation: StyledToastAnimation.slideFromBottom,
                    reverseAnimation: StyledToastAnimation.slideToBottom,
                    startOffset: Offset(0.0, 3.0),
                    reverseEndOffset: Offset(0.0, 3.0),
                    position: StyledToastPosition.bottom,
                    duration: Duration(seconds: 4),
                    //Animation duration   animDuration * 2 <= duration
                    animDuration: Duration(seconds: 1),
                    curve: Curves.elasticOut,
                    reverseCurve: Curves.fastOutSlowIn);
              },
            ),
            Divider(
              height: 0.5,
            ),
            ListTile(
              title: Text(
                "Normal toast(slideFromBottomFade anim)",
              ),
              onTap: () {
                showToast('This is normal toast with animation',
                    context: context,
                    animation: StyledToastAnimation.slideFromBottomFade,
                    reverseAnimation: StyledToastAnimation.slideToBottomFade,
                    startOffset: Offset(0.0, 3.0),
                    reverseEndOffset: Offset(0.0, 3.0),
                    position: StyledToastPosition(
                        align: Alignment.bottomCenter, offset: 0.0),
                    duration: Duration(seconds: 4),
                    //Animation duration   animDuration * 2 <= duration
                    animDuration: Duration(milliseconds: 400),
                    curve: Curves.linearToEaseOut,
                    reverseCurve: Curves.fastOutSlowIn);
              },
            ),
            Divider(
              height: 0.5,
            ),
            ListTile(
              title: Text(
                "normal toast(slideFromLeft anim)",
              ),
              onTap: () {
                showToast('This is normal toast with animation',
                    context: context,
                    animation: StyledToastAnimation.slideFromLeft,
                    reverseAnimation: StyledToastAnimation.slideToTop,
                    position: StyledToastPosition.top,
                    startOffset: Offset(-1.0, 0.0),
                    reverseEndOffset: Offset(-1.0, 0.0),
                    //Toast duration   animDuration * 2 <= duration
                    duration: Duration(seconds: 4),
                    //Animation duration   animDuration * 2 <= duration
                    animDuration: Duration(seconds: 1),
                    curve: Curves.elasticOut,
                    reverseCurve: Curves.fastOutSlowIn);
              },
            ),
            Divider(
              height: 0.5,
            ),
            ListTile(
              title: Text(
                "normal toast(slideFromLeftFade anim)",
              ),
              onTap: () {
                showToast('This is normal toast with animation',
                    context: context,
                    animation: StyledToastAnimation.slideFromLeftFade,
                    reverseAnimation: StyledToastAnimation.slideToTopFade,
                    toastHorizontalMargin: 0.0,
                    position: StyledToastPosition(
                        align: Alignment.topLeft, offset: 20.0),
                    startOffset: Offset(-1.0, 0.0),
                    reverseEndOffset: Offset(-1.0, 0.0),
                    //Toast duration   animDuration * 2 <= duration
                    duration: Duration(seconds: 4),
                    //Animation duration   animDuration * 2 <= duration
                    animDuration: Duration(seconds: 1),
                    curve: Curves.linearToEaseOut,
                    reverseCurve: Curves.fastOutSlowIn);
              },
            ),
            Divider(
              height: 0.5,
            ),
            ListTile(
              title: Text(
                "Normal toast(slideFromRight anim)",
              ),
              onTap: () {
                showToast('This is normal toast with animation',
                    context: context,
                    animation: StyledToastAnimation.slideFromRight,
                    reverseAnimation: StyledToastAnimation.slideToRight,
                    position: StyledToastPosition.top,
                    startOffset: Offset(1.0, 0.0),
                    reverseEndOffset: Offset(1.0, 0.0),
                    animDuration: Duration(seconds: 1),
                    duration: Duration(seconds: 4),
                    curve: Curves.linearToEaseOut,
                    reverseCurve: Curves.fastOutSlowIn);
              },
            ),
            Divider(
              height: 0.5,
            ),
            ListTile(
              title: Text(
                "Normal toast(slideFromRightFade anim)",
              ),
              onTap: () {
                showToast('This is normal toast with animation',
                    context: context,
                    animation: StyledToastAnimation.slideFromRightFade,
                    reverseAnimation: StyledToastAnimation.slideToRightFade,
                    toastHorizontalMargin: 0.0,
                    position: StyledToastPosition(
                        align: Alignment.topRight, offset: 20.0),
                    startOffset: Offset(1.0, 0.0),
                    reverseEndOffset: Offset(1.0, 0.0),
                    animDuration: Duration(seconds: 1),
                    duration: Duration(seconds: 4),
                    curve: Curves.linearToEaseOut,
                    reverseCurve: Curves.fastOutSlowIn);
              },
            ),
            Divider(
              height: 0.5,
            ),
            ListTile(
              title: Text(
                "normal toast(size anim)",
              ),
              onTap: () {
                showToast('This is normal toast with animation',
                    context: context,
                    animation: StyledToastAnimation.size,
                    reverseAnimation: StyledToastAnimation.size,
                    axis: Axis.horizontal,
                    position: StyledToastPosition.center,
                    animDuration: Duration(milliseconds: 400),
                    duration: Duration(seconds: 2),
                    curve: Curves.linear,
                    reverseCurve: Curves.linear);
              },
            ),
            Divider(
              height: 0.5,
            ),
            ListTile(
              title: Text(
                "normal toast(sizefade anim)",
              ),
              onTap: () {
                showToast('This is normal toast with animation',
                    context: context,
                    animation: StyledToastAnimation.sizeFade,
                    reverseAnimation: StyledToastAnimation.sizeFade,
                    axis: Axis.horizontal,
                    position: StyledToastPosition.center,
                    animDuration: Duration(milliseconds: 400),
                    duration: Duration(seconds: 2),
                    curve: Curves.linear,
                    reverseCurve: Curves.linear);
              },
            ),
            Divider(
              height: 0.5,
            ),
            ListTile(
              title: Text(
                "normal toast(scale anim)",
              ),
              onTap: () {
                showToast('This is normal toast with animation',
                    context: context,
                    animation: StyledToastAnimation.scale,
                    reverseAnimation: StyledToastAnimation.fade,
                    position: StyledToastPosition.center,
                    animDuration: Duration(seconds: 1),
                    duration: Duration(seconds: 4),
                    curve: Curves.elasticOut,
                    reverseCurve: Curves.linear);
              },
            ),
            Divider(
              height: 0.5,
            ),
            ListTile(
              title: Text(
                "Normal toast(fadeScale anim)",
              ),
              onTap: () {
                showToast('This is normal toast with animation',
                    context: context,
                    animation: StyledToastAnimation.fadeScale,
                    reverseAnimation: StyledToastAnimation.scaleRotate,
                    position: StyledToastPosition.center,
                    animDuration: Duration(seconds: 1),
                    duration: Duration(seconds: 4),
                    curve: Curves.linear,
                    reverseCurve: Curves.linear);
              },
            ),
            Divider(
              height: 0.5,
            ),
            ListTile(
              title: Text(
                "Normal toast(rotate anim)",
              ),
              onTap: () {
                showToast('This is normal toast with animation',
                    context: context,
                    animation: StyledToastAnimation.rotate,
                    reverseAnimation: StyledToastAnimation.fadeRotate,
                    position: StyledToastPosition.center,
                    animDuration: Duration(seconds: 1),
                    duration: Duration(seconds: 4),
                    curve: Curves.elasticOut,
                    reverseCurve: Curves.elasticIn);
              },
            ),
            Divider(
              height: 0.5,
            ),
            ListTile(
              title: Text(
                "Normal toast(fadeRotate anim)",
              ),
              onTap: () {
                showToast('This is normal toast with animation',
                    context: context,
                    animation: StyledToastAnimation.fadeRotate,
                    reverseAnimation: StyledToastAnimation.fadeScale,
                    position: StyledToastPosition.center,
                    animDuration: Duration(seconds: 1),
                    duration: Duration(seconds: 4),
                    curve: Curves.linear,
                    reverseCurve: Curves.linear);
              },
            ),
            Divider(
              height: 0.5,
            ),
            ListTile(
              title: Text(
                "Normal toast(scaleRotate anim)",
              ),
              onTap: () {
                showToast('This is normal toast with animation',
                    context: context,
                    animation: StyledToastAnimation.scaleRotate,
                    reverseAnimation: StyledToastAnimation.fade,
                    position: StyledToastPosition.center,
                    animDuration: Duration(seconds: 1),
                    duration: Duration(seconds: 4),
                    curve: Curves.elasticOut,
                    reverseCurve: Curves.linear);
              },
            ),
            Divider(
              height: 0.5,
            ),
            ListTile(
              title: Text(
                "Normal toast with onDismissed($dismissRemind)",
              ),
              onTap: () {
                setState(() {
                  dismissRemind = '';
                });
                showToast('This is normal toast with onDismissed',
                    context: context,
                    animation: StyledToastAnimation.fade,
                    //Toast duration   animDuration * 2 <= duration
                    duration: Duration(seconds: 2),
                    //Animation duration   animDuration * 2 <= duration
                    animDuration: Duration(milliseconds: 1000), onDismiss: () {
                  print('onDismissed');
                  setState(() {
                    dismissRemind = 'dismissed';
                  });
                }, curve: Curves.decelerate, reverseCurve: Curves.linear);
              },
            ),
            Divider(
              height: 10,
              thickness: 10,
            ),
            ListTile(
              title: Text(
                "Normal toast(custom anim)",
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
                      position: getAnimation<Offset>(
                          Offset(0.0, 3.0), Offset(0, 0), controller,
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
                      position: getAnimation<Offset>(
                          Offset(0.0, 0.0), Offset(-3.0, 0), controller,
                          curve: Curves.bounceInOut),
                      child: child,
                    );
                  },
                  position: StyledToastPosition.bottom,
                  animDuration: Duration(milliseconds: 1000),
                  duration: Duration(seconds: 4),
                  curve: Curves.elasticOut,
                  reverseCurve: Curves.linear,
                );
              },
            ),
            Divider(
              height: 0.5,
            ),
            ListTile(
              title: Text(
                "Normal toast(custom multiple anim)",
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
                  animDuration: Duration(milliseconds: 1000),
                  duration: Duration(seconds: 4),
                  curve: Curves.elasticOut,
                  reverseCurve: Curves.linear,
                );
              },
            ),
            Divider(
              height: 0.5,
            ),
            ListTile(
              title: Text(
                "Normal toast(custom anim with custom animation controller)",
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
                    } on TickerCanceled {}
                  },
                  animationBuilder: (
                    BuildContext context,
                    AnimationController controller,
                    Duration duration,
                    Widget child,
                  ) {
                    return SlideTransition(
                      position: getAnimation<Offset>(
                          Offset(0.0, 3.0), Offset(0, 0), mController,
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
                      position: getAnimation<Offset>(
                          Offset(0.0, 0.0), Offset(-3.0, 0), mReverseController,
                          curve: Curves.bounceInOut),
                      child: child,
                    );
                  },
                  position: StyledToastPosition.bottom,
                  animDuration: Duration(milliseconds: 1000),
                  duration: Duration(seconds: 4),
                  curve: Curves.elasticOut,
                  reverseCurve: Curves.linear,
                );
              },
            ),

            ///Custom toast content widget
            Container(
              margin: EdgeInsets.only(bottom: 10.0, top: 50.0),
              padding: EdgeInsets.only(left: 15.0),
              height: 35.0,
              alignment: Alignment.centerLeft,
              child: Text('Custom toast content widget'),
              color: const Color(0xFFDDDDDD),
            ),
            ListTile(
              title: Text(
                "Custom toast content widget",
              ),
              onTap: () {
                showToastWidget(BannerToastWidget.fail(msg: 'Request failed'),
                    context: context,
                    animation: StyledToastAnimation.slideFromLeft,
                    reverseAnimation: StyledToastAnimation.slideToLeft,
                    alignment: Alignment.centerLeft,
                    axis: Axis.horizontal,
                    position: StyledToastPosition(
                        align: Alignment.topCenter, offset: 0.0),
                    startOffset: Offset(-1.0, 0.0),
                    reverseEndOffset: Offset(-1.0, 0.0),
                    animDuration: Duration(milliseconds: 400),
                    duration: Duration(seconds: 2),
                    curve: Curves.linearToEaseOut,
                    reverseCurve: Curves.fastOutSlowIn);
              },
            ),
            Divider(
              height: 0.5,
            ),
            ListTile(
              title: Text('Interactive toast'),
              onTap: () {
                showToastWidget(
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 18.0),
                    margin: EdgeInsets.symmetric(horizontal: 50.0),
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      color: Colors.green[600],
                    ),
                    child: Row(
                      children: [
                        Text(
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
                              return SecondPage();
                            }));
                          },
                          icon: Icon(
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
            Divider(
              height: 0.5,
            ),
            ListTile(
              title: Text(
                "Custom toast content widget with icon convinient fail",
              ),
              onTap: () {
                showToastWidget(IconToastWidget.fail(msg: 'failed'),
                    context: context,
                    position: StyledToastPosition.center,
                    animation: StyledToastAnimation.scale,
                    reverseAnimation: StyledToastAnimation.fade,
                    duration: Duration(seconds: 4),
                    animDuration: Duration(seconds: 1),
                    curve: Curves.elasticOut,
                    reverseCurve: Curves.linear);
              },
            ),
            Divider(
              height: 0.5,
            ),
            ListTile(
              title: Text(
                "Custom toast content widget with icon convenient success",
              ),
              onTap: () {
                showToastWidget(IconToastWidget.success(msg: 'success'),
                    context: context,
                    position: StyledToastPosition.center,
                    animation: StyledToastAnimation.scale,
                    reverseAnimation: StyledToastAnimation.fade,
                    duration: Duration(seconds: 4),
                    animDuration: Duration(seconds: 1),
                    curve: Curves.elasticOut,
                    reverseCurve: Curves.linear);
              },
            ),
            Divider(
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

  SecondPage({Key? key, this.title}) : super(key: key);

  @override
  _SecondPageState createState() => _SecondPageState();
}

// The State class is responsible for two things: holding some data you can
// update and building the UI using that data.
class _SecondPageState extends State<SecondPage> {
  // Whether the green box should be visible or invisible

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
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
          padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 10.0),
              padding: EdgeInsets.only(left: 15.0),
              height: 35.0,
              alignment: Alignment.centerLeft,
              child: Text('second page Toast'),
              color: const Color(0xFFDDDDDD),
            ),
            Container(
              height: 50.0,
              margin: EdgeInsets.only(bottom: 20.0),
              child: ElevatedButton(
                onPressed: () {
                  showToast(
                    'This is normal toast',
                  );
                },
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.resolveWith(getColor)),
                child: Text(
                  "normal toast",
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
