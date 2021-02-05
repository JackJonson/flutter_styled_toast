# flutter_styled_toast

A Styled Toast Flutter package. 
You can highly customize toast ever.
Beautify toast with a series of animations and make toast more beautiful.

## demo

<img src="https://raw.githubusercontent.com/JackJonson/flutter_styled_toast/master/screenshots/OverallAnimations.gif" width="50%">


## Getting Started

```yaml
dependencies:
  flutter_styled_toast: ^1.5.0+1
```

```dart
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
```

```dart
//Simple to use
showToast("hello styled toast",context:context);

//Customize toast content widget
showToastWidget(Text('hello styled toast'),context:context);
```

Simple global configuration, wrap you app with StyledToast.
```dart
StyledToast(
  locale: const Locale('en', 'US'),
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
```

Highly Customizable global configuration
```dart
StyledToast(
  locale: const Locale('en', 'US'),  //You have to set this parameters to your locale
  textStyle: TextStyle(fontSize: 16.0, color: Colors.white), //Default text style of toast
  backgroundColor: Color(0x99000000),  //Background color of toast
  borderRadius: BorderRadius.circular(5.0), //Border radius of toast
  textPadding: EdgeInsets.symmetric(horizontal: 17.0, vertical: 10.0),//The padding of toast text
  toastPositions: StyledToastPosition.bottom, //The position of toast
  toastAnimation: StyledToastAnimation.fade,  //The animation type of toast
  reverseAnimation: StyledToastAnimation.fade, //The reverse animation of toast (display When dismiss toast)
  curve: Curves.fastOutSlowIn,  //The curve of animation
  reverseCurve: Curves.fastLinearToSlowEaseIn, //The curve of reverse animation
  duration: Duration(seconds: 4), //The duration of toast showing
  animDuration: Duration(seconds: 1), //The duration of animation(including reverse) of toast 
  dismissOtherOnShow: true,  //When we show a toast and other toast is showing, dismiss any other showing toast before.
  movingOnWindowChange: true, //When the window configuration changes, move the toast.
  fullWidth: false, //Whether the toast is full screen (subtract the horizontal margin)
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
```

```dart
//After global configuration, general use
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
duration             | Duration (default 2.3s)
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
movingOnWindowChange | bool (default true)
onDismiss            | VoidCallback (Invoked when toast dismiss) 
fullWidth            | bool (default false)(Full width parameter that the width of the screen minus the width of the margin.)
isHideKeyboard       | bool (default false)(Is hide keyboard when toast show)
animationBuilder     | CustomAnimationBuilder (Builder method for custom animation)
reverseAnimBuilder   | CustomAnimationBuilder (Builder method for custom reverse animation)



### showToast param

property             | description
---------------------|----------------------------
msg                  | String (Not Null)(required)
context              | BuildContext (If you don't wrap app with StyledToast, context is required, otherwise, is not)
duration             | Duration (default 2.3s)
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
movingOnWindowChange | bool (default true)
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
fullWidth            | bool (default false)(Full width parameter that the width of the screen minus the width of the margin.)
isHideKeyboard       | bool (default false)(Is hide keyboard when toast show)
animationBuilder     | CustomAnimationBuilder (Builder method for custom animation)
reverseAnimBuilder   | CustomAnimationBuilder (Builder method for custom reverse animation)
    


### showToastWidget param

property             | description
---------------------|----------------------------
widget               | Widget (Not Null)(required)
context              | BuildContext (If you don't wrap app with StyledToast, context is required, otherwise, is not)
duration             | Duration (default 2.3s)
animDuration         | Duration (default 400 milliseconds, animDuration * 2  <= duration, conditions must be met for toast to display properly)
onDismiss            | VoidCallback (Invoked when toast dismiss) 
dismissOtherOnShow   | bool (default true)        
movingOnWindowChange | bool (default true)   
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


## Example
[example](https://github.com/JackJonson/flutter_styled_toast/blob/master/example/lib/main.dart)

