/*
 * Copyright (c) 2024. AQoong(cooldnjsdn@gmail.com) All rights reserved.
 */

import 'package:flutter/material.dart';

import 'key/key_type.dart';
import 'key/virtual_key.dart';

class KeyboardInputController extends ChangeNotifier {
  final StringBuffer _textBuffer = StringBuffer(); // 입력값 저장용
  VirtualKey? _lastInputKey;

  /// 현재 입력된 텍스트
  String get text => _textBuffer.toString();
  VirtualKey? get lastInputKey => _lastInputKey;


  /// 키 입력 처리
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
        _textBuffer.write('\n'); // 줄바꿈 추가
        break;
      case KeyType.space:
        _textBuffer.write(' '); // 공백 추가
        break;
      default:
        break; // 기타 특수 키는 여기서 처리
    }
    _lastInputKey = key;
    notifyListeners(); // 상태 변경 알림
  }

  /// 입력값 초기화
  void clear() {
    _textBuffer.clear();
    notifyListeners();
  }

  void _removeLastString(StringBuffer buffer) {
    if (buffer.isNotEmpty) {
      String current = buffer.toString();
      buffer.clear(); // 기존 내용을 지웁니다.
      if (current.isNotEmpty) {
        buffer.write(current.substring(0, current.length - 1));
      }
    }
  }
}