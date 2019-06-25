import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

import 'custom_toast_content_widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Styled Toast Example';
    return StyledToast(
      //wrap your page with StyledToast
      textStyle: TextStyle(fontSize: 16.0, color: Colors.white),
      backgroundColor: Color(0x99000000),
      borderRadius: BorderRadius.circular(5.0),
      textPadding: EdgeInsets.symmetric(horizontal: 17.0, vertical: 10.0),
      dismissOtherOnShow: true,
      movingOnWindowChange: true,
      child: MaterialApp(
        title: appTitle,
        home: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return MyHomePage(title: appTitle);
          },
        ),
      ),
    );
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

  String dismissRemind = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.skip_next),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return SecondPage(title: 'Second Page Title');
                },
              ));
            },
          )
        ],
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
            ListTile(
              title: Text('Normal toast'),
              onTap: () {
                showToast(
                  'This is normal toast',
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
                showToast('This is normal toast with position',
                    position: StyledToastPosition.center);
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
                    animation: StyledToastAnimation.slideFromTop,
                    position: StyledToastPosition.top,
                    curve: ElasticOutCurve(0.9),
                    reverseCurve: Curves.linear);
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
                    animation: StyledToastAnimation.slideFromBottom,
                    position: StyledToastPosition.bottom,
                    curve: ElasticOutCurve(0.9),
                    reverseCurve: Curves.linear);
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
                    animation: StyledToastAnimation.slideFromLeft,
                    reverseAnimation: StyledToastAnimation.slideToTop,
                    position: StyledToastPosition.top,
                    //Toast duration   animDuration * 2 <= duration
                    duration: Duration(seconds: 4),
                    //Animation duration   animDuration * 2 <= duration
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
                "Normal toast(slideFromRight anim)",
              ),
              onTap: () {
                showToast('This is normal toast with animation',
                    animation: StyledToastAnimation.slideFromRight,
                    reverseAnimation: StyledToastAnimation.slideToLeft,
                    position: StyledToastPosition.top,
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
                "normal toast(scale anim)",
              ),
              onTap: () {
                showToast('This is normal toast with animation',
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
                    animation: StyledToastAnimation.fade,
                    //Toast duration   animDuration * 2 <= duration
                    duration: Duration(seconds: 4),
                    //Animation duration   animDuration * 2 <= duration
                    animDuration: Duration(seconds: 1), onDismiss: () {
                  print('onDismissed');
                  setState(() {
                    dismissRemind = 'dismissed';
                  });
                }, curve: Curves.decelerate, reverseCurve: Curves.linear);
              },
            ),
            Divider(
              height: 0.5,
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
                    position: StyledToastPosition.top,
                    animation: StyledToastAnimation.fadeRotate,
                    curve: Curves.linear,
                    reverseCurve: Curves.linear);
              },
            ),
            Divider(
              height: 0.5,
            ),
            ListTile(
              title: Text(
                "Custom toast content widget with icon ",
              ),
              onTap: () {
                showToastWidget(IconToastWidget(message: 'success'),
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
  final String title;

  SecondPage({Key key, this.title}) : super(key: key);

  @override
  _SecondPageState createState() => _SecondPageState();
}

// The State class is responsible for two things: holding some data you can
// update and building the UI using that data.
class _SecondPageState extends State<SecondPage> {
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
              child: Text('second page Toast'),
              color: const Color(0xFFDDDDDD),
            ),
            Container(
              height: 50.0,
              margin: EdgeInsets.only(bottom: 20.0),
              child: RaisedButton(
                onPressed: () {
                  showToast(
                    'This is normal toast',
                  );
                },
                color: Colors.blue,
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
