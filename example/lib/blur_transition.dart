import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// Blur transition
class BlurTransition extends AnimatedWidget {
  /// Creates a blur transition.
  const BlurTransition({
    Key? key,
    required this.sigma,
    this.child,
  }) : super(key: key, listenable: sigma);

  final Animation<double> sigma;

  /// The widget below this widget in the tree.
  ///
  /// {@macro flutter.widgets.child}
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: sigma.value, sigmaY: sigma.value),
      child: child,
    );
  }
}
