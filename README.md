# flutter_styled_toast

A Styled Toast Flutter package.
You can highly customize toast ever.
Beautify toast with a series of animations and make toast more beautiful.

## demo

<img src="https://raw.githubusercontent.com/JackJonson/flutter_styled_toast/master/screenshots/OverallAnimations.gif" width="50%">

## Null safety

```yaml
dependencies:
  flutter_styled_toast: ^2.2.1
```

## Getting Started

```yaml
dependencies:
  flutter_styled_toast: ^1.5.2+3
```

```dart
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
```

```dart
// Simple to use, no global configuration
showToast("hello styled toast", context: context);

// Customize toast content widget, no global configuration
showToastWidget(Text('hello styled toast'), context: context);
```

```dart
//Interactive toast, set [isIgnoring] false.
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
            ToastManager().dismissAll(showAnim: true);
            Navigator.push(context, MaterialPageRoute(builder: (context) {
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
```

```dart
//Set an animation
showToast('This is normal toast with animation',
   context: context,
   animation: StyledToastAnimation.scale,
);

///Set both animation and reverse animation,
///combination different animation and reverse animation to achieve amazing effect.
showToast('This is normal toast with animation',
   context: context,
   animation: StyledToastAnimation.scale,
   reverseAnimation: StyledToastAnimation.fade,
   position: StyledToastPosition.center,
   animDuration: Duration(seconds: 1),
   duration: Duration(seconds: 4),
   curve: Curves.elasticOut,
   reverseCurve: Curves.linear,
);

```

```dart
///Custom animation and custom reverse animation,
///combination different animation and reverse animation to achieve amazing effect.

AnimationController mController;
AnimationController mReverseController;

@override
void initState() {
  super.initState();
  mController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
    mReverseController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
}

showToast(
      'This is normal toast with custom animation',
      context: context,
      position: StyledToastPosition.bottom,
      animDuration: Duration(seconds: 1),
      duration: Duration(seconds: 4),
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
    );

```

```dart
///Custom animation, custom reverse animation and custom animation controller
showToast(
      'This is normal toast with custom animation and controller',
      context: context,
      position: StyledToastPosition.bottom,
      animDuration: Duration(seconds: 1),
      duration: Duration(seconds: 4),
      onInitState: (Duration toastDuration, Duration animDuration) async {
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
    );

```

Simple global configuration, wrap you app with StyledToast.

```dart
return StyledToast(
          textStyle: TextStyle(
              fontSize: 16.0,
              color: Colors.white), //Default text style of toast
          backgroundColor: Color(0x99000000), //Background color of toast
          borderRadius: BorderRadius.circular(5.0), //Border radius of toast
          textPadding: EdgeInsets.symmetric(
              horizontal: 17.0, vertical: 10.0), //The padding of toast text
          toastPositions: StyledToastPosition.bottom, //The position of toast
          toastAnimation:
              StyledToastAnimation.fade, //The animation type of toast
          reverseAnimation: StyledToastAnimation
              .fade, //The reverse animation of toast (display When dismiss toast)
          curve: Curves.fastOutSlowIn, //The curve of animation
          reverseCurve:
              Curves.fastLinearToSlowEaseIn, //The curve of reverse animation
          duration: Duration(
              seconds:
                  4), //The duration of toast showing, when set [duration] to Duration.zero, toast won't dismiss automatically.
          animDuration: Duration(
              seconds:
                  1), //The duration of animation(including reverse) of toast
          dismissOtherOnShow:
              true, //When we show a toast and other toast is showing, dismiss any other showing toast before.

          fullWidth:
              false, //Whether the toast is full screen (subtract the horizontal margin)
          isHideKeyboard: false, //Is hide keyboard when toast show
          isIgnoring: true, //Is the input ignored for the toast
          animationBuilder: (
            BuildContext context,
            AnimationController controller,
            Duration duration,
            Widget child,
          ) {
            // Builder method for custom animation
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
            // Builder method for custom reverse animation
            return SlideTransition(
              position: getAnimation<Offset>(
                  Offset(0.0, 0.0), Offset(-3.0, 0), controller,
                  curve: Curves.bounceInOut),
              child: child,
            );
          },
          child: child ?? const SizedBox.shrink(),
        );
      },
    );
```

```dart
//After global configuration, use in a single line.
showToast("hello styled toast");

//After global configuration, Customize toast content widget
showToastWidget(Text('hello styled toast'));
```

## 🚀 Roadmap

