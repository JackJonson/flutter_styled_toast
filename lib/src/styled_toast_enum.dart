import 'package:flutter/widgets.dart';

/// Toast position.
class StyledToastPosition {
  /// Toast position align.
  final Alignment align;

  /// Toast position offset.
  ///
  /// if align is topLeft/topCenter/topRight, offset is the distance from top,
  /// if align is centerLeft, offset is the distance from left,
  /// if align is centerRight, offset is the distance from right,
  /// if align is bottomLeft/bottomCenter/bottomRight, offset is the distance from bottom.
  final double offset;

  const StyledToastPosition({this.align = Alignment.center, this.offset = 0.0});

  /// Center position.
  static const center =
      const StyledToastPosition(align: Alignment.center, offset: 0.0);

  /// Top center position.
  static const top =
      const StyledToastPosition(align: Alignment.topCenter, offset: 10.0);

  /// Bottom center position.
  static const bottom =
      const StyledToastPosition(align: Alignment.bottomCenter, offset: 20.0);

  /// Center left position.
  static const left =
      const StyledToastPosition(align: Alignment.centerLeft, offset: 17.0);

  /// Center right position.
  static const right =
      const StyledToastPosition(align: Alignment.centerRight, offset: 17.0);
}

/// Toast showing type.
enum StyledToastShowType {
  /// Dismiss old toast widget that is showing.
  dismissShowing,

  /// Show a new toast.
  normal,
}

/// Toast animation.
enum StyledToastAnimation {
  /// Fade in and out animation.
  fade,

  /// Slide from top animation.
  slideFromTop,

  /// Slide from top fade animation.
  slideFromTopFade,

  /// Slide from bottom animation.
  slideFromBottom,

  /// Slide from bottom fade animation.
  slideFromBottomFade,

  /// Slide from left animation.
  slideFromLeft,

  /// Slide from left fade animation.
  slideFromLeftFade,

  /// Slide from right animation.
  slideFromRight,

  /// Slide from right fade animation.
  slideFromRightFade,

  /// Slide to top animation.
  slideToTop,

  /// Slide to top fade animation.
  slideToTopFade,

  /// Slide to bottom animation.
  slideToBottom,

  /// Slide to bottom fade animation.
  slideToBottomFade,

  /// Slide to left animation.
  slideToLeft,

  /// Slide to left fade animation.
  slideToLeftFade,

  /// Slide to right animation.
  slideToRight,

  /// Slide to right fade animation.
  slideToRightFade,

  /// Scale animation.
  scale,

  /// Size animation.
  size,

  /// Size fade animation.
  sizeFade,

  /// Fade scale animation.
  fadeScale,

  /// Rotate animation.
  rotate,

  /// Fade rotate animation.
  fadeRotate,

  /// Scale rotate animation.
  scaleRotate,

  /// No animation.
  none,
}
