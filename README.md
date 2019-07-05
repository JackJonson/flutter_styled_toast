# flutter_styled_toast

A Styled Toast Flutter package. 
You can highly customize toast ever.
Beautify toast with a series of animations and make toast more beautiful.

## Getting Started
### 1. add library to your pubspec.yaml

```yaml
dependencies:
  flutter_styled_toast: ^1.0.0
```

```dart
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
```

```dart
StyledToast(
  textStyle: TextStyle(fontSize: 16.0, color: Colors.white),
  backgroundColor: Color(0x99000000),
  borderRadius: BorderRadius.circular(5.0),
  textPadding: EdgeInsets.symmetric(horizontal: 17.0, vertical: 10.0),
  toastAnimation: StyledToastAnimation.fade,
  reverseAnimation: StyledToastAnimation.fade,
  curve: Curves.fastOutSlowIn,
  reverseCurve: Curves.fastLinearToSlowEaseIn,
  dismissOtherOnShow: true,
  movingOnWindowChange: true,
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
//general use
showToast("hello toast");

// Customize toast content widget
showToastWidget(Text('hello toast'));
```

### StyledToast param

property             | description
---------------------|----------------------------
child                | Widget (Not Null)(required)
textAlign            | TextAlign (default TextAlign.center)    
textDirection        | TextDirection (default TextDirection.ltr)  
borderRadius         | BorderRadius (BorderRadius.circular(2.0))
backgroundColor      | Color (default Color(0x99000000))
textPadding          | EdgeInsetsGeometry (default EdgeInsets.symmetric(horizontal: 17.0,vertical: 8.0))   
textStyle            | TextStyle (default TextStyle(fontSize: 16.0,fontWeight: FontWeight.normal,color: Colors.white))   
shapeBorder          | ShapeBorder (default no border)   
duration             | Duration (default 2.3s)
animDuration         | Duration (default 400 milliseconds, animDuration * 2  <= duration, conditions must be met for toast to display properly)
toastPositions       | StyledToastPosition
toastAnimation       | StyledToastAnimation
reverseAnimation     | StyledToastAnimation 
curve                | StyledToastAnimation
reverseCurve         | StyledToastAnimation
dismissOtherOnShow   | bool      
movingOnWindowChange | bool 
onDismiss            | VoidCallback (Invoked when toast dismiss) 

### showToast param
property             | description
---------------------|----------------------------
msg                  | String (Not Null)(required)
context              | BuildContext (If you don't wrap app with StyledToast, context is required, otherwise, is not)
duration             | Duration (default 2.3s)
animDuration         | Duration (default 400 milliseconds, animDuration * 2  <= duration, conditions must be met for toast to display properly)
position             | StyledToastPosition (default )
textStyle            | TextStyle (default TextStyle(fontSize: 16.0,fontWeight: FontWeight.normal,color: Colors.white))   
textPadding          | EdgeInsetsGeometry (default EdgeInsets.symmetric(horizontal: 17.0,vertical: 8.0))   
backgroundColor      | Color (default Color(0x99000000))
borderRadius         | BorderRadius (BorderRadius.circular(2.0))
shapeBorder          | ShapeBorder (default no border)   
onDismiss            | VoidCallback (Invoked when toast dismiss) 
textDirection        | TextDirection (default TextDirection.ltr)  
dismissOtherOnShow   | bool      
movingOnWindowChange | bool 
toastAnimation       | StyledToastAnimation
reverseAnimation     | StyledToastAnimation 
textAlign            | TextAlign (default TextAlign.center)    
curve                | StyledToastAnimation
reverseCurve         | StyledToastAnimation

### showToastWidget param
property             | description
---------------------|----------------------------
widget               | Widget (Not Null)(required)
context              | BuildContext (If you don't wrap app with StyledToast, context is required, otherwise, is not)
duration             | Duration (default 2.3s)
animDuration         | Duration (default 400 milliseconds, animDuration * 2  <= duration, conditions must be met for toast to display properly)
onDismiss            | VoidCallback (Invoked when toast dismiss) 
dismissOtherOnShow   | bool      
movingOnWindowChange | bool 
textDirection        | TextDirection (default TextDirection.ltr)  
position             | StyledToastPosition (default )
animation            | StyledToastAnimation
reverseAnimation     | StyledToastAnimation 
curve                | StyledToastAnimation
reverseCurve         | StyledToastAnimation


## Example
[example](https://github.com/JackJonson/flutter_styled_toast/blob/master/example/lib/main.dart)


## Thanks for
[OkToast](https://github.com/OpenFlutter/flutter_oktoast)
[flutter_responsive_screen](https://github.com/misaelriojasm/FlutterResponsiveScreen)
