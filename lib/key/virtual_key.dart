/*
 * Copyright (c) 2024. AQoong(cooldnjsdn@gmail.com) All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:ripple_container/widget/container_decoration.dart';
import 'package:soft_keyboard/key/key_type.dart';

class VirtualKey {
  final String? label; // 키에 표시되는 텍스트 (KeyType이 character일 때 사용)
  final KeyType type; // 키의 유형
  final Icon? icon; // KeyType이 character가 아닌 경우 표시할 아이콘
  final Alignment iconAlignment;

  final ContainerDecoration? decoration;
  final TextStyle? textStyle;

  VirtualKey({
    this.label,
    this.type = KeyType.character,
    this.icon,
    this.iconAlignment = Alignment.topCenter,
    this.decoration,
    this.textStyle,
  }) : assert(
  (type == KeyType.character && label != null) ||
      (type != KeyType.character && icon != null),
  'Character keys must have a label, and non-character keys must have an icon.',
  );
}