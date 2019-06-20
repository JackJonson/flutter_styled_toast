import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_responsive_screen/flutter_responsive_screen.dart';

///Calculate width and height by percentage
Function wp;
Function hp;

///Current context of the page which uses the toast
BuildContext currentContext;

const _defaultDuration = Duration(
  milliseconds: 2300,
);

const _animationDuration = Duration(milliseconds: 400);

/// Show toast with [msg],
///
ToastFuture showToast(
  String msg, {
  BuildContext context,
  Duration duration = _defaultDuration,
  Duration animDuration = _animationDuration,
  StyledToastPosition position = StyledToastPosition.bottom,
  TextStyle textStyle,
  EdgeInsetsGeometry textPadding,
  Color backgroundColor,
  BorderRadius borderRadius,
  VoidCallback onDismiss,
  TextDirection textDirection,
  bool dismissOtherToast = true,
  StyledToastAnimation animation = StyledToastAnimation.fade,
  TextAlign textAlign,
  Curve curve = Curves.linear,
  Curve reverseCurve = Curves.linear,
}) {
  context = context != null ? context : currentContext;

  textStyle ??=
      _StyledToastTheme.of(context).textStyle ?? TextStyle(fontSize: 15.0);

  textAlign = _StyledToastTheme.of(context).textAlign;

  textPadding ??= _StyledToastTheme.of(context).textPadding;

  position ??= _StyledToastTheme.of(context).toastPositions;
  backgroundColor ??= _StyledToastTheme.of(context).backgroundColor;
  borderRadius ??= _StyledToastTheme.of(context).borderRadius;

  var direction = textDirection ??
      _StyledToastTheme.of(context).textDirection ??
      TextDirection.ltr;

  Widget widget = Container(
    margin: const EdgeInsets.symmetric(horizontal: 50.0),
    decoration: BoxDecoration(
      color: backgroundColor,
      borderRadius: borderRadius,
    ),
    padding: textPadding,
    child: ClipRect(
      child: Text(
        msg,
        style: textStyle,
        textAlign: textAlign,
      ),
    ),
  );

  return showToastWidget(
    widget,
    context: context,
    duration: duration,
    animDuration: animDuration,
    onDismiss: onDismiss,
    position: position,
    dismissOtherToast: dismissOtherToast,
    textDirection: direction,
    curve: curve,
    reverseCurve: reverseCurve,
    animation: animation,
  );
}

/// show [widget] with oktoast
ToastFuture showToastWidget(
  Widget widget, {
  BuildContext context,
  Duration duration = _defaultDuration,
  Duration animDuration = _animationDuration,
  VoidCallback onDismiss,
  bool dismissOtherToast,
  TextDirection textDirection,
  StyledToastPosition position = StyledToastPosition.bottom,
  StyledToastAnimation animation = StyledToastAnimation.fade,
  Curve curve = Curves.linear,
  Curve reverseCurve = Curves.linear,
}) {
  OverlayEntry entry;
  ToastFuture future;

  context = context != null ? context : currentContext;

  position ??= _StyledToastTheme.of(context).toastPositions;

  var movingOnWindowChange =
      _StyledToastTheme.of(context)?.movingOnWindowChange ?? true;

  var direction = textDirection ??
      _StyledToastTheme.of(context).textDirection ??
      TextDirection.ltr;

  GlobalKey<_StyledToastWidgetState> key = GlobalKey();

  entry = OverlayEntry(builder: (ctx) {
    wp = Screen(MediaQuery.of(context).size).wp;
    hp = Screen(MediaQuery.of(context).size).hp;

    return IgnorePointer(
      child: _StyledToastWidget(
        duration: duration,
        animDuration: animDuration,
        position: position,
        movingOnWindowChange: movingOnWindowChange,
        animation: animation,
        curve: curve,
        reverseCurve: reverseCurve,
        key: key,
        child: Directionality(
          textDirection: direction,
          child: Material(
            child: widget,
            color: Colors.transparent,
          ),
        ),
      ),
    );
  });

  dismissOtherToast ??=
      _StyledToastTheme.of(context).dismissOtherOnShow ?? false;

  if (dismissOtherToast == true) {
    ToastManager().dismissAll();
  }

  future = ToastFuture._(entry, onDismiss, key);

  Future.delayed(duration, () {
    future.dismiss();
  });

  Overlay.of(context).insert(entry);
  ToastManager().addFuture(future);

  return future;
}

