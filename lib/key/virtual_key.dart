/*
 * Copyright (c) 2024. AQoong(cooldnjsdn@gmail.com) All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:ripple_container/widget/container_decoration.dart';
import 'package:flutter_soft_keyboard/key/key_type.dart';

class VirtualKey {
  /// [label]
  /// Text displayed on the key (Required when KeyType is character).
  final String? label;

  /// [type] is Key's type , Enum KeyType
  final KeyType type;

  ///[icon]
  ///Icon widget to be displayed on the key instead of text or alongside the text.
  final Icon? icon;
  final Alignment iconAlignment;

  ///[decoration] is Key decoration
  ///This uses the ContainerDecoration type from the ripple_container package.
  final ContainerDecoration? decoration;

  /// [textStyle] key text style
  final TextStyle? textStyle;

  VirtualKey({
    this.label,
    this.type = KeyType.character,
    this.icon,
    this.iconAlignment = Alignment.topCenter,
    this.decoration,
    this.textStyle,
  }) : assert(
  (type == KeyType.character && label != null),
  'Character keys must have a label',
  );
}