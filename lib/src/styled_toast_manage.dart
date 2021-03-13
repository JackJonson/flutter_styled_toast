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
  ///Toast overlay
  final OverlayEntry _entry;

  ///Callback when toast dismiss
  final VoidCallback? _onDismiss;

  ///Toast widget key
  final GlobalKey<StyledToastWidgetState> _containerKey;

  ///Is toast showing
  bool _isShow = true;

  /// A [Timer] used to dismiss this toast future after the given period of time.
  Timer? _timer;

  OverlayEntry get entry => _entry;

  VoidCallback? get onDismiss => _onDismiss;

  bool get isShow => _isShow;

  GlobalKey get containerKey => _containerKey;

  ToastFuture.create(
    Duration duration,
    this._entry,
    this._onDismiss,
    this._containerKey,
  ) {
    if (duration != Duration.zero) {
      _timer = Timer(duration, () => dismiss());
    }
  }

  ///Dismiss toast
  Future<void> dismiss({
    bool showAnim = false,
  }) async {
    if (!_isShow) {
      return;
    }

    _isShow = false;
    _timer?.cancel();
    _onDismiss?.call();
    ToastManager().removeFuture(this);
    if (showAnim) {
      await _containerKey.currentState?.dismissToastAnim();
    } else {
      _containerKey.currentState?.dismissToast();
    }
    _entry.remove();
  }
}

///Toast manager, manage toast list
class ToastManager {
  ToastManager._();

  ///Instance of ToastManager
  static ToastManager? _instance;

  factory ToastManager() {
    _instance ??= ToastManager._();
    return _instance!;
  }

  ///Set used to save [ToastFuture]
  Set<ToastFuture> toastSet = Set();

  ///Dismiss all toast
  void dismissAll({
    bool showAnim = false,
  }) {
    toastSet.toList().forEach((v) {
      v.dismiss(showAnim: showAnim);
    });
  }

  ///Remove toast.
  void removeFuture(ToastFuture future) {
    toastSet.remove(future);
  }

  ///Add toast
  void addFuture(ToastFuture future) {
    toastSet.add(future);
  }
}