<table>
  <tr>
    <td align="center">
      <img src="https://raw.githubusercontent.com/JackJonson/flutter_styled_toast/master/screenshots/DefaultToastWidget.gif" width="260px">
      <br />
      DefaultToastWidget
      <br />
    </td>
    <td align="center">
      <img src="https://raw.githubusercontent.com/JackJonson/flutter_styled_toast/master/screenshots/FadeAnim.gif" width="260px">
      <br />
      FadeAnim
      <br />
    </td>
    <td align="center">
      <img src="https://raw.githubusercontent.com/JackJonson/flutter_styled_toast/master/screenshots/SlideFromTopAnim.gif" width="260px">
      <br />
      SlideFromTopAnim
      <br />
    </td>
  </tr>
  <tr>
    <td align="center">
      <img src="https://raw.githubusercontent.com/JackJonson/flutter_styled_toast/master/screenshots/SlideFromBottomAnim.gif" width="260px">
      <br />
      SlideFromBottomAnim
      <br />
    </td>
    <td align="center">
      <img src="https://raw.githubusercontent.com/JackJonson/flutter_styled_toast/master/screenshots/SlideFromLeftAnim.gif" width="260px">
      <br />
      SlideFromLeftAnim
      <br />
      </td>
    <td align="center">
      <img src="https://raw.githubusercontent.com/JackJonson/flutter_styled_toast/master/screenshots/SlideFromRightAnim.gif" width="260px">
      <br />
      SlideFromRightAnim
      <br />
    </td>
  </tr>
  <tr>
    <td align="center">
      <img src="https://raw.githubusercontent.com/JackJonson/flutter_styled_toast/master/screenshots/ScaleAnim.gif" width="260px">
      <br />
      ScaleAnim
      <br />
      </td>
    <td align="center">
      <img src="https://raw.githubusercontent.com/JackJonson/flutter_styled_toast/master/screenshots/FadeScaleAnim.gif" width="260px">
      <br />
      FadeScaleAnim
      <br />
    </td>
    <td align="center">
      <img src="https://raw.githubusercontent.com/JackJonson/flutter_styled_toast/master/screenshots/RotateAnim.gif" width="260px">
      <br />
      RotateAnim
      <br />
      </td>
  </tr>
  <tr>
    <td align="center">
      <img src="https://raw.githubusercontent.com/JackJonson/flutter_styled_toast/master/screenshots/FadeRotateAnim.gif" width="260px">
      <br />
      FadeRotateAnim
      <br />
      </td>
    <td align="center">
      <img src="https://raw.githubusercontent.com/JackJonson/flutter_styled_toast/master/screenshots/ScaleRotateAnim.gif" width="260px">
      <br />
      ScaleRotateAnim
      <br />
    </td>
    <td align="center">
      <img src="https://raw.githubusercontent.com/JackJonson/flutter_styled_toast/master/screenshots/OnDismiss.gif" width="260px">
      <br />
      OnDismiss
      <br />
    </td>
  </tr>
  <tr>
    <td align="center">
      <img src="https://raw.githubusercontent.com/JackJonson/flutter_styled_toast/master/screenshots/CustomToastWidget.gif" width="260px">
      <br />
      CustomToastWidget
      <br />
    </td>
    <td align="center">
      <img src="https://raw.githubusercontent.com/JackJonson/flutter_styled_toast/master/screenshots/CustomFailToastWidget.gif" width="260px">
      <br />
      CustomFailToastWidget
      <br />
    </td>
    <td align="center">
      <img src="https://raw.githubusercontent.com/JackJonson/flutter_styled_toast/master/screenshots/CustomSuccessToastWidget.gif" width="260px">
      <br />
      CustomSuccessToastWidget
      <br />
    </td>
  </tr>
</table>

### StyledToast param