/// Use the [dismiss] to dismiss toast.
class ToastFuture {
  final OverlayEntry _entry;
  final VoidCallback _onDismiss;
  bool _isShow = true;
  final GlobalKey<_StyledToastWidgetState> _containerKey;

  ToastFuture._(
    this._entry,
    this._onDismiss,
    this._containerKey,
  );

  void dismiss(
      {bool showAnim = false, Duration animDuration = _animationDuration}) {
    if (!_isShow) {
      return;
    }
    _isShow = false;
    _onDismiss?.call();
    ToastManager().removeFuture(this);

    if (showAnim) {
      _containerKey.currentState.showDismissAnim();
      Future.delayed(animDuration, () {
        _entry.remove();
      });
    } else {
      _entry.remove();
    }
  }
}

///Toast manager, manage toast list
class ToastManager {
  ToastManager._();

  static ToastManager _instance;

  factory ToastManager() {
    _instance ??= ToastManager._();
    return _instance;
  }

  Set<ToastFuture> toastSet = Set();

  void dismissAll({bool showAnim = false}) {
    toastSet.toList().forEach((v) {
      v.dismiss(showAnim: showAnim);
    });
  }

  void removeFuture(ToastFuture future) {
    toastSet.remove(future);
  }

  void addFuture(ToastFuture future) {
    toastSet.add(future);
  }
}

/// use the method to dismiss all toast.
void dismissAllToast({bool showAnim = false}) {
  ToastManager().dismissAll(showAnim: showAnim);
}

///Toast position
class StyledToastPosition {
  ///Toast position align
  final AlignmentGeometry align;

  ///Toast position offset
  final double offset;

  const StyledToastPosition({this.align = Alignment.center, this.offset = 0.0});

  ///Center position
  static const center =
      const StyledToastPosition(align: Alignment.center, offset: 0.0);

  ///Top center position
  static const top =
      const StyledToastPosition(align: Alignment.topCenter, offset: 10.0);

  ///Bottom center position
  static const bottom =
      const StyledToastPosition(align: Alignment.bottomCenter, offset: 20.0);

  ///Center left position
  static const left =
      const StyledToastPosition(align: Alignment.centerLeft, offset: 17.0);

  ///Center right position
  static const right =
      const StyledToastPosition(align: Alignment.centerRight, offset: 17.0);
}

///Toast showing type
enum StyledToastShowType {
  ///Dismiss old toast widget that is showing
  dismissShowing,

  ///Show a new toast
  normal,
}

///Toast animation
enum StyledToastAnimation {
  ///Fade in and out animation
  fade,

  ///Slide from top animation
  slideFromTop,

  ///Slide from bottom animation
  slideFromBottom,

  ///Slide from left animation
  slideFromLeft,

  ///Slide from right animation
  slideFromRight,

  ///Scale animation
  scale,

  ///Fade scale animation
  fadeScale,

  ///Rotate animation
  rotate,

  ///Fade rotate animation
  fadeRotate,

  ///Scale rotate animation
  scaleRotate,

  ///No animation
  none,
}

///
///created time: 2019-06-18 10:47
///author linzhiliang
///version 1.0
///since
///file name: styled_toast.dart
///description: Toast widget wrapper
///
class StyledToast extends StatefulWidget {
  ///Child of toast scope
  final Widget child;

  ///Text align
  final TextAlign textAlign;

  ///Text direction
  final TextDirection textDirection;

  ///Border radius
  final BorderRadius borderRadius;

  ///Background color
  final Color backgroundColor;

  ///Padding for the text and the container edges
  final EdgeInsets textPadding;

  ///Text style for content
  final TextStyle textStyle;

  ///Shape for the container
  final ShapeBorder shapeBorder;

  ///Toast show duration
  final Duration duration;

