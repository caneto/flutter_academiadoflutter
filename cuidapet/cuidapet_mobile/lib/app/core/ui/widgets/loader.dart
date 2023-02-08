import 'package:asuka/asuka.dart';
import 'package:flutter/material.dart';

class Loader {
  const Loader._();

  static OverlayEntry? _entry;
  static bool _open = false;

  static void show() {
    _entry ??= OverlayEntry(
      builder: (_) => WillPopScope(
        onWillPop: () async => false,
        child: const ColoredBox(
          color: Colors.black54,
          child: Center(child: CircularProgressIndicator.adaptive()),
        ),
      ),
    );

    if (!_open) {
      _open = true;
      Asuka.addOverlay(_entry!);
    }
  }

  static void hide() {
    if (_open) {
      _open = false;
      _entry?.remove();
    }
  }
}
