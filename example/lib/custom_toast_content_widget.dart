import 'package:flutter/material.dart';

///
///created time: 2019-06-25 16:42
///author linzhiliang
///version 1.5.0
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
          margin: EdgeInsets.symmetric(horizontal: 50.0),
          padding: widget.padding ??
              EdgeInsets.symmetric(vertical: 20.0, horizontal: 17.0),
          decoration: ShapeDecoration(
            color: widget.backgroundColor ?? const Color(0x9F000000),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          child: Wrap(
            alignment: WrapAlignment.spaceEvenly,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5.0),
                child: Image.asset(
                  widget.assetName,
                  fit: BoxFit.fill,
                  width: 30,
                  height: 30,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5.0),
                child: widget.textWidget ??
                    Text(
                      widget.message ?? '',
                      style: TextStyle(
                          fontSize: Theme.of(context).textTheme.title.fontSize,
                          color: Colors.white),
                      softWrap: true,
                      maxLines: 200,
                    ),
              ),
            ],
          )),
    );

    return content;
  }
}

///
///created time: 2019-06-17 16:22
///author linzhiliang
///version 1.5.0
///since
///file name: styled_toast.dart
///description: Banner type toast widget, example of custom toast content widget when you use [showToastWidget]
///
class BannerToastWidget extends StatelessWidget {
  final Key key;
  final Color backgroundColor;
  final String message;
  final Widget textWidget;
  final double offset;
  final double height;
  final double width;

  BannerToastWidget(
      {this.key,
      this.backgroundColor,
      this.textWidget,
      this.message,
      this.height,
      this.width,
      Offset offset})
      : this.offset = offset == null ? 10.0 : offset,
        super(key: key);

  factory BannerToastWidget.success(
          {String msg, Widget text, BuildContext context}) =>
      BannerToastWidget(
        backgroundColor: context != null
            ? Theme.of(context).toggleableActiveColor
            : Colors.green,
        message: msg,
        textWidget: text,
      );

  factory BannerToastWidget.fail(
          {String msg, Widget text, BuildContext context}) =>
      BannerToastWidget(
        backgroundColor: context != null
            ? Theme.of(context).errorColor
            : const Color(0xEFCC2E2E),
        message: msg,
        textWidget: text,
      );

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Widget content = Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(17.0),
      height: 60.0,
      alignment: Alignment.center,
      color: backgroundColor ?? Theme.of(context).backgroundColor,
      child: textWidget ??
          Text(
            message ?? '',
            style: TextStyle(
                fontSize: Theme.of(context).textTheme.title.fontSize,
                color: Colors.white),
          ),
    );

    return content;
  }
}