  ///Position of the toast widget in current window
  final StyledToastPosition toastPositions;

  ///Toast animation
  final StyledToastAnimation toastAnimation;

  ///callback when toast dismissed
  final VoidCallback onDismiss;

  final bool dismissOtherOnShow;

  final bool movingOnWindowChange;

  StyledToast(
      {Key key,
      @required this.child,
      this.textAlign,
      this.textDirection,
      this.borderRadius,
      this.backgroundColor = const Color(0x99000000),
      this.textPadding,
      this.textStyle,
      this.shapeBorder,
      this.duration,
      this.toastPositions,
      this.toastAnimation = StyledToastAnimation.fade,
      this.dismissOtherOnShow = false,
      this.movingOnWindowChange = true,
      this.onDismiss})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _StyledToastState();
  }
}

class _StyledToastState extends State<StyledToast> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    currentContext = null;
  }

  @override
  Widget build(BuildContext context) {
    Widget overlay = Overlay(
      initialEntries: <OverlayEntry>[
        OverlayEntry(builder: (context) {
          currentContext = context;
          return widget.child;
        })
      ],
    );

    TextDirection direction = widget.textDirection ?? TextDirection.ltr;

    Widget wrapper = Directionality(
        textDirection: direction,
        child: Stack(
          children: <Widget>[
            overlay,
          ],
        ));

    TextStyle textStyle = widget.textStyle ??
        TextStyle(
          fontSize: 15.0,
          fontWeight: FontWeight.normal,
          color: Colors.white,
        );

    TextAlign textAlign = widget.textAlign ?? TextAlign.center;
    EdgeInsets textPadding = widget.textPadding ??
        const EdgeInsets.symmetric(
          horizontal: 17.0,
          vertical: 8.0,
        );

    // TODO: implement build
    return _StyledToastTheme(
      child: wrapper,
      textAlign: textAlign,
      textDirection: direction,
      borderRadius: widget.borderRadius,
      backgroundColor: widget.backgroundColor,
      textPadding: textPadding,
      textStyle: textStyle,
      shapeBorder: widget.shapeBorder,
      duration: widget.duration,
      toastPositions: widget.toastPositions,
      toastAnimation: widget.toastAnimation,
      dismissOtherOnShow: widget.dismissOtherOnShow,
      movingOnWindowChange: widget.movingOnWindowChange,
      onDismiss: widget.onDismiss,
    );
  }
}

///
///created time: 2019-06-18 10:44
///author linzhiliang
///version 1.0
///since
///file name: styled_toast.dart
///description: Toast widget
///
class _StyledToastWidget extends StatefulWidget {
  ///Child widget
  final Widget child;

  ///Toast duration
  final Duration duration;

  ///Toast animation duration
  final Duration animDuration;

  ///Animation curve
  final Curve curve;

  ///Animation reverse curve
  final Curve reverseCurve;

  ///Toast position
  final StyledToastPosition position;

  ///Toast animation
  final StyledToastAnimation animation;

  ///When window change, moving toast.
  final bool movingOnWindowChange;

  _StyledToastWidget({
    Key key,
    this.child,
    this.duration,
    this.animDuration,
    this.curve = Curves.linear,
    this.reverseCurve = Curves.linear,
    this.position = StyledToastPosition.bottom,
    this.animation = StyledToastAnimation.fade,
    this.movingOnWindowChange = true,
  })  : assert(animDuration * 2 <= duration),
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _StyledToastWidgetState();
  }
}

