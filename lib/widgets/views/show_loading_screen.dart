import 'package:flutter/material.dart';
import 'package:my_calendar/widgets/message_dialog/message_config.dart';

import 'cupertino_loading.dart';

class ShowLoadingScreen {
  static OverlayEntry? _overlayEntry;

  static void show() {
    if (_overlayEntry != null) {
      return;
    }
    final OverlayState? overlayState = Overlay.of(MessageConfig.contextConfig!);
    _overlayEntry = _showLoading();
    overlayState?.insert(_overlayEntry!);
  }

  static void dismiss() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  static OverlayEntry _showLoading() {
    return OverlayEntry(
      builder: (context) {
        return Scaffold(
          backgroundColor: Colors.grey.withOpacity(0.3),
          body: const Center(child: CupertinoLoading()),
        );
      },
    );
  }
}
