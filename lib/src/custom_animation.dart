import 'package:flutter/material.dart';

/// Builder method for custom animation.
///
/// Get custom animation widget for the [child] toast widget,
/// you can use the internal or external [controller].
typedef CustomAnimationBuilder = Widget Function(
  BuildContext context,
  AnimationController controller,
  Duration duration,
  Widget child,
);

/// Get the animation simply.
///
/// Get the curved [Animation] object conveniently from [start], [end] value drove by the controller.
Animation<T> getAnimation<T>(
  T start,
  T end,
  AnimationController controller, {
  Curve curve = Curves.linearToEaseOut,
}) {
  return controller
      .drive(Tween<T>(begin: start, end: end).chain(CurveTween(curve: curve)));
}
