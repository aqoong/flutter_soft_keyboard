/*
 * Copyright (c) 2024. AQoong(cooldnjsdn@gmail.com) All rights reserved.
 */

import 'package:flutter/material.dart';

import 'key/key_type.dart';
import 'key/virtual_key.dart';

class KeyboardInputController extends ChangeNotifier {
  final StringBuffer _textBuffer = StringBuffer();
  VirtualKey? _lastInputKey;

  /// [text] The text entered so far.
  String get text => _textBuffer.toString();

  /// [lastInputKey] The last key entered.
  /// The key is verified as a VirtualKey class type.
  VirtualKey? get lastInputKey => _lastInputKey;

  Function()? _keyEventListener;

  void setKeyListener(Function(VirtualKey? lastKey, String enteredText) listener) {
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
        _textBuffer.write(key.label); // 문자 키 추가
        break;
      case KeyType.backspace:
        if (_textBuffer.isNotEmpty) {
          _removeLastString(_textBuffer);
        }
        break;
      case KeyType.enter:
        _textBuffer.write('\n');
        break;
      case KeyType.space:
        _textBuffer.write(' ');
        break;
      case KeyType.clear:
        _textBuffer.clear();
        break;
    }
    _lastInputKey = key;
    notifyListeners();
  }

  void clear() {
    _textBuffer.clear();
    notifyListeners();
  }

  void _removeLastString(StringBuffer buffer) {
    if (buffer.isNotEmpty) {
      String current = buffer.toString();
      buffer.clear();
      if (current.isNotEmpty) {
        buffer.write(current.substring(0, current.length - 1));
      }
    }
  }
}