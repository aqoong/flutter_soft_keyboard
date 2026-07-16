/*
 * Copyright (c) 2024. AQoong(cooldnjsdn@gmail.com) All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:flutter_soft_keyboard/src/key/key_type.dart';
import 'package:flutter_soft_keyboard/src/key/virtual_key.dart';


class KeyboardInputController extends ChangeNotifier {
  final StringBuffer _textBuffer = StringBuffer();
  VirtualKey? _lastInputKey;

  /// [text] The text entered so far.
  String get text => _textBuffer.toString();

  /// [lastInputKey] The last key entered.
  /// The key is verified as a VirtualKey class type.
  VirtualKey? get lastInputKey => _lastInputKey;

  bool _shiftEnabled = false;
  bool _capsLockEnabled = false;

  /// Whether the one-shot [KeyType.shift] is currently armed.
  /// It is consumed (reset to `false`) right after the next character input.
  bool get isShiftEnabled => _shiftEnabled;

  /// Whether the persistent [KeyType.capsLock] is currently on.
  bool get isCapsLockEnabled => _capsLockEnabled;

  /// Whether the next character will be entered in uppercase.
  /// Shift inverts Caps Lock, mirroring physical keyboards.
  bool get isUpperCase => _capsLockEnabled ^ _shiftEnabled;

  Function()? _keyEventListener;

  void setKeyListener(
    Function(VirtualKey? lastKey, String enteredText) listener,
  ) {
    // Remove any previously registered listener so repeated calls do not
    // accumulate listeners on the underlying ChangeNotifier.
    if (_keyEventListener != null) {
      super.removeListener(_keyEventListener!);
    }
    _keyEventListener = () {
      listener(_lastInputKey, text);
    };
    super.addListener(_keyEventListener!);
  }

  @override
  void dispose() {
    if (_keyEventListener != null) {
      super.removeListener(_keyEventListener!);
    }
    super.dispose();
  }

  void onKeyPress(VirtualKey key) {
    switch (key.type) {
      case KeyType.character:
        if (key.label != null) {
          // Apply the current shift / caps-lock state to the character.
          _textBuffer
              .write(isUpperCase ? key.label!.toUpperCase() : key.label);
        }
        // Shift is a one-shot modifier: consume it after a character input.
        _shiftEnabled = false;
      case KeyType.backspace:
        if (_textBuffer.isNotEmpty) {
          _removeLastString(_textBuffer);
        }
      case KeyType.enter:
        _textBuffer.write('\n');
      case KeyType.space:
        _textBuffer.write(' ');
      case KeyType.clear:
        _textBuffer.clear();
      case KeyType.shift:
        _shiftEnabled = !_shiftEnabled;
      case KeyType.capsLock:
        _capsLockEnabled = !_capsLockEnabled;
    }
    _lastInputKey = key;
    notifyListeners();

    // Per-key callback runs after the key's effect has been applied and
    // listeners were notified, so handlers observe the up-to-date [text].
    key.onPressed?.call(key);
  }

  void clear() {
    _textBuffer.clear();
    notifyListeners();
  }

  void _removeLastString(StringBuffer buffer) {
    if (buffer.isEmpty) return;
    // Remove the last user-perceived character (grapheme cluster) instead of a
    // single UTF-16 code unit, so emoji / combined characters are not corrupted.
    final String current = buffer.toString();
    buffer.clear();
    buffer.write(current.characters.skipLast(1).toString());
  }
}
