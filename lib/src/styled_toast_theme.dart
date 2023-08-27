import 'package:flutter/widgets.dart';
import 'custom_animation.dart';
import 'styled_toast.dart';
import 'styled_toast_enum.dart';

/// Toast theme, only for default content widget.
///
/// If you have specified a custom content widget, [ToastTheme] will not be working.
class StyledToastTheme extends InheritedWidget {
  /// Text align.
  final TextAlign? textAlign;

  /// Text direction.
  final TextDirection? textDirection;

  /// Border radius.
  final BorderRadius? borderRadius;

  /// Background color.
  final Color? backgroundColor;

  /// Padding for the text and the container edges.
  final EdgeInsets? textPadding;

  /// Text style for content.
  final TextStyle? textStyle;

  /// Shape for the container.
  final ShapeBorder? shapeBorder;

  /// Toast show duration.
  final Duration? duration;

  /// Toast animation duration.
  final Duration? animDuration;

  /// Position of the toast widget in current window.
  final StyledToastPosition? toastPositions;

  /// Alignment of animation, like size, rotate animation.
  final Alignment? alignment;

  /// Axis of animation, like size animation.
  final Axis? axis;

  /// Start offset of slide animation.
  final Offset? startOffset;

  /// End offset of slide animation.
  final Offset? endOffset;

  /// Start offset of reverse slide animation.
  final Offset? reverseStartOffset;

  /// End offset of reverse slide animation.
  final Offset? reverseEndOffset;

  /// Toast animation.
  final StyledToastAnimation? toastAnimation;

  /// Toast reverse animation.
  final StyledToastAnimation? reverseAnimation;

  /// Animation curve.
  final Curve? curve;

  /// Animation reverse curve.
  final Curve? reverseCurve;

  /// Dismiss old toast when new one shows.
  final bool? dismissOtherOnShow;

  /// Callback when toast dismissed.
  final VoidCallback? onDismiss;

  /// Full width that the width of the screen minus the width of the margin.
  final bool? fullWidth;

  /// Is hide keyboard when toast show.
  final bool? isHideKeyboard;

  /// Custom animation builder method.
  final CustomAnimationBuilder? animationBuilder;

  /// Custom animation builder method.
  final CustomAnimationBuilder? reverseAnimBuilder;

  /// Is the input ignored for the toast.
  final bool? isIgnoring;

  /// When toast widget [initState], this callback will be called.
  final OnInitStateCallback? onInitState;

  const StyledToastTheme({
    super.key,
    required super.child,
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
    this.onDismiss,
    this.fullWidth,
    this.isHideKeyboard,
    this.animationBuilder,
    this.reverseAnimBuilder,
    this.isIgnoring,
    this.onInitState,
  });

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  /// Get the [StyledToastTheme] object.
  static StyledToastTheme of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<StyledToastTheme>()!;

  /// Try to find the [StyledToastTheme] object in the widgets tree.
  static StyledToastTheme? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<StyledToastTheme>();
}