class _StyledToastWidgetState extends State<_StyledToastWidget>
    with TickerProviderStateMixin<_StyledToastWidget>, WidgetsBindingObserver {
  ///Animation related fields
  AnimationController _animationController;

  ///Fade animation
  Animation<double> fadeAnim;

  ///Scale animation
  Animation<double> scaleAnim;

  ///Slide from top animation
  Animation<double> slideFromTopAnim;

  ///Slide from bottom animation
  Animation<double> slideFromBottomAnim;

  ///Slide from left animation
  Animation<double> slideFromLeftAnim;

  ///Slide from right animation
  Animation<double> slideFromRightAnim;

  ///Fade scale animation
  Animation<double> fadeScaleAnim;

  ///Rotate animation
  Animation<double> rotateAnim;

  double opacity = 0.0;

  bool get movingOnWindowChange => widget.movingOnWindowChange;

  double get offset => widget.position.offset;

  AlignmentGeometry get alignment => widget.position.align;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: widget.animDuration)
          ..addStatusListener((status) {});

    switch (widget.animation) {
      case StyledToastAnimation.fade:
        fadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: _animationController,
            curve: widget.curve,
            reverseCurve: widget.reverseCurve));
        break;
      case StyledToastAnimation.slideFromTop:
        _animationController
          ..addListener(() {
            if (mounted) {
              setState(() {});
            }
          });
