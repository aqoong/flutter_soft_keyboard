/*
 * Copyright (c) 2024. AQoong(cooldnjsdn@gmail.com) All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:flutter_soft_keyboard/key/key_widget.dart';

import 'package:flutter_soft_keyboard/key/virtual_key.dart';
import 'package:flutter_soft_keyboard/keyboard_input_controller.dart';

class SoftKeyboardWidget extends StatelessWidget {
  /// This widget operates only within the size defined by [width] and [height].
  /// Keys specified in [keyLayout] are positioned within the boundaries of [width] and [height].
  final double width;
  final double height;

  final KeyboardInputController keyboardInputController;

  /// [keyLayout] is a crucial variable for implementing the key arrangement.
  /// When provided as a 2D array, keys in each array are aligned and displayed accordingly.
  ///
  /// example
  /// [
  ///   [VirtualKey(...), VirtualKey(...), ...],
  ///   [VirtualKey(...), VirtualKey(...), ...],
  ///   ...
  /// ]
  final List<List<VirtualKey>> keyLayout;
  final double columnSpacing;
  final double rowSpacing;

  const SoftKeyboardWidget({
    required this.keyboardInputController,
    required this.width,
    required this.height,
    required this.keyLayout,
    this.columnSpacing = 6,
    this.rowSpacing = 6,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children:
            keyLayout.indexed.map((e) => keyRow(e.$1, e.$2)).toList(),
      ),
    );
  }

  Widget keyRow(int rowIndex, List<VirtualKey> list) => Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: list.indexed.map((e) {
            final columnIndex = e.$1;
            return Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) => KeyWidget(
                  keyboardInputController: keyboardInputController,
                  keyData: e.$2,
                  onTap: () => keyboardInputController.onKeyPress(e.$2),
                  onLongPress: () =>
                      keyboardInputController.onKeyPress(e.$2),
                  onDragEnd: () =>
                      keyboardInputController.onKeyPress(e.$2),
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  margin: EdgeInsets.only(
                    left: columnIndex == 0 ? 0 : rowSpacing,
                    right:
                        columnIndex == list.length - 1 ? 0 : rowSpacing,
                    top: rowIndex == 0 ? 0 : columnSpacing,
                    bottom: rowIndex == keyLayout.length - 1
                        ? 0
                        : columnSpacing,
                  ),
                  textStyle: e.$2.textStyle,
                  child: e.$2.child,
                ),
              ),
            );
          }).toList(),
        ),
      );
}
