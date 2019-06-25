import 'package:flutter/material.dart';
import 'package:drawing_animation/drawing_animation.dart';
import 'package:fluttie/fluttie.dart';

///
///created time: 2019-06-25 16:42
///author linzhiliang
///version 1.0
///since
///file name: toast_content_widget.dart
///description: Toast with icon
///
class TestToastWidget extends StatefulWidget {
  final Key key;
  final Color backgroundColor;
  final String message;
  final Widget textWidget;
  final double offset;
  final double height;
  final double width;

  TestToastWidget(
      {this.key,
      this.backgroundColor,
      this.textWidget,
      this.message,
      this.height,
      this.width,
      Offset offset})
      : this.offset = offset == null ? 10 : offset,
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _TestToastWidgetState();
  }
}

class _TestToastWidgetState extends State<TestToastWidget> {
  bool run = false;

  FluttieAnimationController shockedEmoji;

  @override
  void initState() {
    super.initState();
    prepareAnimation();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    prepareAnimation();
  }

  prepareAnimation() async {
    // Checks if the platform we're running on is supported by the animation plugin
    bool canBeUsed = await Fluttie.isAvailable();
    if (!canBeUsed) {
      print("Animations are not supported on this platform");
      return;
    }

    var instance = Fluttie();

    // Load our first composition for the emoji animati`on
    var emojiComposition =
        await instance.loadAnimationFromAsset("assets/ic_success.json");
    // And prepare its animation, which should loop infinitely and take 2s per
    // iteration. Instead of RepeatMode.START_OVER, we could have choosen
    // REVERSE, which would play the animation in reverse on every second iteration.
    shockedEmoji = await instance.prepareAnimation(emojiComposition,
        duration: const Duration(seconds: 1),
        repeatCount: const RepeatCount.nTimes(0),
        repeatMode: RepeatMode.START_OVER);

    // Load the composition for our star animation. Notice how we only have to
    // load the composition once, even though we're using it for 5 animations!

    // Create the star animation with the default setting. 5 times. The
    // preferredSize needs to be set because the original star animation is quite
    // small. See the documentation for the method prepareAnimation for details.

    // Loading animations may take quite some time. We should check that the
    // widget is still used before updating it, it might have been removed while
    // we were loading our animations!
    if (mounted) {
      setState(() {
        shockedEmoji.stopAndReset(rewind: true);
        shockedEmoji.start(); //start our looped emoji animation
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    shockedEmoji?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Widget content = Material(
      color: Colors.transparent,
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: 80),
          padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 17.0),
          decoration: ShapeDecoration(
            color: widget.backgroundColor ?? const Color(0x9F000000),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                child:
//                AnimatedDrawing.svg("assets/ic_success.svg",
//                    run: this.run,
//                    duration: new Duration(milliseconds: 700),
//                    lineAnimation: LineAnimation.allAtOnce,
//                    onPaint: (index, path) {
//                      print('index:$index,path:${path.toString()}');
//                    },
//                    animationOrder: PathOrders.leftToRight,
//                    animationCurve: Curves.linear, onFinish: () {
//                  setState(() {
//                    this.run = false;
//                  });
//                }),
                    FluttieAnimation(shockedEmoji),
                width: 50,
                height: 50,
                margin: EdgeInsets.only(right: 10.0),
              ),
              widget.textWidget ??
                  Text(
                    widget.message ?? '',
                    style: TextStyle(
                        fontSize: Theme.of(context).textTheme.title.fontSize,
                        color: Colors.white),
                  ),
            ],
          )),
    );

    return content;
  }
}

///
///created time: 2019-06-25 16:42
///author linzhiliang
///version 1.0
///since
///file name: toast_content_widget.dart
///description: Toast with icon
///
class IconToastWidget extends StatefulWidget {
  final Key key;
  final Color backgroundColor;
  final String message;
  final Widget textWidget;
  final double offset;
  final double height;
  final double width;
  final String assetName;
  final EdgeInsetsGeometry padding;

  IconToastWidget(
      {this.key,
      this.backgroundColor,
      this.textWidget,
      this.message,
      this.height,
      this.width,
      @required this.assetName,
      this.padding,
      Offset offset})
      : this.offset = offset == null ? 10 : offset,
        super(key: key);

  factory IconToastWidget.fail({String msg}) => IconToastWidget(
        message: msg,
        assetName: 'assets/error.json',
      );

  factory IconToastWidget.success({String msg}) => IconToastWidget(
        message: msg,
        assetName: 'assets/ic_success.json',
      );

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _IconToastWidgetState();
  }
}

class _IconToastWidgetState extends State<IconToastWidget> {
  bool run = false;

  FluttieAnimationController fluttieController;

  @override
  void initState() {
    super.initState();
    prepareAnimation();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    prepareAnimation();
  }

  prepareAnimation() async {
    // Checks if the platform we're running on is supported by the animation plugin
    bool canBeUsed = await Fluttie.isAvailable();
    if (!canBeUsed) {
      print("Animations are not supported on this platform");
      return;
    }

    var instance = Fluttie();

    // Load our first composition for the emoji animati`on
    var emojiComposition = await instance
        .loadAnimationFromAsset(widget.assetName ?? 'assets/ic_success.json');
    // And prepare its animation, which should loop infinitely and take 2s per
    // iteration. Instead of RepeatMode.START_OVER, we could have choosen
    // REVERSE, which would play the animation in reverse on every second iteration.
    fluttieController = await instance.prepareAnimation(emojiComposition,
        duration: const Duration(seconds: 1),
        repeatCount: const RepeatCount.nTimes(0),
        repeatMode: RepeatMode.START_OVER);

    // Load the composition for our star animation. Notice how we only have to
    // load the composition once, even though we're using it for 5 animations!

    // Create the star animation with the default setting. 5 times. The
    // preferredSize needs to be set because the original star animation is quite
    // small. See the documentation for the method prepareAnimation for details.

    // Loading animations may take quite some time. We should check that the
    // widget is still used before updating it, it might have been removed while
    // we were loading our animations!
    if (mounted) {
      setState(() {
        fluttieController.stopAndReset(rewind: true);
        fluttieController.start(); //start our looped emoji animation
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    fluttieController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Widget content = Material(
      color: Colors.transparent,
      child: UnconstrainedBox(
        child: Container(
            padding: widget.padding ??
                EdgeInsets.symmetric(vertical: 30.0, horizontal: 17.0),
            decoration: ShapeDecoration(
              color: widget.backgroundColor ?? const Color(0x9F000000),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            alignment: Alignment.center,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  child:
//                AnimatedDrawing.svg("assets/ic_success.svg",
//                    run: this.run,
//                    duration: new Duration(milliseconds: 700),
//                    lineAnimation: LineAnimation.allAtOnce,
//                    onPaint: (index, path) {
//                      print('index:$index,path:${path.toString()}');
//                    },
//                    animationOrder: PathOrders.leftToRight,
//                    animationCurve: Curves.linear, onFinish: () {
//                  setState(() {
//                    this.run = false;
//                  });
//                }),
                      FluttieAnimation(fluttieController),
                  width: 50,
                  height: 50,
                  margin: EdgeInsets.only(right: 10.0),
                ),
                widget.textWidget ??
                    Text(
                      widget.message ?? '',
                      style: TextStyle(
                          fontSize: Theme.of(context).textTheme.title.fontSize,
                          color: Colors.white),
                    ),
              ],
            )),
      ),
    );

    return content;
  }
}
