import 'dart:ui' as ui;

import 'package:flutter/material.dart';

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

const double _defaultHorizontalMargin = 50.0;

/// Show normal toast with style and animation
/// Can be used without wrapping you app with StyledToast, but must specify context;
/// When you wrap your app with StyledToast, [context] is optional;
ToastFuture showToast(
  String msg, {
  BuildContext context,
  Duration duration,
  Duration animDuration,
  StyledToastPosition position,
  TextStyle textStyle,
  EdgeInsetsGeometry textPadding,
  double toastHorizontalMargin = _defaultHorizontalMargin,
  Color backgroundColor,
  BorderRadius borderRadius,
  ShapeBorder shapeBorder,
  VoidCallback onDismiss,
  TextDirection textDirection,
  bool dismissOtherToast,
  bool movingOnWindowChange,
  StyledToastAnimation animation,
  StyledToastAnimation reverseAnimation,
  AlignmentGeometry alignment,
  Axis axis,
  Offset startOffset,
  Offset endOffset,
  Offset reverseStartOffset,
  Offset reverseEndOffset,
  TextAlign textAlign,
  Curve curve,
  Curve reverseCurve,
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
    margin: EdgeInsets.symmetric(horizontal: toastHorizontalMargin ?? 50.0),
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
    alignment: alignment,
    axis: axis,
    startOffset: startOffset,
    endOffset: endOffset,
    reverseStartOffset: reverseStartOffset,
    reverseEndOffset: reverseEndOffset,
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
  Duration duration,
  Duration animDuration,
  VoidCallback onDismiss,
  bool dismissOtherToast,
  bool movingOnWindowChange,
  TextDirection textDirection,
  AlignmentGeometry alignment,
  Axis axis,
  Offset startOffset,
  Offset endOffset,
  Offset reverseStartOffset,
  Offset reverseEndOffset,
  StyledToastPosition position,
  StyledToastAnimation animation,
  StyledToastAnimation reverseAnimation,
  Curve curve,
  Curve reverseCurve,
}) {
  OverlayEntry entry;
  ToastFuture future;

  context = context != null ? context : currentContext;
  assert(context != null);

  duration ??= _StyledToastTheme.of(context)?.duration ?? _defaultDuration;
  animDuration ??=
      _StyledToastTheme.of(context)?.animDuration ?? _animationDuration;

  dismissOtherToast ??=
      _StyledToastTheme.of(context)?.dismissOtherOnShow ?? true;

  movingOnWindowChange ??=
      _StyledToastTheme.of(context)?.movingOnWindowChange ?? true;

  textDirection ??= textDirection ??
      _StyledToastTheme.of(context)?.textDirection ??
      TextDirection.ltr;

  position ??= _StyledToastTheme.of(context)?.toastPositions ??
      StyledToastPosition.bottom;

  alignment ??= _StyledToastTheme.of(context)?.alignment ?? Alignment.center;

  axis ??= _StyledToastTheme.of(context)?.axis ?? Axis.vertical;

  startOffset ??= _StyledToastTheme.of(context)?.startOffset;
  endOffset ??= _StyledToastTheme.of(context)?.endOffset;
  reverseStartOffset ??= _StyledToastTheme.of(context)?.reverseStartOffset;
  reverseEndOffset ??= _StyledToastTheme.of(context)?.reverseEndOffset;

  curve ??= curve ?? _StyledToastTheme.of(context)?.curve ?? Curves.linear;

  reverseCurve ??= reverseCurve ??
      _StyledToastTheme.of(context)?.reverseCurve ??
      Curves.linear;
  animation ??= animation ??
      _StyledToastTheme.of(context)?.toastAnimation ??
      StyledToastAnimation.fade;
  reverseAnimation ??=
      reverseAnimation ?? _StyledToastTheme.of(context)?.reverseAnimation;

  onDismiss ??= onDismiss ?? _StyledToastTheme.of(context)?.onDismiss;

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
        alignment: alignment,
        axis: axis,
        startOffset: startOffset,
        endOffset: endOffset,
        reverseStartOffset: reverseStartOffset,
        reverseEndOffset: reverseEndOffset,
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

  ///Slide from top fade animation
  slideFromTopFade,

  ///Slide from bottom animation
  slideFromBottom,

  ///Slide from bottom fade animation
  slideFromBottomFade,

  ///Slide from left animation
  slideFromLeft,

  ///Slide from left fade animation
  slideFromLeftFade,

  ///Slide from right animation
  slideFromRight,

  ///Slide from right fade animation
  slideFromRightFade,

  ///Slide to top animation
  slideToTop,

  ///Slide to top fade animation
  slideToTopFade,

  ///Slide to bottom animation
  slideToBottom,

  ///Slide to bottom fade animation
  slideToBottomFade,

  ///Slide to left animation
  slideToLeft,

  ///Slide to left fade animation
  slideToLeftFade,

  ///Slide to right animation
  slideToRight,

  ///Slide to right fade animation
  slideToRightFade,

  ///Scale animation
  scale,

  ///Size animation
  size,

  ///Size fade animation
  sizeFade,

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

  ///Toast animation duration
  final Duration animDuration;

  ///Position of the toast widget in current window
  final StyledToastPosition toastPositions;

  ///Toast animation
  final StyledToastAnimation toastAnimation;

  ///Toast reverse animation
  final StyledToastAnimation reverseAnimation;

  ///Alignment of animation, like size, rotate animation.
  final AlignmentGeometry alignment;

  ///Axis of animation, like size animation
  final Axis axis;

  ///Start offset of slide animation
  final Offset startOffset;

  ///End offset of slide animation
  final Offset endOffset;

  ///Start offset of reverse slide animation
  final Offset reverseStartOffset;

  ///End offset of reverse slide animation
  final Offset reverseEndOffset;

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
      this.animDuration,
      this.toastPositions,
      this.toastAnimation,
      this.reverseAnimation,
      this.alignment,
      this.axis,
      this.startOffset,
      this.endOffset,
      this.reverseStartOffset,
      this.reverseEndOffset,
      this.curve,
      this.reverseCurve,
      this.dismissOtherOnShow = true,
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
        widget.borderRadius ?? BorderRadius.circular(5.0);

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
      animDuration: widget.animDuration,
      toastPositions: widget.toastPositions,
      toastAnimation: widget.toastAnimation,
      reverseAnimation: widget.reverseAnimation,
      alignment: widget.alignment,
      axis: widget.axis,
      startOffset: widget.startOffset,
      endOffset: widget.endOffset,
      reverseStartOffset: widget.reverseStartOffset,
      reverseEndOffset: widget.reverseEndOffset,
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

  ///Alignment of animation, like size, rotate animation.
  final AlignmentGeometry alignment;

  ///Axis of animation, like size animation
  final Axis axis;

  ///Start offset of slide animation
  final Offset startOffset;

  ///End offset of slide animation
  final Offset endOffset;

  ///Start offset of reverse slide animation
  final Offset reverseStartOffset;

  ///End offset of reverse slide animation
  final Offset reverseEndOffset;

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
    this.alignment = Alignment.center,
    this.axis = Axis.vertical,
    this.startOffset,
    this.endOffset,
    this.reverseStartOffset,
    this.reverseEndOffset,
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

  ///Size animation
  Animation<double> sizeAnim;

  ///Slide from top animation
  Animation<Offset> slideFromTopAnim;

  ///Slide from bottom animation
  Animation<Offset> slideFromBottomAnim;

  ///Slide from left animation
  Animation<Offset> slideFromLeftAnim;

  ///Slide from right animation
  Animation<Offset> slideFromRightAnim;

  ///Fade scale animation
  Animation<double> fadeScaleAnim;

  ///Rotate animation
  Animation<double> rotateAnim;

  ///Fade animation reverse
  Animation<double> fadeAnimReverse;

  ///Scale animation reverse
  Animation<double> scaleAnimReverse;

  ///Size animation reverse
  Animation<double> sizeAnimReverse;

  ///Slide from top animation reverse
  Animation<Offset> slideToTopAnimReverse;

  ///Slide from bottom animation reverse
  Animation<Offset> slideToBottomAnimReverse;

  ///Slide from left animation reverse
  Animation<Offset> slideToLeftAnimReverse;

  ///Slide from right animation reverse
  Animation<Offset> slideToRightAnimReverse;

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
        AnimationController(vsync: this, duration: widget.animDuration);

    switch (widget.animation) {
      case StyledToastAnimation.fade:
        fadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
              parent: _animationController,
              curve: widget.curve,
              reverseCurve: widget.reverseCurve),
        );
        break;
      case StyledToastAnimation.slideFromTop:
        slideFromTopAnim = _animationController.drive(
          Tween<Offset>(
                  begin: widget.startOffset ?? Offset(0.0, -1.0),
                  end: widget.endOffset ?? Offset.zero)
              .chain(
            CurveTween(
              curve: widget.curve,
            ),
          ),
        );
        break;
      case StyledToastAnimation.slideFromTopFade:
        slideFromTopAnim = _animationController.drive(
          Tween<Offset>(
                  begin: widget.startOffset ?? Offset(0.0, -1.0),
                  end: widget.endOffset ?? Offset.zero)
              .chain(
            CurveTween(
              curve: widget.curve,
            ),
          ),
        );
        fadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
              parent: _animationController,
              curve: widget.curve,
              reverseCurve: widget.reverseCurve),
        );
        break;
      case StyledToastAnimation.slideFromBottom:
        slideFromBottomAnim = _animationController.drive(
          Tween<Offset>(
                  begin: widget.startOffset ?? Offset(0.0, 1.0),
                  end: widget.endOffset ?? Offset.zero)
              .chain(
            CurveTween(
              curve: widget.curve,
            ),
          ),
        );
        break;
      case StyledToastAnimation.slideFromBottomFade:
        slideFromBottomAnim = _animationController.drive(
          Tween<Offset>(
                  begin: widget.startOffset ?? Offset(0.0, 1.0),
                  end: widget.endOffset ?? Offset.zero)
              .chain(
            CurveTween(
              curve: widget.curve,
            ),
          ),
        );
        fadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
              parent: _animationController,
              curve: widget.curve,
              reverseCurve: widget.reverseCurve),
        );
        break;
      case StyledToastAnimation.slideFromLeft:
        slideFromLeftAnim = _animationController.drive(
          Tween<Offset>(
                  begin: widget.startOffset ?? Offset(-1.0, 0.0),
                  end: widget.endOffset ?? Offset.zero)
              .chain(
            CurveTween(
              curve: widget.curve,
            ),
          ),
        );

        break;
      case StyledToastAnimation.slideFromLeftFade:
        slideFromLeftAnim = _animationController.drive(
          Tween<Offset>(
                  begin: widget.startOffset ?? Offset(-1.0, 0.0),
                  end: widget.endOffset ?? Offset.zero)
              .chain(
            CurveTween(
              curve: widget.curve,
            ),
          ),
        );
        fadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
              parent: _animationController,
              curve: widget.curve,
              reverseCurve: widget.reverseCurve),
        );
        break;
      case StyledToastAnimation.slideFromRight:
        slideFromRightAnim = _animationController.drive(
          Tween<Offset>(
                  begin: widget.startOffset ?? Offset(1.0, 0.0),
                  end: widget.endOffset ?? Offset.zero)
              .chain(
            CurveTween(
              curve: widget.curve,
            ),
          ),
        );

        break;
      case StyledToastAnimation.slideFromRightFade:
        slideFromRightAnim = _animationController.drive(
          Tween<Offset>(
                  begin: widget.startOffset ?? Offset(1.0, 0.0),
                  end: widget.endOffset ?? Offset.zero)
              .chain(
            CurveTween(
              curve: widget.curve,
            ),
          ),
        );
        fadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
              parent: _animationController,
              curve: widget.curve,
              reverseCurve: widget.reverseCurve),
        );
        break;
      case StyledToastAnimation.size:
        sizeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
              parent: _animationController,
              curve: widget.curve,
              reverseCurve: widget.reverseCurve),
        );
        break;
      case StyledToastAnimation.sizeFade:
        sizeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
              parent: _animationController,
              curve: widget.curve,
              reverseCurve: widget.reverseCurve),
        );

        fadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
              parent: _animationController,
              curve: widget.curve,
              reverseCurve: widget.reverseCurve),
        );
        break;
      case StyledToastAnimation.scale:
        scaleAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
              parent: _animationController,
              curve: widget.curve,
              reverseCurve: widget.reverseCurve),
        );
        break;
      case StyledToastAnimation.fadeScale:
        fadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Interval(0.0, 1.0, curve: widget.curve),
            reverseCurve: Interval(0.0, 1.0, curve: widget.reverseCurve),
          ),
        );
        scaleAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Interval(0.0, 1.0, curve: widget.curve),
            reverseCurve: Interval(0.0, 1.0, curve: widget.reverseCurve),
          ),
        );
        break;
      case StyledToastAnimation.rotate:
        rotateAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
              parent: _animationController,
              curve: widget.curve,
              reverseCurve: widget.reverseCurve),
        );
        break;
      case StyledToastAnimation.scaleRotate:
        scaleAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Interval(0.0, 1.0, curve: widget.curve),
            reverseCurve: Interval(0.0, 1.0, curve: widget.reverseCurve),
          ),
        );
        rotateAnim = Tween<double>(begin: 0, end: 1.0).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Interval(0.0, 1.0, curve: widget.curve),
            reverseCurve: Interval(0.0, 1.0, curve: widget.reverseCurve),
          ),
        );
        break;
      case StyledToastAnimation.fadeRotate:
        fadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Interval(0.0, 1.0, curve: widget.curve),
            reverseCurve: Interval(0.0, 1.0, curve: widget.reverseCurve),
          ),
        );
        rotateAnim = Tween<double>(begin: 0, end: 1.0).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Interval(0.0, 1.0, curve: widget.curve),
            reverseCurve: Interval(0.0, 1.0, curve: widget.reverseCurve),
          ),
        );
        break;
      case StyledToastAnimation.none:
        break;
      default:
        fadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
              parent: _animationController,
              curve: widget.curve,
              reverseCurve: widget.reverseCurve),
        );
        break;
    }

    if (widget.reverseAnimation != null &&
        widget.animation != widget.reverseAnimation) {
      _reverseAnimController =
          AnimationController(vsync: this, duration: widget.animDuration);

      switch (widget.reverseAnimation) {
        case StyledToastAnimation.fade:
          fadeAnimReverse = Tween<double>(begin: 1.0, end: 0.0).animate(
            CurvedAnimation(
              parent: _reverseAnimController,
              curve: widget.reverseCurve,
            ),
          );

          break;
        case StyledToastAnimation.slideToTop:
          slideToTopAnimReverse = _reverseAnimController.drive(
            Tween<Offset>(
                    begin: widget.reverseStartOffset ?? Offset.zero,
                    end: widget.reverseEndOffset ?? Offset(0.0, -1.0))
                .chain(
              CurveTween(
                curve: widget.reverseCurve,
              ),
            ),
          );

          break;
        case StyledToastAnimation.slideToTopFade:
          slideToTopAnimReverse = _reverseAnimController.drive(
            Tween<Offset>(
                    begin: widget.reverseStartOffset ?? Offset.zero,
                    end: widget.reverseEndOffset ?? Offset(0.0, -1.0))
                .chain(
              CurveTween(
                curve: widget.reverseCurve,
              ),
            ),
          );
          fadeAnimReverse = Tween<double>(begin: 1.0, end: 0.0).animate(
            CurvedAnimation(
              parent: _reverseAnimController,
              curve: widget.reverseCurve,
            ),
          );
          break;
        case StyledToastAnimation.slideToBottom:
          slideToBottomAnimReverse = _reverseAnimController.drive(
            Tween<Offset>(
                    begin: widget.reverseStartOffset ?? Offset.zero,
                    end: widget.reverseEndOffset ?? Offset(0.0, 1.0))
                .chain(
              CurveTween(
                curve: widget.reverseCurve,
              ),
            ),
          );

          break;
        case StyledToastAnimation.slideToBottomFade:
          slideToBottomAnimReverse = _reverseAnimController.drive(
            Tween<Offset>(
                    begin: widget.reverseStartOffset ?? Offset.zero,
                    end: widget.reverseEndOffset ?? Offset(0.0, 1.0))
                .chain(
              CurveTween(
                curve: widget.reverseCurve,
              ),
            ),
          );
          fadeAnimReverse = Tween<double>(begin: 1.0, end: 0.0).animate(
            CurvedAnimation(
              parent: _reverseAnimController,
              curve: widget.reverseCurve,
            ),
          );
          break;
        case StyledToastAnimation.slideToLeft:
          slideToLeftAnimReverse = _reverseAnimController.drive(
            Tween<Offset>(
                    begin: widget.reverseStartOffset ?? Offset.zero,
                    end: widget.reverseEndOffset ?? Offset(-1.0, 0.0))
                .chain(
              CurveTween(
                curve: widget.reverseCurve,
              ),
            ),
          );

          break;
        case StyledToastAnimation.slideToLeftFade:
          slideToLeftAnimReverse = _reverseAnimController.drive(
            Tween<Offset>(
                    begin: widget.reverseStartOffset ?? Offset.zero,
                    end: widget.reverseEndOffset ?? Offset(-1.0, 0.0))
                .chain(
              CurveTween(
                curve: widget.reverseCurve,
              ),
            ),
          );
          fadeAnimReverse = Tween<double>(begin: 1.0, end: 0.0).animate(
            CurvedAnimation(
              parent: _reverseAnimController,
              curve: widget.reverseCurve,
            ),
          );
          break;
        case StyledToastAnimation.slideToRight:
          slideToRightAnimReverse = _reverseAnimController.drive(
            Tween<Offset>(
                    begin: widget.reverseStartOffset ?? Offset.zero,
                    end: widget.reverseEndOffset ?? Offset(1.0, 0.0))
                .chain(
              CurveTween(
                curve: widget.reverseCurve,
              ),
            ),
          );

          break;
        case StyledToastAnimation.slideToRightFade:
          slideToRightAnimReverse = _reverseAnimController.drive(
            Tween<Offset>(
                    begin: widget.reverseStartOffset ?? Offset.zero,
                    end: widget.reverseEndOffset ?? Offset(1.0, 0.0))
                .chain(
              CurveTween(
                curve: widget.reverseCurve,
              ),
            ),
          );
          fadeAnimReverse = Tween<double>(begin: 1.0, end: 0.0).animate(
            CurvedAnimation(
              parent: _reverseAnimController,
              curve: widget.reverseCurve,
            ),
          );
          break;
        case StyledToastAnimation.size:
          sizeAnimReverse = Tween<double>(begin: 1.0, end: 0.0).animate(
            CurvedAnimation(
                parent: _reverseAnimController,
                curve: widget.reverseCurve,
                reverseCurve: widget.reverseCurve),
          );
          break;
        case StyledToastAnimation.sizeFade:
          sizeAnimReverse = Tween<double>(begin: 1.0, end: 0.0).animate(
            CurvedAnimation(
                parent: _reverseAnimController,
                curve: widget.reverseCurve,
                reverseCurve: widget.reverseCurve),
          );

          fadeAnimReverse = Tween<double>(begin: 1.0, end: 0.0).animate(
            CurvedAnimation(
                parent: _reverseAnimController,
                curve: widget.reverseCurve,
                reverseCurve: widget.reverseCurve),
          );
          break;
        case StyledToastAnimation.scale:
          scaleAnimReverse = Tween<double>(begin: 1.0, end: 0.0).animate(
            CurvedAnimation(
              parent: _reverseAnimController,
              curve: widget.reverseCurve,
            ),
          );
          break;
        case StyledToastAnimation.fadeScale:
          fadeAnimReverse = Tween<double>(begin: 1.0, end: 0.0).animate(
            CurvedAnimation(
              parent: _reverseAnimController,
              curve: Interval(0.0, 1.0, curve: widget.reverseCurve),
            ),
          );
          scaleAnimReverse = Tween<double>(begin: 1.0, end: 0.0).animate(
            CurvedAnimation(
              parent: _reverseAnimController,
              curve: Interval(0.0, 1.0, curve: widget.reverseCurve),
            ),
          );
          break;
        case StyledToastAnimation.rotate:
          rotateAnimReverse = Tween<double>(begin: 1.0, end: 0.0).animate(
            CurvedAnimation(
              parent: _reverseAnimController,
              curve: widget.reverseCurve,
            ),
          );
          break;
        case StyledToastAnimation.scaleRotate:
          scaleAnimReverse = Tween<double>(begin: 1.0, end: 0.0).animate(
            CurvedAnimation(
              parent: _reverseAnimController,
              curve: Interval(0.0, 1.0, curve: widget.reverseCurve),
            ),
          );
          rotateAnimReverse = Tween<double>(begin: 1.0, end: 0.0).animate(
            CurvedAnimation(
              parent: _reverseAnimController,
              curve: Interval(0.0, 1.0, curve: widget.reverseCurve),
            ),
          );
          break;
        case StyledToastAnimation.fadeRotate:
          fadeAnimReverse = Tween<double>(begin: 1.0, end: 0.0).animate(
            CurvedAnimation(
              parent: _reverseAnimController,
              curve: Interval(0.0, 1.0, curve: widget.reverseCurve),
            ),
          );
          rotateAnimReverse = Tween<double>(begin: 1.0, end: 0.0).animate(
            CurvedAnimation(
              parent: _reverseAnimController,
              curve: Interval(0.0, 1.0, curve: widget.reverseCurve),
            ),
          );
          break;
        case StyledToastAnimation.none:
          break;
        default:
          fadeAnimReverse = Tween<double>(begin: 1.0, end: 0.0).animate(
            CurvedAnimation(
              parent: _reverseAnimController,
              curve: widget.reverseCurve,
            ),
          );
          break;
      }
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    Widget w;

    w = createAnimWidget(widget.child);

    w = Opacity(
      opacity: opacity,
      child: w,
    );

    if (movingOnWindowChange != true) {
      var mediaQueryData = MediaQueryData.fromWindow(ui.window);

      Widget container = Container(
        padding: EdgeInsets.only(
            bottom: mediaQueryData.padding.bottom,
            top: mediaQueryData.padding.top),
        alignment: alignment,
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
      } else {
        container = Padding(
          padding: EdgeInsets.all(offset),
          child: container,
        );
      }

      return container;
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
          child: w,
        );
        break;
      case StyledToastAnimation.slideFromTop:
        w = SlideTransition(
          position: slideFromTopAnim,
          child: w,
        );
        break;
      case StyledToastAnimation.slideFromTopFade:
        w = SlideTransition(
          position: slideFromTopAnim,
          child: FadeTransition(
            opacity: fadeAnim,
            child: w,
          ),
        );
        break;
      case StyledToastAnimation.slideFromBottom:
        w = SlideTransition(
          position: slideFromBottomAnim,
          child: w,
        );
        break;
      case StyledToastAnimation.slideFromBottomFade:
        w = SlideTransition(
          position: slideFromBottomAnim,
          child: FadeTransition(
            opacity: fadeAnim,
            child: w,
          ),
        );
        break;
      case StyledToastAnimation.slideFromLeft:
        w = SlideTransition(
          position: slideFromLeftAnim,
          child: w,
        );
        break;
      case StyledToastAnimation.slideFromLeftFade:
        w = SlideTransition(
          position: slideFromLeftAnim,
          child: FadeTransition(
            opacity: fadeAnim,
            child: w,
          ),
        );
        break;
      case StyledToastAnimation.slideFromRight:
        w = SlideTransition(
          position: slideFromRightAnim,
          child: w,
        );
        break;
      case StyledToastAnimation.slideFromRightFade:
        w = SlideTransition(
          position: slideFromRightAnim,
          child: FadeTransition(
            opacity: fadeAnim,
            child: w,
          ),
        );
        break;
      case StyledToastAnimation.size:
        w = Align(
          alignment: widget.alignment ?? Alignment.center,
          child: SizeTransition(
            sizeFactor: sizeAnim,
            axisAlignment: 1.0,
            child: w,
          ),
        );
        break;
      case StyledToastAnimation.sizeFade:
        w = Align(
          alignment: widget.alignment ?? Alignment.center,
          child: SizeTransition(
            sizeFactor: sizeAnim,
            axis: Axis.horizontal,
            child: FadeTransition(
              opacity: fadeAnim,
              child: w,
            ),
          ),
        );
        break;
      case StyledToastAnimation.scale:
        w = ScaleTransition(
          scale: scaleAnim,
          child: w,
        );
        break;
      case StyledToastAnimation.fadeScale:
        w = FadeTransition(
          opacity: fadeAnim,
          child: ScaleTransition(
            scale: scaleAnim,
            alignment: widget.alignment ?? Alignment.center,
            child: w,
          ),
        );
        break;
      case StyledToastAnimation.rotate:
        w = RotationTransition(
          turns: rotateAnim,
          alignment: widget.alignment ?? FractionalOffset.center,
          child: w,
        );
        break;
      case StyledToastAnimation.fadeRotate:
        w = FadeTransition(
          opacity: fadeAnim,
          child: RotationTransition(
            turns: rotateAnim,
            alignment: widget.alignment ?? FractionalOffset.center,
            child: w,
          ),
        );
        break;
      case StyledToastAnimation.scaleRotate:
        w = ScaleTransition(
          scale: scaleAnim,
          alignment: widget.alignment ?? Alignment.center,
          child: RotationTransition(
            turns: rotateAnim,
            alignment: widget.alignment ?? FractionalOffset.center,
            child: w,
          ),
        );
        break;
      case StyledToastAnimation.none:
        w = Container(
          child: w,
        );
        break;
      default:
        w = FadeTransition(
          opacity: fadeAnim,
          child: w,
        );
        break;
    }

    if (widget.reverseAnimation != null &&
        widget.animation != widget.reverseAnimation) {
      switch (widget.reverseAnimation) {
        case StyledToastAnimation.fade:
          w = FadeTransition(
            opacity: fadeAnimReverse,
            child: w,
          );
          break;
        case StyledToastAnimation.slideToTop:
          w = SlideTransition(
            position: slideToTopAnimReverse,
            child: w,
          );
          break;
        case StyledToastAnimation.slideToTopFade:
          w = SlideTransition(
            position: slideToTopAnimReverse,
            child: FadeTransition(
              opacity: fadeAnimReverse,
              child: w,
            ),
          );
          break;
        case StyledToastAnimation.slideToBottom:
          w = SlideTransition(
            position: slideToBottomAnimReverse,
            child: w,
          );
          break;
        case StyledToastAnimation.slideToBottomFade:
          w = SlideTransition(
            position: slideToBottomAnimReverse,
            child: FadeTransition(
              opacity: fadeAnimReverse,
              child: w,
            ),
          );
          break;
        case StyledToastAnimation.slideToLeft:
          w = SlideTransition(
            position: slideToLeftAnimReverse,
            child: w,
          );
          break;
        case StyledToastAnimation.slideToLeftFade:
          w = SlideTransition(
            position: slideToLeftAnimReverse,
            child: FadeTransition(
              opacity: fadeAnimReverse,
              child: w,
            ),
          );
          break;
        case StyledToastAnimation.slideToRight:
          w = SlideTransition(
            position: slideToRightAnimReverse,
            child: w,
          );
          break;
        case StyledToastAnimation.slideToRightFade:
          w = SlideTransition(
            position: slideToRightAnimReverse,
            child: FadeTransition(
              opacity: fadeAnimReverse,
              child: w,
            ),
          );
          break;
        case StyledToastAnimation.size:
          w = Align(
            alignment: widget.alignment ?? Alignment.center,
            child: SizeTransition(
              sizeFactor: sizeAnimReverse,
              child: w,
            ),
          );
          break;
        case StyledToastAnimation.sizeFade:
          w = FadeTransition(
            opacity: fadeAnimReverse,
            child: Align(
              alignment: widget.alignment ?? Alignment.center,
              child: SizeTransition(
                sizeFactor: sizeAnimReverse,
                child: w,
              ),
            ),
          );
          break;
        case StyledToastAnimation.scale:
          w = ScaleTransition(
            scale: scaleAnimReverse,
            alignment: widget.alignment ?? Alignment.center,
            child: w,
          );
          break;
        case StyledToastAnimation.fadeScale:
          w = FadeTransition(
            opacity: fadeAnimReverse,
            child: ScaleTransition(
              scale: scaleAnimReverse,
              alignment: widget.alignment ?? Alignment.center,
              child: w,
            ),
          );
          break;
        case StyledToastAnimation.rotate:
          w = RotationTransition(
            turns: rotateAnimReverse,
            alignment: widget.alignment ??FractionalOffset.center,
            child: w,
          );
          break;
        case StyledToastAnimation.fadeRotate:
          w = FadeTransition(
            opacity: fadeAnimReverse,
            child: RotationTransition(
              turns: rotateAnimReverse,
              alignment: widget.alignment ??FractionalOffset.center,
              child: w,
            ),
          );
          break;
        case StyledToastAnimation.scaleRotate:
          w = ScaleTransition(
            scale: scaleAnimReverse,
            child: RotationTransition(
              turns: rotateAnimReverse,
              alignment: widget.alignment ??FractionalOffset.center,
              child: w,
            ),
          );
          break;
        case StyledToastAnimation.none:
          break;
        default:
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
      if (widget.reverseAnimation != null &&
          _reverseAnimController != null &&
          widget.animation != widget.reverseAnimation) {
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

  ///Alignment of animation, like size, rotate animation.
  final AlignmentGeometry alignment;

  ///Axis of animation, like size animation
  final Axis axis;

  ///Start offset of slide animation
  final Offset startOffset;

  ///End offset of slide animation
  final Offset endOffset;

  ///Start offset of reverse slide animation
  final Offset reverseStartOffset;

  ///End offset of reverse slide animation
  final Offset reverseEndOffset;

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
    this.alignment,
    this.axis,
    this.startOffset,
    this.endOffset,
    this.reverseStartOffset,
    this.reverseEndOffset,
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
