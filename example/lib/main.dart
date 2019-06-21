import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Styled Toast Example';
    return MaterialApp(
        title: appTitle,
        home: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
//            return StyledToast(
//                //wrap your app with StyledToast
//                textStyle: TextStyle(fontSize: 16.0, color: Colors.white),
//                backgroundColor: Color(0x99000000),
//                borderRadius: BorderRadius.circular(10.0),
//                textPadding:
//                    EdgeInsets.symmetric(horizontal: 17.0, vertical: 10.0),
//                dismissOtherOnShow: true,
//                movingOnWindowChange: true,
//                child: MyHomePage(title: appTitle));
            return MyHomePage(title: appTitle);
          },
        ));
  }
}

// The StatefulWidget's job is to take in some data and create a State class.
// In this case, the Widget takes a title, and creates a _MyHomePageState.
class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

// The State class is responsible for two things: holding some data you can
// update and building the UI using that data.
class _MyHomePageState extends State<MyHomePage> {
  // Whether the green box should be visible or invisible

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
              child: Text('Normal Toast'),
              color: const Color(0xFFDDDDDD),
            ),
            Container(
              height: 50.0,
              margin: EdgeInsets.only(bottom: 20.0),
              child: RaisedButton(
                onPressed: () {
                  showToast('This is normal toast',
                      context: context,
                      position: null,
                      duration: null,
                      animDuration: null,
                      textStyle: null,
                      textPadding: null,
                      backgroundColor: null,
                      borderRadius: null,
                      shapeBorder: null,
                      onDismiss: null,
                      textDirection: null,
                      dismissOtherToast: null,
                      movingOnWindowChange: null,
                      animation: null,
                      textAlign: null,
                      curve: null,
                      reverseCurve: null);
                },
                color: Colors.blue,
                child: Text(
                  "normal toast",
                  style: TextStyle(fontSize: 15.0, color: Colors.white),
                ),
              ),
            ),
            Container(
              height: 50.0,
              margin: EdgeInsets.only(bottom: 20.0),
              child: RaisedButton(
                onPressed: () {
                  showToast('This is normal toast',
                      textStyle: TextStyle(fontSize: 36.0, color: Colors.red),
                      backgroundColor: Colors.yellow,
                      textPadding: EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 30.0),
                      borderRadius: BorderRadius.vertical(
                          top: Radius.elliptical(10.0, 20.0),
                          bottom: Radius.elliptical(10.0, 20.0)),
                      textAlign: TextAlign.justify,
                      textDirection: TextDirection.rtl);
                },
                color: Colors.blue,
                child: Text(
                  "normal toast(custom borderRadius textStyle etc)",
                  style: TextStyle(fontSize: 15.0, color: Colors.white),
                ),
              ),
            ),
            Container(
              height: 50.0,
              margin: EdgeInsets.only(bottom: 20.0),
              child: RaisedButton(
                onPressed: () {
                  showToast('This is normal toast with position',
                      position: StyledToastPosition.center);
                },
                color: Colors.blue,
                child: Text(
                  "normal toast(position)",
                  style: TextStyle(fontSize: 15.0, color: Colors.white),
                ),
              ),
            ),
            Container(
              height: 50.0,
              margin: EdgeInsets.only(bottom: 20.0),
              child: RaisedButton(
                onPressed: () {
                  showToast('This is normal toast with fade animation',
                      animation: StyledToastAnimation.fade,
                      curve: Curves.linear,
                      reverseCurve: Curves.linear);
                },
                color: Colors.blue,
                child: Text(
                  "normal toast(fade anim)",
                  style: TextStyle(fontSize: 15.0, color: Colors.white),
                ),
              ),
            ),
            Container(
              height: 50.0,
              margin: EdgeInsets.only(bottom: 20.0),
              child: RaisedButton(
                onPressed: () {
                  showToast('This is normal toast with animation',
                      animation: StyledToastAnimation.slideFromTop,
                      position: StyledToastPosition.top,
                      curve: ElasticOutCurve(0.9),
                      reverseCurve: Curves.linear);
                },
                color: Colors.blue,
                child: Text(
                  "normal toast(slideFromTop anim)",
                  style: TextStyle(fontSize: 15.0, color: Colors.white),
                ),
              ),
            ),
            Container(
              height: 50.0,
              margin: EdgeInsets.only(bottom: 20.0),
              child: RaisedButton(
                onPressed: () {
                  showToast('This is normal toast with animation',
                      animation: StyledToastAnimation.slideFromBottom,
                      position: StyledToastPosition.bottom,
                      curve: ElasticOutCurve(0.9),
                      reverseCurve: Curves.linear);
                },
                color: Colors.blue,
                child: Text(
                  "normal toast(slideFromBottom anim)",
                  style: TextStyle(fontSize: 15.0, color: Colors.white),
                ),
              ),
            ),
            Container(
              height: 50.0,
              margin: EdgeInsets.only(bottom: 20.0),
              child: RaisedButton(
                onPressed: () {
                  showToast('This is normal toast with animation',
                      animation: StyledToastAnimation.slideFromLeft,
                      position: StyledToastPosition.top,
                      //Toast duration   animDuration * 2 <= duration
                      duration: Duration(seconds: 4),
                      //Animation duration   animDuration * 2 <= duration
                      animDuration: Duration(seconds: 1),
                      curve: Curves.elasticOut,
                      reverseCurve: Curves.elasticIn);
                },
                color: Colors.blue,
                child: Text(
                  "normal toast(slideFromLeft anim)",
                  style: TextStyle(fontSize: 15.0, color: Colors.white),
                ),
              ),
            ),
            Container(
              height: 50.0,
              margin: EdgeInsets.only(bottom: 20.0),
              child: RaisedButton(
                onPressed: () {
                  showToast('This is normal toast with animation',
                      animation: StyledToastAnimation.slideFromRight,
                      position: StyledToastPosition.top,
                      animDuration: Duration(seconds: 1),
                      duration: Duration(seconds: 4),
                      curve: Curves.elasticOut,
                      reverseCurve: Curves.elasticIn);
                },
                color: Colors.blue,
                child: Text(
                  "normal toast(slideFromRight anim)",
                  style: TextStyle(fontSize: 15.0, color: Colors.white),
                ),
              ),
            ),
            Container(
              height: 50.0,
              margin: EdgeInsets.only(bottom: 20.0),
              child: RaisedButton(
                onPressed: () {
                  showToast('This is normal toast with animation',
                      animation: StyledToastAnimation.scale,
                      position: StyledToastPosition.center,
                      animDuration: Duration(seconds: 1),
                      duration: Duration(seconds: 4),
                      curve: Curves.elasticOut,
                      reverseCurve: Curves.linear);
                },
                color: Colors.blue,
                child: Text(
                  "normal toast(scale anim)",
                  style: TextStyle(fontSize: 15.0, color: Colors.white),
                ),
              ),
            ),
            Container(
              height: 50.0,
              margin: EdgeInsets.only(bottom: 20.0),
              child: RaisedButton(
                onPressed: () {
                  showToast('This is normal toast with animation',
                      animation: StyledToastAnimation.fadeScale,
                      position: StyledToastPosition.center,
                      animDuration: Duration(seconds: 1),
                      duration: Duration(seconds: 4),
                      curve: Curves.linear,
                      reverseCurve: Curves.linear);
                },
                color: Colors.blue,
                child: Text(
                  "normal toast(fadeScale anim)",
                  style: TextStyle(fontSize: 15.0, color: Colors.white),
                ),
              ),
            ),
            Container(
              height: 50.0,
              margin: EdgeInsets.only(bottom: 20.0),
              child: RaisedButton(
                onPressed: () {
                  showToast('This is normal toast with animation',
                      animation: StyledToastAnimation.rotate,
                      position: StyledToastPosition.center,
                      animDuration: Duration(seconds: 1),
                      duration: Duration(seconds: 4),
                      curve: Curves.elasticOut,
                      reverseCurve: Curves.elasticIn);
                },
                color: Colors.blue,
                child: Text(
                  "normal toast(rotate anim)",
                  style: TextStyle(fontSize: 15.0, color: Colors.white),
                ),
              ),
            ),
            Container(
              height: 50.0,
              margin: EdgeInsets.only(bottom: 20.0),
              child: RaisedButton(
                onPressed: () {
                  showToast('This is normal toast with animation',
                      animation: StyledToastAnimation.fadeRotate,
                      position: StyledToastPosition.center,
                      animDuration: Duration(seconds: 1),
                      duration: Duration(seconds: 4),
                      curve: Curves.linear,
                      reverseCurve: Curves.linear);
                },
                color: Colors.blue,
                child: Text(
                  "normal toast(fadeRotate anim)",
                  style: TextStyle(fontSize: 15.0, color: Colors.white),
                ),
              ),
            ),
            Container(
              height: 50.0,
              margin: EdgeInsets.only(bottom: 20.0),
              child: RaisedButton(
                onPressed: () {
                  showToast('This is normal toast with animation',
                      animation: StyledToastAnimation.scaleRotate,
                      position: StyledToastPosition.center,
                      animDuration: Duration(seconds: 1),
                      duration: Duration(seconds: 4),
                      curve: Curves.elasticOut,
                      reverseCurve: Curves.linear);
                },
                color: Colors.blue,
                child: Text(
                  "normal toast(scaleRotate anim)",
                  style: TextStyle(fontSize: 15.0, color: Colors.white),
                ),
              ),
            ),
            Container(
              height: 50.0,
              margin: EdgeInsets.only(bottom: 20.0),
              child: RaisedButton(
                onPressed: () {
                  showToast('This is normal toast with onDismissed',
                      animation: StyledToastAnimation.fade,
                      //Toast duration   animDuration * 2 <= duration
                      duration: Duration(seconds: 4),
                      //Animation duration   animDuration * 2 <= duration
                      animDuration: Duration(seconds: 1), onDismiss: () {
                    print('onDismissed');
                  }, curve: Curves.decelerate, reverseCurve: Curves.linear);
                },
                color: Colors.blue,
                child: Text(
                  "normal toast with onDismissed",
                  style: TextStyle(fontSize: 15.0, color: Colors.white),
                ),
              ),
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
            Container(
              height: 50.0,
              margin: EdgeInsets.only(bottom: 20.0),
              child: RaisedButton(
                onPressed: () {
                  showToastWidget(BannerToastWidget.fail(msg: 'Request failed'),
                      position: StyledToastPosition.top,
                      animation: StyledToastAnimation.fadeRotate,
                      curve: Curves.linear,
                      reverseCurve: Curves.linear);
                },
                color: Colors.blue,
                child: Text(
                  "custom toast content widget",
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
