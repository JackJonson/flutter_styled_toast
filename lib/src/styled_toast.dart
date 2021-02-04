import 'dart:ui' as ui;
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_styled_toast/src/custom_animation.dart';
import 'package:flutter_styled_toast/src/styled_toast_enum.dart';
import 'package:flutter_styled_toast/src/styled_toast_manage.dart';
import 'package:flutter_styled_toast/src/styled_toast_theme.dart';

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
const animationDuration = Duration(milliseconds: 400);

///The default horizontal margin of toast
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
  bool fullWidth,
  bool isHideKeyboard,
  CustomAnimationBuilder customAnimationBuilder,
  CustomAnimationBuilder customReverseAnimationBuilder,
}) {
  context = context != null ? context : currentContext;
  assert(context != null);

  StyledToastTheme _toastTheme = StyledToastTheme.of(context);

  position ??= _toastTheme?.toastPositions ?? StyledToastPosition.bottom;

  textStyle ??=
      _toastTheme?.textStyle ?? TextStyle(fontSize: 16.0, color: Colors.white);

  textPadding ??= _toastTheme?.textPadding ??
      EdgeInsets.symmetric(horizontal: 17.0, vertical: 10.0);

  backgroundColor ??= _toastTheme?.backgroundColor ?? const Color(0x99000000);
  borderRadius ??= _toastTheme?.borderRadius ?? BorderRadius.circular(5.0);

  shapeBorder ??= _toastTheme?.shapeBorder ??
      RoundedRectangleBorder(
        borderRadius: borderRadius,
      );

  textDirection ??= _toastTheme?.textDirection ?? TextDirection.ltr;

  textAlign ??= _toastTheme?.textAlign ?? TextAlign.center;

  fullWidth ??= _toastTheme?.fullWidth ?? false;

  Widget widget = Container(
    margin: EdgeInsets.symmetric(horizontal: toastHorizontalMargin ?? 50.0),
    width: fullWidth
        ? MediaQuery.of(context).size.width - (toastHorizontalMargin ?? 50.0)
        : null,
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
    isHideKeyboard: isHideKeyboard,
    customAnimationBuilder: customAnimationBuilder,
    customReverseAnimationBuilder: customReverseAnimationBuilder,
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
  bool isHideKeyboard,
  CustomAnimationBuilder customAnimationBuilder,
  CustomAnimationBuilder customReverseAnimationBuilder,
}) {
  OverlayEntry entry;
  ToastFuture future;

  context = context != null ? context : currentContext;
  assert(context != null);

  StyledToastTheme _toastTheme = StyledToastTheme.of(context);

  isHideKeyboard ??= _toastTheme?.isHideKeyboard ?? false;

  duration ??= _toastTheme?.duration ?? _defaultDuration;

  animDuration ??= _toastTheme?.animDuration ?? animationDuration;

  dismissOtherToast ??= _toastTheme?.dismissOtherOnShow ?? true;

  movingOnWindowChange ??= _toastTheme?.movingOnWindowChange ?? true;

  textDirection ??=
      textDirection ?? _toastTheme?.textDirection ?? TextDirection.ltr;

  position ??= _toastTheme?.toastPositions ?? StyledToastPosition.bottom;

  alignment ??= _toastTheme?.alignment ?? Alignment.center;

  axis ??= _toastTheme?.axis ?? Axis.vertical;

  startOffset ??= _toastTheme?.startOffset;
  endOffset ??= _toastTheme?.endOffset;
  reverseStartOffset ??= _toastTheme?.reverseStartOffset;
  reverseEndOffset ??= _toastTheme?.reverseEndOffset;

  curve ??= curve ?? _toastTheme?.curve ?? Curves.linear;

  reverseCurve ??= reverseCurve ?? _toastTheme?.reverseCurve ?? Curves.linear;
  animation ??=
      animation ?? _toastTheme?.toastAnimation ?? StyledToastAnimation.fade;
  reverseAnimation ??= reverseAnimation ?? _toastTheme?.reverseAnimation;

  customAnimationBuilder ??=
      customAnimationBuilder ?? _toastTheme?.customAnimationBuilder;

  customReverseAnimationBuilder ??= customReverseAnimationBuilder ??
      _toastTheme?.customReverseAnimationBuilder;

  onDismiss ??= onDismiss ?? _toastTheme?.onDismiss;

  if (isHideKeyboard) {
    ///Hide keyboard
    FocusScope.of(context).requestFocus(FocusNode());
  }

  GlobalKey<StyledToastWidgetState> key = GlobalKey();

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
        customAnimationBuilder: customAnimationBuilder,
        customReverseAnimationBuilder: customReverseAnimationBuilder,
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

  dismissOtherToast ??= _toastTheme?.dismissOtherOnShow ?? false;

  if (dismissOtherToast == true) {
    ToastManager().dismissAll();
  }

  future = ToastFuture.create(duration, entry, onDismiss, key);

  Overlay.of(context).insert(entry);
  ToastManager().addFuture(future);

  return future;
}

