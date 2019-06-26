import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_responsive_screen/flutter_responsive_screen.dart';

///Calculate width by percentage
Function wp = Screen(MediaQueryData.fromWindow(ui.window).size).wp;

///Calculate height by percentage
Function hp = Screen(MediaQueryData.fromWindow(ui.window).size).hp;

///Current context of the page which uses the toast
BuildContext currentContext;

///Default toast duration
const _defaultDuration = Duration(
  milliseconds: 2300,
);

///Default animation duration
///When you use Curves.elasticOut, you can specify a longer duration to achieve beautiful effect
///But [animDuration] * 2  <= toast [duration], conditions must be met for toast to display properly
///so when you specify a longer animation duration, you must also specify toast duration to satisfy conditions above
const _animationDuration = Duration(milliseconds: 400);

/// Show normal toast with style and animation
/// Can be used without wrapping you app with StyledToast, but must specify context;
/// When you wrap your app with StyledToast, [context] is optional;
ToastFuture showToast(
  String msg, {
  BuildContext context,
  Duration duration = _defaultDuration,
  Duration animDuration = _animationDuration,
  StyledToastPosition position,
  TextStyle textStyle,
  EdgeInsetsGeometry textPadding,
  Color backgroundColor,
  BorderRadius borderRadius,
  ShapeBorder shapeBorder,
  VoidCallback onDismiss,
  TextDirection textDirection,
  bool dismissOtherToast = true,
  bool movingOnWindowChange = true,
  StyledToastAnimation animation,
  final StyledToastAnimation reverseAnimation,
  TextAlign textAlign,
  Curve curve = Curves.linear,
  Curve reverseCurve = Curves.linear,
}) {
  context = context != null ? context : currentContext;
  assert(context != null);

  position ??= _StyledToastTheme.of(context)?.toastPositions ??
      StyledToastPosition.bottom;

  textStyle ??= _StyledToastTheme.of(context)?.textStyle ??
      TextStyle(fontSize: 16.0, color: Colors.white);

  textPadding ??= _StyledToastTheme.of(context)?.textPadding ??
      EdgeInsets.symmetric(horizontal: 17.0, vertical: 10.0);

  backgroundColor ??=
      _StyledToastTheme.of(context)?.backgroundColor ?? const Color(0x99000000);
  borderRadius ??=
      _StyledToastTheme.of(context)?.borderRadius ?? BorderRadius.circular(5.0);

  shapeBorder ??= _StyledToastTheme.of(context)?.shapeBorder ??
      RoundedRectangleBorder(
        borderRadius: borderRadius,
      );

  textDirection ??=
      _StyledToastTheme.of(context)?.textDirection ?? TextDirection.ltr;

  textAlign ??= _StyledToastTheme.of(context)?.textAlign ?? TextAlign.center;

  Widget widget = Container(
    margin: const EdgeInsets.symmetric(horizontal: 50.0),
    decoration: ShapeDecoration(
      color: backgroundColor,
      shape: shapeBorder,
    ),
    padding: textPadding,
    child: Text(
      msg ?? '',
      style: textStyle,
      textAlign: textAlign,
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
    movingOnWindowChange: movingOnWindowChange,
    textDirection: textDirection,
    curve: curve,
    reverseCurve: reverseCurve,
    animation: animation,
    reverseAnimation: reverseAnimation,
  );
}

/// Show custom content widget toast
ToastFuture showToastWidget(
  Widget widget, {
  BuildContext context,
  Duration duration = _defaultDuration,
  Duration animDuration = _animationDuration,
  VoidCallback onDismiss,
  bool dismissOtherToast = true,
  bool movingOnWindowChange = true,
  TextDirection textDirection,
  StyledToastPosition position,
  StyledToastAnimation animation,
  StyledToastAnimation reverseAnimation,
  Curve curve = Curves.linear,
  Curve reverseCurve = Curves.linear,
}) {
  OverlayEntry entry;
  ToastFuture future;

  context = context != null ? context : currentContext;
  assert(context != null);

  duration ??= _defaultDuration;
  animDuration ??= _animationDuration;

  dismissOtherToast ??=
      _StyledToastTheme.of(context)?.dismissOtherOnShow ?? true;

  movingOnWindowChange ??=
      _StyledToastTheme.of(context)?.movingOnWindowChange ?? true;

  textDirection ??= textDirection ??
      _StyledToastTheme.of(context)?.textDirection ??
      TextDirection.ltr;

  position ??= _StyledToastTheme.of(context)?.toastPositions ??
      StyledToastPosition.bottom;

  curve ??= curve ?? _StyledToastTheme.of(context)?.curve ?? Curves.linear;

  reverseCurve ??= reverseCurve ??
      _StyledToastTheme.of(context)?.reverseCurve ??
      Curves.linear;
  animation ??= animation ??
      _StyledToastTheme.of(context)?.toastAnimation ??
      StyledToastAnimation.fade;
  reverseAnimation ??=
      reverseAnimation ?? _StyledToastTheme.of(context)?.reverseAnimation;

  GlobalKey<_StyledToastWidgetState> key = GlobalKey();

  entry = OverlayEntry(builder: (ctx) {
    return IgnorePointer(
      child: _StyledToastWidget(
        duration: duration,
        animDuration: animDuration,
        position: position,
        movingOnWindowChange: movingOnWindowChange,
        animation: animation,
        reverseAnimation: reverseAnimation,
        curve: curve,
        reverseCurve: reverseCurve,
        key: key,
        child: Directionality(
          textDirection: textDirection,
          child: Material(
            child: widget,
            color: Colors.transparent,
          ),
        ),
      ),
    );
  });

  dismissOtherToast ??=
      _StyledToastTheme.of(context)?.dismissOtherOnShow ?? false;

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

/// use the method to dismiss all toast.
void dismissAllToast({bool showAnim = false}) {
  ToastManager().dismissAll(showAnim: showAnim);
}

/// Use the [dismiss] to dismiss toast.
/// When the Toast is dismissed, call [onDismiss] if specified;
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

    _containerKey.currentState?.dismissToast();
    _entry.remove();
//    if (showAnim) {
//      _containerKey.currentState.dismissToast();
//      Future.delayed(animDuration, () {
//        _entry.remove();
//      });
//    } else {
//      _entry.remove();
//    }
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

  ///Slide to top animation
  slideToTop,

  ///Slide to bottom animation
  slideToBottom,

  ///Slide to left animation
  slideToLeft,

  ///Slide to right animation
  slideToRight,

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

  ///Toast reverse animation
  final StyledToastAnimation reverseAnimation;

  ///Animation curve
  final Curve curve;

  ///Animation reverse curve
  final Curve reverseCurve;

  ///callback when toast dismissed
  final VoidCallback onDismiss;

  ///Dismiss old toast when new one shows
  final bool dismissOtherOnShow;

  ///When window change, moving toast.
  final bool movingOnWindowChange;

  StyledToast(
      {Key key,
      @required this.child,
      this.textAlign,
      this.textDirection,
      this.borderRadius,
      this.backgroundColor,
      this.textPadding,
      this.textStyle = const TextStyle(fontSize: 16.0, color: Colors.white),
      this.shapeBorder,
      this.duration,
      this.toastPositions,
      this.toastAnimation = StyledToastAnimation.fade,
      this.reverseAnimation,
      this.curve,
      this.reverseCurve,
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
//    currentContext = null;
  }

  @override
  Widget build(BuildContext context) {
    Widget overlay = Overlay(
      initialEntries: <OverlayEntry>[
        OverlayEntry(builder: (ctx) {
          currentContext = ctx;
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
          fontSize: 16.0,
          fontWeight: FontWeight.normal,
          color: Colors.white,
        );

    Color backgroundColor = widget.backgroundColor ?? const Color(0x99000000);

    BorderRadius borderRadius =
        widget.borderRadius ?? BorderRadius.circular(2.0);

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
      borderRadius: borderRadius,
      backgroundColor: backgroundColor,
      textPadding: textPadding,
      textStyle: textStyle,
      shapeBorder: widget.shapeBorder,
      duration: widget.duration,
      toastPositions: widget.toastPositions,
      toastAnimation: widget.toastAnimation,
      reverseAnimation: widget.reverseAnimation,
      curve: widget.curve,
      reverseCurve: widget.reverseCurve,
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

  ///Toast reverse animation
  final StyledToastAnimation reverseAnimation;

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
    this.reverseAnimation,
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
  ///Animation controller
  AnimationController _animationController;

  ///Reverse animation controller
  AnimationController _reverseAnimController;

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

  ///Fade animation reverse
  Animation<double> fadeAnimReverse;

  ///Scale animation reverse
  Animation<double> scaleAnimReverse;

  ///Slide from top animation reverse
  Animation<double> slideToTopAnimReverse;

  ///Slide from bottom animation reverse
  Animation<double> slideToBottomAnimReverse;

  ///Slide from left animation reverse
  Animation<double> slideToLeftAnimReverse;

  ///Slide from right animation reverse
  Animation<double> slideToRightAnimReverse;

  ///Fade scale animation reverse
  Animation<double> fadeScaleAnimReverse;

  ///Rotate animation reverse
  Animation<double> rotateAnimReverse;

  double opacity = 0.0;

  bool get movingOnWindowChange => widget.movingOnWindowChange;

  double get offset => widget.position.offset;

  AlignmentGeometry get alignment => widget.position.align;

  @override
  void initState() {
    super.initState();

    _initAnim();

    //Start animation
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

    //Dismiss toast
    Future.delayed(widget.duration - widget.animDuration, () async {
      dismissToastAnim();
    });

    WidgetsBinding.instance.addObserver(this);
  }

  ///Init animation
  void _initAnim() {
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

    if (widget.reverseAnimation != null) {
      _reverseAnimController =
          AnimationController(vsync: this, duration: widget.animDuration)
            ..addStatusListener((status) {});

      switch (widget.reverseAnimation) {
        case StyledToastAnimation.fade:
          fadeAnimReverse =
              Tween<double>(begin: 1.0, end: 0.0).animate(CurvedAnimation(
            parent: _reverseAnimController,
            curve: widget.reverseCurve,
          ));
          break;
        case StyledToastAnimation.slideToTop:
          _reverseAnimController
            ..addListener(() {
              if (mounted) {
                setState(() {});
              }
            });
          slideToTopAnimReverse = Tween<double>(begin: 0.0, end: -hp(100.0))
              .animate(CurvedAnimation(
            parent: _reverseAnimController,
            curve: widget.reverseCurve,
          ));

          break;
        case StyledToastAnimation.slideToBottom:
          _reverseAnimController
            ..addListener(() {
              if (mounted) {
                setState(() {});
              }
            });
          slideToBottomAnimReverse =
              Tween<double>(begin: 0.0, end: hp(100)).animate(CurvedAnimation(
            parent: _reverseAnimController,
            curve: widget.reverseCurve,
          ));

          break;
        case StyledToastAnimation.slideToLeft:
          _reverseAnimController
            ..addListener(() {
              if (mounted) {
                setState(() {});
              }
            });
          slideToLeftAnimReverse =
              Tween<double>(begin: 0.0, end: -wp(100)).animate(CurvedAnimation(
            parent: _reverseAnimController,
            curve: widget.reverseCurve,
          ));

          break;
        case StyledToastAnimation.slideToRight:
          _reverseAnimController
            ..addListener(() {
              if (mounted) {
                setState(() {});
              }
            });
          slideToRightAnimReverse =
              Tween<double>(begin: 0, end: wp(100)).animate(CurvedAnimation(
            parent: _reverseAnimController,
            curve: widget.reverseCurve,
          ));

          break;
        case StyledToastAnimation.scale:
          scaleAnimReverse =
              Tween<double>(begin: 1.0, end: 0.0).animate(CurvedAnimation(
            parent: _reverseAnimController,
            curve: widget.reverseCurve,
          ));
          break;
        case StyledToastAnimation.fadeScale:
          fadeAnimReverse =
              Tween<double>(begin: 1.0, end: 0.0).animate(CurvedAnimation(
            parent: _reverseAnimController,
            curve: Interval(0.0, 1.0, curve: widget.reverseCurve),
          ));
          scaleAnimReverse =
              Tween<double>(begin: 1.0, end: 0.0).animate(CurvedAnimation(
            parent: _reverseAnimController,
            curve: Interval(0.0, 1.0, curve: widget.reverseCurve),
          ));
          break;
        case StyledToastAnimation.rotate:
          _reverseAnimController
            ..addListener(() {
              if (mounted) {
                setState(() {});
              }
            });
          rotateAnimReverse = Tween<double>(begin: 2 * math.pi, end: 0.0)
              .animate(CurvedAnimation(
            parent: _reverseAnimController,
            curve: widget.reverseCurve,
          ));
          break;
        case StyledToastAnimation.scaleRotate:
          _reverseAnimController
            ..addListener(() {
              if (mounted) {
                setState(() {});
              }
            });
          scaleAnimReverse =
              Tween<double>(begin: 1.0, end: 0.0).animate(CurvedAnimation(
            parent: _reverseAnimController,
            curve: Interval(0.0, 1.0, curve: widget.reverseCurve),
          ));
          rotateAnimReverse = Tween<double>(begin: 2 * math.pi, end: 0.0)
              .animate(CurvedAnimation(
            parent: _reverseAnimController,
            curve: Interval(0.0, 1.0, curve: widget.reverseCurve),
          ));
          break;
        case StyledToastAnimation.fadeRotate:
          _reverseAnimController
            ..addListener(() {
              if (mounted) {
                setState(() {});
              }
            });
          fadeAnimReverse =
              Tween<double>(begin: 1.0, end: 0.0).animate(CurvedAnimation(
            parent: _reverseAnimController,
            curve: Interval(0.0, 1.0, curve: widget.reverseCurve),
          ));
          rotateAnimReverse = Tween<double>(begin: 2 * math.pi, end: 0.0)
              .animate(CurvedAnimation(
            parent: _reverseAnimController,
            curve: Interval(0.0, 1.0, curve: widget.reverseCurve),
          ));
          break;
        case StyledToastAnimation.none:
          break;
        default:
          fadeAnimReverse =
              Tween<double>(begin: 1.0, end: 0.0).animate(CurvedAnimation(
            parent: _reverseAnimController,
            curve: widget.reverseCurve,
          ));
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget w;

    w = createAnimWidget(w);

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

  ///Create animation widget
  Widget createAnimWidget(Widget w) {
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

    if (widget.reverseAnimation != null) {
      switch (widget.reverseAnimation) {
        case StyledToastAnimation.fade:
          w = FadeTransition(
            opacity: fadeAnimReverse,
            child: w,
          );
          break;
        case StyledToastAnimation.slideToTop:
          w = Transform(
            transform: Matrix4.identity()
              ..setTranslationRaw(0, slideToTopAnimReverse.value, 0),
            alignment: FractionalOffset.topCenter,
            child: w,
          );
          break;
        case StyledToastAnimation.slideToBottom:
          w = Transform(
            transform: Matrix4.identity()
              ..setTranslationRaw(0, slideToBottomAnimReverse.value, 0),
            child: w,
          );
          break;
        case StyledToastAnimation.slideToLeft:
          w = Transform(
            transform: Matrix4.identity()
              ..setTranslationRaw(slideToLeftAnimReverse.value, 0, 0),
            child: w,
          );
          break;
        case StyledToastAnimation.slideToRight:
          w = Transform(
            transform: Matrix4.identity()
              ..setTranslationRaw(slideToRightAnimReverse.value, 0, 0),
            child: w,
          );
          break;
        case StyledToastAnimation.scale:
          w = ScaleTransition(
            scale: scaleAnimReverse,
            child: w,
          );
          break;
        case StyledToastAnimation.fadeScale:
          w = FadeTransition(
            opacity: fadeAnimReverse,
            child: ScaleTransition(
              scale: scaleAnimReverse,
              child: w,
            ),
          );
          break;
        case StyledToastAnimation.rotate:
          w = Transform(
            transform: Matrix4.identity()
              ..setRotationZ(rotateAnimReverse.value),
            alignment: FractionalOffset.center,
            child: w,
          );
          break;
        case StyledToastAnimation.fadeRotate:
          w = FadeTransition(
            opacity: fadeAnimReverse,
            child: Transform(
              transform: Matrix4.identity()
                ..setRotationZ(rotateAnimReverse.value),
              alignment: FractionalOffset.center,
              child: w,
            ),
          );
          break;
        case StyledToastAnimation.scaleRotate:
          w = ScaleTransition(
            scale: scaleAnimReverse,
            child: Transform(
              transform: Matrix4.identity()
                ..setRotationZ(rotateAnimReverse.value),
              alignment: FractionalOffset.center,
              child: w,
            ),
          );
          break;
        case StyledToastAnimation.none:
          break;
        default:
          w = FadeTransition(
            opacity: fadeAnimReverse,
            child: w,
          );
          break;
      }
    }

    return w;
  }

  ///Dismiss toast
  void dismissToast() {
    setState(() {
      opacity = 0.0;
    });
  }

  ///Dismiss toast with animation
  void dismissToastAnim() async {
    if (!mounted) {
      return;
    }
    try {
      if (widget.reverseAnimation != null) {
        await _reverseAnimController.forward().orCancel;
      } else {
        await _animationController.reverse().orCancel;
      }
    } on TickerCanceled {}
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    if (_animationController != null) {
      _animationController.dispose();
    }
    if (widget.reverseAnimation != null && _reverseAnimController != null) {
      _reverseAnimController.dispose();
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

  ///Toast animation duration
  final Duration animDuration;

  ///Position of the toast widget in current window
  final StyledToastPosition toastPositions;

  ///Toast animation
  final StyledToastAnimation toastAnimation;

  ///Toast reverse animation
  final StyledToastAnimation reverseAnimation;

  ///Animation curve
  final Curve curve;

  ///Animation reverse curve
  final Curve reverseCurve;

  ///Dismiss old toast when new one shows
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
    this.animDuration,
    this.toastPositions,
    this.toastAnimation,
    this.reverseAnimation,
    this.curve,
    this.reverseCurve,
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
