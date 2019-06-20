import 'package:flutter/material.dart';

import 'package:flutter_styled_toast/src/styled_toast.dart';

///
///created time: 2019-06-17 16:22
///author linzhiliang
///version 1.0
///since
///file name: styled_toast.dart
///description: Banner type toast widget
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
      :this.offset = offset == null ? hp(2.0) : offset,super(key:key);


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
            : const Color(0xBFCC2E2E),
        message: msg,
        textWidget: text,
      );


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Widget content = Material(
      color: Colors.transparent,
      child: Container(
        width: wp(85),
        height: hp(10.0),
        decoration: ShapeDecoration(
          color: backgroundColor ?? Theme.of(context).backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        alignment: Alignment.center,
        child: textWidget ??
            Text(
              message ?? '',
              style: TextStyle(
                  fontSize: Theme.of(context).textTheme.title.fontSize,
                  color: Colors.white),
            ),
      ),
    );

    content = Container(
        width: wp(85),
        height: hp(12.0),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              width: wp(75),
              height: hp(10.0),
              decoration: ShapeDecoration(
                shadows: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10.0, // has the effect of softening the shadow
                    spreadRadius: 5.0, // has the effect of extending the shadow
                    offset: Offset(
                      0.0, // horizontal, move right 10
                      5.0, // vertical, move down 10
                    ),
                  )
                ],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            content,
          ],
        ));

    return content;
  }
}