///
///created time: 2019-06-18 10:47
///author linzhiliang
///version 1.5.0
///since
///file name: styled_toast.dart
///description:
///Toast configuration widget, which we use to save the overall configuration for toast widget in.
///
class StyledToast extends StatelessWidget {
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

  ///The locale of you app
  final Locale locale;

  ///Full width that the width of the screen minus the width of the margin.
  final bool fullWidth;

  ///Is hide keyboard when toast show
  final bool isHideKeyboard;

  ///Custom animation builder method
  final CustomAnimationBuilder customAnimationBuilder;

  ///Custom animation builder method
  final CustomAnimationBuilder customReverseAnimationBuilder;

  StyledToast({
    Key key,
    @required this.child,
    @required this.locale,
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
    this.onDismiss,
    this.fullWidth,
    this.isHideKeyboard,
    this.customAnimationBuilder,
    this.customReverseAnimationBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget overlay = Overlay(
      initialEntries: <OverlayEntry>[
        OverlayEntry(builder: (ctx) {
          currentContext = ctx;
          return child;
        })
      ],
    );

    TextDirection mTextDirection = textDirection ?? TextDirection.ltr;

    Widget wrapper = Directionality(
        textDirection: mTextDirection,
        child: Stack(
          children: <Widget>[
            overlay,
          ],
        ));

    TextStyle mTextStyle = textStyle ??
        TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.normal,
          color: Colors.white,
        );

    Color mBackgroundColor = backgroundColor ?? const Color(0x99000000);

    BorderRadius mBorderRadius = borderRadius ?? BorderRadius.circular(5.0);

    TextAlign mTextAlign = textAlign ?? TextAlign.center;
    EdgeInsets mTextPadding = textPadding ??
        const EdgeInsets.symmetric(
          horizontal: 17.0,
          vertical: 8.0,
        );

    return MediaQuery(
      child: Localizations(
        delegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        locale: locale ?? const Locale('en', 'US'),
        child: StyledToastTheme(
          child: wrapper,
          textAlign: mTextAlign,
          textDirection: mTextDirection,
          borderRadius: mBorderRadius,
          backgroundColor: mBackgroundColor,
          textPadding: mTextPadding,
          textStyle: mTextStyle,
          shapeBorder: shapeBorder,
          duration: duration,
          animDuration: animDuration,
          toastPositions: toastPositions,
          toastAnimation: toastAnimation,
          reverseAnimation: reverseAnimation,
          alignment: alignment,
          axis: axis,
          startOffset: startOffset,
          endOffset: endOffset,
          reverseStartOffset: reverseStartOffset,
          reverseEndOffset: reverseEndOffset,
          curve: curve,
          reverseCurve: reverseCurve,
          dismissOtherOnShow: dismissOtherOnShow,
          movingOnWindowChange: movingOnWindowChange,
          onDismiss: onDismiss,
          fullWidth: fullWidth,
          isHideKeyboard: isHideKeyboard,
          customAnimationBuilder: customAnimationBuilder,
          customReverseAnimationBuilder: customReverseAnimationBuilder,
        ),
      ),
      data: MediaQueryData.fromWindow(WidgetsBinding.instance.window),
    );
  }
}

///
///created time: 2019-06-18 10:44
///author linzhiliang
///version 1.5.0
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

  ///Alignment of animation, scale, rotate animation.
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

  ///Custom animation builder method
  final CustomAnimationBuilder customAnimationBuilder;

  ///Custom animation builder method
  final CustomAnimationBuilder customReverseAnimationBuilder;

  _StyledToastWidget({
    Key key,
    this.child,
    this.duration,
    this.animDuration,
    this.curve = Curves.linear,
    this.reverseCurve = Curves.linear,
    this.position = StyledToastPosition.bottom,
    this.alignment = Alignment.center,
    this.axis = Axis.horizontal,
    this.startOffset,
    this.endOffset,
    this.reverseStartOffset,
    this.reverseEndOffset,
    this.animation = StyledToastAnimation.fade,
    this.reverseAnimation,
    this.movingOnWindowChange = true,
    this.customAnimationBuilder,
    this.customReverseAnimationBuilder,
  })  : assert(animDuration * 2 <= duration),
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return StyledToastWidgetState();
  }
}

