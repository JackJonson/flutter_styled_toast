import 'package:flutter/widgets.dart';
import 'package:flutter_styled_toast/src/custom_animation.dart';
import 'package:flutter_styled_toast/src/styled_toast.dart';
import 'package:flutter_styled_toast/src/styled_toast_enum.dart';

///
///created time: 2019-06-18 10:49
///author linzhiliang
///version 1.5.0
///since
///file name: styled_toast.dart
///description: Toast theme, only for default content widget;
///If you have specified a custom content widget, ToastTheme will not be working.
///
class StyledToastTheme extends InheritedWidget {
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
  @deprecated
  final bool movingOnWindowChange;

  ///Callback when toast dismissed
  final VoidCallback onDismiss;

  ///Full width that the width of the screen minus the width of the margin.
  final bool fullWidth;

  ///Is hide keyboard when toast show
  final bool isHideKeyboard;

  ///Custom animation builder method
  final CustomAnimationBuilder animationBuilder;

  ///Custom animation builder method
  final CustomAnimationBuilder reverseAnimBuilder;

  ///When toast widget [initState], this callback will be called.
  final OnInitStateCallback onInitState;

  StyledToastTheme({
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
    this.fullWidth,
    this.isHideKeyboard,
    this.animationBuilder,
    this.reverseAnimBuilder,
    this.onInitState,
  }) : super(child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    // TODO: implement updateShouldNotify
    return true;
  }

  static StyledToastTheme of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<StyledToastTheme>();
}
