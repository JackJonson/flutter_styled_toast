import 'package:flutter/material.dart';

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
  final double height;
  final double width;

  TestToastWidget({
    this.key,
    this.backgroundColor,
    this.textWidget,
    this.message,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _TestToastWidgetState();
  }
}

class _TestToastWidgetState extends State<TestToastWidget> {
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
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: 80),
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 17.0),
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
                child: Image.asset(
                  'assets/ic_success.png',
                  fit: BoxFit.fill,
                  width: 30,
                  height: 30,
                ),
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
  final double height;
  final double width;
  final String assetName;
  final EdgeInsetsGeometry padding;

  IconToastWidget({
    this.key,
    this.backgroundColor,
    this.textWidget,
    this.message,
    this.height,
    this.width,
    @required this.assetName,
    this.padding,
  }) : super(key: key);

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
      child: Container(
          width: 150.0,
          height: 100.0,
          padding: widget.padding ??
              EdgeInsets.symmetric(vertical: 20.0, horizontal: 17.0),
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
    );

    return content;
  }
}
