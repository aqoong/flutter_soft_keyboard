/*
 * Copyright (c) 2024. AQoong(cooldnjsdn@gmail.com) All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:flutter_soft_keyboard/key/key_widget.dart';

import 'key/virtual_key.dart';
import 'keyboard_input_controller.dart';

class SoftKeyboardWidget extends StatefulWidget {
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
    super.key,
    required this.keyboardInputController,
    required this.width,
    required this.height,
    required this.keyLayout,
    this.columnSpacing = 6,
    this.rowSpacing = 6,
  });

  @override
  State<SoftKeyboardWidget> createState() => _SoftKeyboardWidgetState();
}

class _SoftKeyboardWidgetState extends State<SoftKeyboardWidget> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: widget.keyLayout
            .asMap()
            .map(
              (rowIndex, rowList) => MapEntry(
                rowIndex,
                keyRow(rowIndex),
              ),
            )
            .values
            .toList(),
      ),
    );
  }

  Widget keyRow(int rowIndex) => Expanded(
      flex: 1,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: widget.keyLayout[rowIndex]
            .map(
              (e) => Expanded(
                flex: 1,
                child: LayoutBuilder(
                  builder: (context, constraints) => KeyWidget(
                    keyboardInputController: widget.keyboardInputController,
                    keyData: e,
                    onTap: () => widget.keyboardInputController.onKeyPress(e),
                    width: constraints.maxWidth,
                    height: constraints.maxHeight,
                    rowSpacing: widget.rowSpacing,
                    columnSpacing: widget.columnSpacing,
                    textStyle: e.textStyle,
                  ),
                ),
              ),
            )
            .toList(),
      ));

  void test() {

  }
}
