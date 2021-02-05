import 'package:flutter/material.dart';

///Builder method for custom animation
///[context] Widget context
///[controller] Default animation controller
///[duration] Toast duration
///[child] Toast widget
typedef CustomAnimationBuilder = Widget Function(
  BuildContext context,
  AnimationController controller,
  Duration duration,
  Widget child,
);

///Get the animation simply
///[start] Animation start value
///[end] Animation end value
///[controller] Animation controller
///[curve] Curve
Animation<T> getAnimation<T>(
  T start,
  T end,
  AnimationController controller, {
  Curve curve = Curves.linearToEaseOut,
}) {
  return controller
      .drive(Tween<T>(begin: start, end: end).chain(CurveTween(curve: curve)));
}