class StyledToastWidgetState extends State<_StyledToastWidget>
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

  ///Opacity of this widget
  double opacity = 1.0;

  ///When window change, moving toast.
  bool get movingOnWindowChange => widget.movingOnWindowChange;

  ///Toast position offset
  double get offset => widget.position.offset;

  ///Toast alignment in the screen
  AlignmentGeometry get positionAlignment => widget.position.align;

  /// A [Timer] needed to dismiss the toast with animation
  /// after the given [duration] of time.
  Timer _toastTimer;

  @override
  void initState() {
    super.initState();

    _initAnim();

    _animationController.forward();

    //Dismiss toast
    _toastTimer = Timer(widget.duration - widget.animDuration, () async {
      dismissToastAnim();
    });

    WidgetsBinding.instance.addObserver(this);
  }

  ///Init animation
  void _initAnim() {
    _animationController =
        AnimationController(vsync: this, duration: widget.animDuration);

    _reverseAnimController =
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
    Widget w = widget.child;

    if (widget.customAnimationBuilder != null ||
        widget.customReverseAnimationBuilder != null) {
      w = widget.customAnimationBuilder != null
          ? widget.customAnimationBuilder.call(
              context, _animationController, widget.duration, w)
          : w;
      w = widget.customReverseAnimationBuilder != null
          ? widget.customReverseAnimationBuilder.call(
              context, _reverseAnimController, widget.duration, w)
          : w;
    } else {
      w = createAnimWidget(w);
    }

    w = Opacity(
      opacity: opacity,
      child: w,
    );

    if (movingOnWindowChange != true) {
      MediaQueryData mediaQueryData = MediaQueryData.fromWindow(ui.window);

      w = Container(
        padding: EdgeInsets.only(
            bottom: mediaQueryData.padding.bottom,
            top: mediaQueryData.padding.top),
        alignment: positionAlignment,
        child: w,
      );
    } else {
      w = Container(
        alignment: positionAlignment,
        child: w,
      );
    }

    if (Alignment.center == positionAlignment) {
    } else if (Alignment.bottomCenter == positionAlignment) {
      w = Padding(
        padding: EdgeInsets.only(bottom: offset),
        child: w,
      );
    } else if (Alignment.topCenter == positionAlignment) {
      w = Padding(
        padding: EdgeInsets.only(top: offset),
        child: w,
      );
    } else if (Alignment.topLeft == positionAlignment) {
      w = Padding(
        padding: EdgeInsets.only(top: offset),
        child: w,
      );
    } else if (Alignment.topRight == positionAlignment) {
      w = Padding(
        padding: EdgeInsets.only(top: offset),
        child: w,
      );
    } else if (Alignment.centerLeft == positionAlignment) {
      w = Padding(
        padding: EdgeInsets.only(left: offset),
        child: w,
      );
    } else if (Alignment.centerRight == positionAlignment) {
      w = Padding(
        padding: EdgeInsets.only(right: offset),
        child: w,
      );
    } else if (Alignment.bottomLeft == positionAlignment) {
      w = Padding(
        padding: EdgeInsets.only(bottom: offset),
        child: w,
      );
    } else if (Alignment.bottomRight == positionAlignment) {
      w = Padding(
        padding: EdgeInsets.only(bottom: offset),
        child: w,
      );
    } else {
      w = Padding(
        padding: EdgeInsets.all(offset),
        child: w,
      );
    }

    return w;
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
        w = CustomSizeTransition(
          sizeFactor: sizeAnim,
          alignment: positionAlignment ?? Alignment.center,
          axisAlignment: 0.0,
          axis: widget.axis ?? Axis.horizontal,
          child: w,
        );
        break;
      case StyledToastAnimation.sizeFade:
        w = CustomSizeTransition(
          sizeFactor: sizeAnim,
          axisAlignment: 0.0,
          alignment: positionAlignment ?? Alignment.center,
          axis: widget.axis ?? Axis.horizontal,
          child: FadeTransition(
            opacity: fadeAnim,
            child: w,
          ),
        );
        break;
      case StyledToastAnimation.scale:
        w = ScaleTransition(
          scale: scaleAnim,
          alignment: widget.alignment ?? Alignment.center,
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
          w = CustomSizeTransition(
            alignment: positionAlignment ?? Alignment.center,
            axis: widget.axis ?? Axis.horizontal,
            sizeFactor: sizeAnimReverse,
            child: w,
          );
          break;
        case StyledToastAnimation.sizeFade:
          w = FadeTransition(
            opacity: fadeAnimReverse,
            child: CustomSizeTransition(
              alignment: positionAlignment ?? Alignment.center,
              axis: widget.axis ?? Axis.horizontal,
              sizeFactor: sizeAnimReverse,
              child: w,
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
            alignment: widget.alignment ?? FractionalOffset.center,
            child: w,
          );
          break;
        case StyledToastAnimation.fadeRotate:
          w = FadeTransition(
            opacity: fadeAnimReverse,
            child: RotationTransition(
              turns: rotateAnimReverse,
              alignment: widget.alignment ?? FractionalOffset.center,
              child: w,
            ),
          );
          break;
        case StyledToastAnimation.scaleRotate:
          w = ScaleTransition(
            scale: scaleAnimReverse,
            child: RotationTransition(
              turns: rotateAnimReverse,
              alignment: widget.alignment ?? FractionalOffset.center,
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
    _toastTimer?.cancel();
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
      if (_reverseAnimController != null) {
        await _reverseAnimController.forward().orCancel;
      } else {
        await _animationController.reverse().orCancel;
      }
    } on TickerCanceled {}
  }

  @override
  void dispose() {
    _toastTimer?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    if (_animationController != null) {
      _animationController.dispose();
    }
    if ( _reverseAnimController != null) {
      _reverseAnimController.dispose();
    }
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    if (this.mounted) setState(() {});
  }
}
