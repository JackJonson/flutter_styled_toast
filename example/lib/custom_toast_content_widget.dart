import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:drawing_animation/drawing_animation.dart';
import 'package:lottie_flutter/lottie_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;

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

class _TestToastWidgetState extends State<TestToastWidget>
    with TickerProviderStateMixin<TestToastWidget> {
  LottieComposition _composition;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    prepareAnimation();
  }

  prepareAnimation() async {
    _loadButtonPressed('assets/ic_success.json');
    _controller = new AnimationController(
      duration: const Duration(milliseconds: 1),
      vsync: this,
    );
    _controller.addListener(() => setState(() {}));

    setState(() {
      try {
        _controller.forward().orCancel;
      } on TickerCanceled {}
    });
  }

  void _loadButtonPressed(String assetName) {
    loadAsset(assetName).then((LottieComposition composition) {
      setState(() {
        _composition = composition;
        _controller.reset();
      });
    });
  }

  Future<LottieComposition> loadAsset(String assetName) async {
    return await rootBundle
        .loadString(assetName)
        .then<Map<String, dynamic>>((String data) => json.decode(data))
        .then((Map<String, dynamic> map) => new LottieComposition.fromMap(map));
  }

  @override
  void dispose() {
    super.dispose();
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
                child: Lottie(
                  composition: _composition,
                  controller: _controller,
                  size: Size(50, 50),
                ),
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
        assetName: 'assets/ic_fail.png',
      );

  factory IconToastWidget.success({String msg}) => IconToastWidget(
        message: msg,
        assetName: 'assets/ic_success.png',
      );

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _IconToastWidgetState();
  }
}

class _IconToastWidgetState extends State<IconToastWidget>
    with TickerProviderStateMixin<IconToastWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
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
                  child: Image.asset(
                    widget.assetName,
                    fit: BoxFit.fill,
                    width: 30,
                    height: 30,
                  ),
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