property             | description
---------------------|----------------------------
locale               | Locale (Not Null)(required You have to set this parameters to your locale)
child                | Widget (Not Null)(required)
textAlign            | TextAlign (default TextAlign.center)
textDirection        | TextDirection (default TextDirection.ltr)  
borderRadius         | BorderRadius (BorderRadius.circular(5.0))
backgroundColor      | Color (default Color(0x99000000))
textPadding          | EdgeInsetsGeometry (default EdgeInsets.symmetric(horizontal: 17.0,vertical: 8.0))
toastHorizontalMargin| double (default 50.0)
textStyle            | TextStyle (default TextStyle(fontSize: 16.0,fontWeight: FontWeight.normal,color: Colors.white))
shapeBorder          | ShapeBorder (default RoundedRectangleBorder(borderRadius: borderRadius))
duration             | Duration (default 2.3s)(When set [duration] to Duration.zero, toast won't dismiss automatically)
animDuration         | Duration (default 400 milliseconds, animDuration * 2  <= duration, conditions must be met for toast to display properly)
toastPositions       | StyledToastPosition (default StyledToastPosition.bottom)
toastAnimation       | StyledToastAnimation (default StyledToastAnimation.fade)
reverseAnimation     | StyledToastAnimation
alignment            | AlignmentGeometry (default Alignment.center)
axis                 | Axis (default Axis.vertical)
startOffset          | Offset
endOffset            | Offset
reverseStartOffset   | Offset
reverseEndOffset     | Offset
curve                | Curve (default Curves.linear)
reverseCurve         | Curve (default Curves.linear)
dismissOtherOnShow   | bool (default true)
onDismiss            | VoidCallback (Invoked when toast dismiss)
fullWidth            | bool (default false)(Full width parameter that the width of the screen minus the width of the margin.)
isHideKeyboard       | bool (default false)(Is hide keyboard when toast show)
animationBuilder     | CustomAnimationBuilder (Builder method for custom animation)
reverseAnimBuilder   | CustomAnimationBuilder (Builder method for custom reverse animation)
isIgnoring           | bool (default true)
onInitState          | OnInitStateCallback (When toast widget [initState], this callback will be called)

### showToast param

property             | description
---------------------|----------------------------
msg                  | String (Not Null)(required)
context              | BuildContext (If you don't wrap app with StyledToast, context is required, otherwise, is not)
duration             | Duration (default 2.3s)(When set [duration] to Duration.zero, toast won't dismiss automatically)
animDuration         | Duration (default 400 milliseconds, animDuration * 2  <= duration, conditions must be met for toast to display properly)
position             | StyledToastPosition (default StyledToastPosition.bottom)
textStyle            | TextStyle (default TextStyle(fontSize: 16.0,fontWeight: FontWeight.normal,color: Colors.white))
textPadding          | EdgeInsetsGeometry (default EdgeInsets.symmetric(horizontal: 17.0,vertical: 8.0))
backgroundColor      | Color (default Color(0x99000000))
borderRadius         | BorderRadius (BorderRadius.circular(5.0))
shapeBorder          | ShapeBorder (default RoundedRectangleBorder(borderRadius: borderRadius))
onDismiss            | VoidCallback (Invoked when toast dismiss)
textDirection        | TextDirection (default TextDirection.ltr)  
dismissOtherOnShow   | bool (default true)
toastAnimation       | StyledToastAnimation (default StyledToastAnimation.fade)
reverseAnimation     | StyledToastAnimation
alignment            | AlignmentGeometry (default Alignment.center)
axis                 | Axis (default Axis.vertical)
startOffset          | Offset
endOffset            | Offset
reverseStartOffset   | Offset
reverseEndOffset     | Offset
textAlign            | TextAlign (default TextAlign.center)
curve                | Curve (default Curves.linear)
reverseCurve         | Curve (default Curves.linear)
fullWidth            | bool (default false)(Full width parameter that the width of the screen minus the width of the margin)
isHideKeyboard       | bool (default false)(Is hide keyboard when toast show)
animationBuilder     | CustomAnimationBuilder (Builder method for custom animation)
reverseAnimBuilder   | CustomAnimationBuilder (Builder method for custom reverse animation)
isIgnoring           | bool (default true)(Is the input ignored for the toast)
onInitState          | OnInitStateCallback (When toast widget [initState], this callback will be called)

### showToastWidget param

property             | description
---------------------|----------------------------
widget               | Widget (Not Null)(required)
context              | BuildContext (If you don't wrap app with StyledToast, context is required, otherwise, is not)
duration             | Duration (default 2.3s)(When set [duration] to Duration.zero, toast won't dismiss automatically)
animDuration         | Duration (default 400 milliseconds, animDuration * 2  <= duration, conditions must be met for toast to display properly)
onDismiss            | VoidCallback (Invoked when toast dismiss)
dismissOtherOnShow   | bool (default true)
textDirection        | TextDirection (default TextDirection.ltr)
position             | StyledToastPosition (default )
animation            | StyledToastAnimation (default StyledToastAnimation.fade)
reverseAnimation     | StyledToastAnimation
alignment            | AlignmentGeometry (default Alignment.center)
axis                 | Axis (default Axis.vertical)
startOffset          | Offset
endOffset            | Offset
reverseStartOffset   | Offset
reverseEndOffset     | Offset
curve                | Curve (default Curves.linear)
reverseCurve         | Curve (default Curves.linear)
isHideKeyboard       | bool (default false)(Is hide keyboard when toast show)
animationBuilder     | CustomAnimationBuilder (Builder method for custom animation)
reverseAnimBuilder   | CustomAnimationBuilder (Builder method for custom reverse animation)
isIgnoring           | bool (default true )(Is the input ignored for the toast)
onInitState          | OnInitStateCallback (When toast widget [initState], this callback will be called)

## Example

[example](https://github.com/JackJonson/flutter_styled_toast/blob/master/example/lib/main.dart)
