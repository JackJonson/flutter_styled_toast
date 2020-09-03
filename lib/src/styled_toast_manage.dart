import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_styled_toast/src/styled_toast.dart';

/// Use the method to dismiss all toast.
void dismissAllToast({bool showAnim = false}) {
  ToastManager().dismissAll(showAnim: showAnim);
}

/// Use the [dismiss] to dismiss toast.
/// When the Toast is dismissed, call [onDismiss] if specified;
class ToastFuture {
  final OverlayEntry _entry;
  final VoidCallback _onDismiss;
  bool _isShow = true;
  final GlobalKey<StyledToastWidgetState> _containerKey;

  /// A [Timer] used to dismiss this toast future after the given period of time.
  Timer _timer;

  ToastFuture.create(
    Duration duration,
    this._entry,
    this._onDismiss,
    this._containerKey,
  ) {
    _timer = Timer(duration, () => dismiss());
  }

  void dismiss(
      {bool showAnim = false, Duration animDuration = animationDuration}) {
    if (!_isShow) {
      return;
    }

    _isShow = false;
    _timer.cancel();
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