//        GlobalKey globalKey= widget.childKey;
//        RenderBox renderBox=globalKey.currentContext.findRenderObject();
        slideFromTopAnim = Tween<double>(begin: -hp(100.0), end: 0.0).animate(
            CurvedAnimation(
                parent: _animationController,
                curve: widget.curve,
                reverseCurve: widget.reverseCurve));

        break;
      case StyledToastAnimation.slideFromBottom:
        _animationController
          ..addListener(() {
            if (mounted) {
              setState(() {});
            }
          });
        slideFromBottomAnim = Tween<double>(begin: hp(100), end: 0).animate(
            CurvedAnimation(
                parent: _animationController,
                curve: widget.curve,
                reverseCurve: widget.reverseCurve));

        break;
      case StyledToastAnimation.slideFromLeft:
        _animationController
          ..addListener(() {
            if (mounted) {
              setState(() {});
            }
          });
        slideFromLeftAnim = Tween<double>(begin: -wp(100), end: 0).animate(
            CurvedAnimation(
                parent: _animationController,
                curve: widget.curve,
                reverseCurve: widget.reverseCurve));

        break;
      case StyledToastAnimation.slideFromRight:
        _animationController
          ..addListener(() {
            if (mounted) {
              setState(() {});
            }
          });
        slideFromRightAnim = Tween<double>(begin: wp(100), end: 0).animate(
            CurvedAnimation(
                parent: _animationController,
                curve: widget.curve,
                reverseCurve: widget.reverseCurve));

        break;
      case StyledToastAnimation.scale:
        scaleAnim = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: _animationController,
            curve: widget.curve,
            reverseCurve: widget.reverseCurve));
        break;
      case StyledToastAnimation.fadeScale:
        fadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: _animationController,
            curve: Interval(0.0, 1.0, curve: widget.curve),
            reverseCurve: Interval(0.0, 1.0, curve: widget.reverseCurve)));
        scaleAnim = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: _animationController,
            curve: Interval(0.0, 1.0, curve: widget.curve),
            reverseCurve: Interval(0.0, 1.0, curve: widget.reverseCurve)));
        break;
      case StyledToastAnimation.rotate:
        _animationController
          ..addListener(() {
            if (mounted) {
              setState(() {});
            }
          });
        rotateAnim = Tween<double>(begin: 0, end: 2 * math.pi).animate(
            CurvedAnimation(
                parent: _animationController,
                curve: widget.curve,
                reverseCurve: widget.reverseCurve));
        break;
      case StyledToastAnimation.scaleRotate:
        _animationController
          ..addListener(() {
            if (mounted) {
              setState(() {});
            }
          });
        scaleAnim = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: _animationController,
            curve: Interval(0.0, 1.0, curve: widget.curve),
            reverseCurve: Interval(0.0, 1.0, curve: widget.reverseCurve)));
        rotateAnim = Tween<double>(begin: 0, end: 2 * math.pi).animate(
            CurvedAnimation(
                parent: _animationController,
                curve: Interval(0.0, 1.0, curve: widget.curve),
                reverseCurve: Interval(0.0, 1.0, curve: widget.reverseCurve)));
        break;
      case StyledToastAnimation.fadeRotate:
        _animationController
          ..addListener(() {
            if (mounted) {
              setState(() {});
            }
          });
        fadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: _animationController,
            curve: Interval(0.0, 1.0, curve: widget.curve),
            reverseCurve: Interval(0.0, 1.0, curve: widget.reverseCurve)));
        rotateAnim = Tween<double>(begin: 0, end: 2 * math.pi).animate(
            CurvedAnimation(
                parent: _animationController,
                curve: Interval(0.0, 1.0, curve: widget.curve),
                reverseCurve: Interval(0.0, 1.0, curve: widget.reverseCurve)));
        break;
      case StyledToastAnimation.none:
        break;
      default:
        fadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: _animationController,
            curve: widget.curve,
            reverseCurve: widget.reverseCurve));
        break;
    }

    Future.delayed(const Duration(milliseconds: 30), () async {
      if (!mounted) {
        return;
      }
      setState(() {
        opacity = 1.0;
      });
      try {
        await _animationController.forward().orCancel;
      } on TickerCanceled {}
    });

    Future.delayed(widget.duration - widget.animDuration, () async {
      if (!mounted) {
        return;
      }
      try {
        await _animationController.reverse().orCancel;
      } on TickerCanceled {}
//      setState(() {
//        opacity = 0.0;
//      });
    });

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
//    Widget w = AnimatedOpacity(
//      duration: widget.animDuration,
//      child: widget.child,
//      opacity: opacity,
//    );
    Widget w;
    switch (widget.animation) {
      case StyledToastAnimation.fade:
        w = FadeTransition(
          opacity: fadeAnim,
          child: widget.child,
        );
        break;
      case StyledToastAnimation.slideFromTop:
        w = Transform(
          transform: Matrix4.identity()
            ..setTranslationRaw(0, slideFromTopAnim.value, 0),
          alignment: FractionalOffset.topCenter,
          child: widget.child,
        );
        break;
      case StyledToastAnimation.slideFromBottom:
        w = Transform(
          transform: Matrix4.identity()
            ..setTranslationRaw(0, slideFromBottomAnim.value, 0),
          child: widget.child,
        );
        break;
      case StyledToastAnimation.slideFromLeft:
        w = Transform(
          transform: Matrix4.identity()
            ..setTranslationRaw(slideFromLeftAnim.value, 0, 0),
          child: widget.child,
        );
        break;
      case StyledToastAnimation.slideFromRight:
        w = Transform(
          transform: Matrix4.identity()
            ..setTranslationRaw(slideFromRightAnim.value, 0, 0),
          child: widget.child,
        );
        break;
      case StyledToastAnimation.scale:
        w = ScaleTransition(
          scale: scaleAnim,
          child: widget.child,
        );
        break;
      case StyledToastAnimation.fadeScale:
        w = FadeTransition(
          opacity: fadeAnim,
          child: ScaleTransition(
            scale: scaleAnim,
            child: widget.child,
          ),
        );
        break;
      case StyledToastAnimation.rotate:
        w = Transform(
          transform: Matrix4.identity()..setRotationZ(rotateAnim.value),
          alignment: FractionalOffset.center,
          child: widget.child,
        );
        break;
      case StyledToastAnimation.fadeRotate:
        w = FadeTransition(
          opacity: fadeAnim,
          child: Transform(
            transform: Matrix4.identity()..setRotationZ(rotateAnim.value),
            alignment: FractionalOffset.center,
            child: widget.child,
          ),
        );
        break;
      case StyledToastAnimation.scaleRotate:
        w = ScaleTransition(
          scale: scaleAnim,
          child: Transform(
            transform: Matrix4.identity()..setRotationZ(rotateAnim.value),
            alignment: FractionalOffset.center,
            child: widget.child,
          ),
        );
        break;
      case StyledToastAnimation.none:
        w = Container(
          child: widget.child,
        );
        break;
      default:
        w = FadeTransition(
          opacity: fadeAnim,
          child: widget.child,
        );
        break;
    }

    w = Opacity(
      opacity: opacity,
      child: w,
    );

    if (movingOnWindowChange != true) {
      return w;
    }

    var mediaQueryData = MediaQueryData.fromWindow(ui.window);
    Widget container = AnimatedContainer(
      padding: EdgeInsets.only(
          bottom: mediaQueryData.padding.bottom,
          top: mediaQueryData.padding.top),
      alignment: alignment,
      duration: widget.animDuration,
      child: w,
    );

    if (Alignment.center == alignment) {
    } else if (Alignment.bottomCenter == alignment) {
      container = Padding(
        padding: EdgeInsets.only(bottom: offset),
        child: container,
      );
    } else if (Alignment.topCenter == alignment) {
      container = Padding(
        padding: EdgeInsets.only(top: offset),
        child: container,
      );
    } else if (Alignment.centerLeft == alignment) {
      container = Padding(
        padding: EdgeInsets.only(left: offset),
        child: container,
      );
    } else if (Alignment.centerRight == alignment) {
      container = Padding(
        padding: EdgeInsets.only(right: offset),
        child: container,
      );
    } else {}

    return container;
  }

  void showDismissAnim() {
    setState(() {
      opacity = 0.0;
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    if (_animationController != null) {
      _animationController.dispose();
    }
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    if (this.mounted) setState(() {});
  }

  @override
  void didChangeAccessibilityFeatures() {
    // TODO: implement didChangeAccessibilityFeatures
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
  }

  @override
  void didChangeLocales(List<Locale> locale) {
    // TODO: implement didChangeLocales
  }

  @override
  void didChangePlatformBrightness() {
    // TODO: implement didChangePlatformBrightness
  }

  @override
  void didChangeTextScaleFactor() {
    // TODO: implement didChangeTextScaleFactor
  }

  @override
  void didHaveMemoryPressure() {
    // TODO: implement didHaveMemoryPressure
  }

  @override
  Future<bool> didPopRoute() {
    // TODO: implement didPopRoute
    return null;
  }

  @override
  Future<bool> didPushRoute(String route) {
    // TODO: implement didPushRoute
    return null;
  }
}

///
///created time: 2019-06-18 10:49
///author linzhiliang
///version 1.0
///since
///file name: styled_toast.dart
///description: Toast theme, only for default content widget;
///If you have specified a custom content widget, ToastTheme will not be working.
///
class _StyledToastTheme extends InheritedWidget {
  ///Child widget
  final Widget child;

  ///Text align
  final TextAlign textAlign;

  ///Text direction
  final TextDirection textDirection;

  ///Border radius
  final BorderRadius borderRadius;

  ///Background color
  final Color backgroundColor;

  ///Padding for the text and the container edges
  final EdgeInsets textPadding;

  ///Text style for content
  final TextStyle textStyle;

  ///Shape for the container
  final ShapeBorder shapeBorder;

  ///Toast show duration
  final Duration duration;

  ///Position of the toast widget in current window
  final StyledToastPosition toastPositions;

  ///Toast animation
  final StyledToastAnimation toastAnimation;

  ///Dismiss old toast when new one showing
  final bool dismissOtherOnShow;

  ///When window change, moving toast.
  final bool movingOnWindowChange;

  ///callback when toast dismissed
  final VoidCallback onDismiss;

  _StyledToastTheme({
    this.child,
    this.textAlign,
    this.textDirection,
    this.borderRadius,
    this.backgroundColor,
    this.textPadding,
    this.textStyle,
    this.shapeBorder,
    this.duration,
    this.toastPositions,
    this.toastAnimation,
    this.dismissOtherOnShow,
    this.movingOnWindowChange,
    this.onDismiss,
  }) : super(child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    // TODO: implement updateShouldNotify
    return true;
  }

  static _StyledToastTheme of(BuildContext context) =>
      context.inheritFromWidgetOfExactType(_StyledToastTheme);
}

class MyElasticOutCurve extends Curve {
  /// Creates an elastic-out curve.
  ///
  /// Rather than creating a new instance, consider using [Curves.elasticOut].
  const MyElasticOutCurve([this.period = 0.4]);

  /// The duration of the oscillation.
  final double period;

  @override
  double transformInternal(double t) {
    final double s = period / 4.0;
    return math.pow(2.0, -10 * t) *
            math.sin((t - s) * (math.pi * 2.0) / period) +
        1.0;
  }

  @override
  String toString() {
    return '$runtimeType($period)';
  }
}
