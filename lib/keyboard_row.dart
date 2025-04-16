/*
 * Copyright (c) 2025. AQoong(cooldnjsdn@gmail.com) All rights reserved.
 */

import 'package:flutter_soft_keyboard/key/virtual_key.dart';

class KeyboardRow {
  final List<VirtualKey> keys;

  /// Overrides global `fitToMaxRow` if not null.
  final bool? fitToMaxRow;

  /// Optional: custom key width for this row
  final double? keyWidth;

  /// Optional: specific spacing for this row
  final double columnSpacing;

  const KeyboardRow({
    required this.keys,
    this.fitToMaxRow,
    this.keyWidth,
    this.columnSpacing = 6,
  });

  int get rowLength => keys.length;
}