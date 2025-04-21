/*
 * Copyright (c) 2024. AQoong(cooldnjsdn@gmail.com) All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:flutter_soft_keyboard/key/key_widget.dart';

import 'package:flutter_soft_keyboard/key/virtual_key.dart';
import 'package:flutter_soft_keyboard/keyboard_input_controller.dart';
import 'package:flutter_soft_keyboard/soft_keyboard.dart';

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

  // /// If `true`, the key size is determined based on the row with the most keys,
  // /// ensuring all keys maintain a uniform size and fill the available space as much as possible.
  // ///
  // /// This allows rows with fewer keys to have centered or evenly spaced keys,
  // /// while keeping the overall layout consistent.
  // final bool fitToMaxRow;

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
  State<SoftKeyboardWidget> createState() => _SoftKeyboardWidgetState();
}

class _SoftKeyboardWidgetState extends State<SoftKeyboardWidget> {
  double itemHeight = 0;

  // double? commonWidth;

  @override
  void initState() {
    super.initState();

    itemHeight = calItemHeight(
        widget.height, widget.rowSpacing, widget.keyLayout.length);

    // if (widget.fitToMaxRow) {
    //   final longIndex = findLongestRowIndex(widget.keyLayout);
    //   commonWidth = (widget.width -
    //           widget.columnSpacing * (widget.keyLayout[longIndex].length - 1)) /
    //       widget.keyLayout[longIndex].length;
    // }
  }

  @override
  void didUpdateWidget(SoftKeyboardWidget oldWidget) {
    if (oldWidget.width != widget.width ||
        oldWidget.height != widget.height ||
        oldWidget.columnSpacing != widget.columnSpacing ||
        oldWidget.rowSpacing != widget.rowSpacing) {
      itemHeight = calItemHeight(
        widget.height,
        widget.rowSpacing,
        widget.keyLayout.length,
      );
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: widget.keyLayout.indexed.map((e) {
          final rowIndex = e.$1;
          final row = e.$2;
          return Container(
            width: widget.width,
            height: itemHeight,
            margin: EdgeInsets.only(
              top: rowIndex == 0 ? 0 : widget.rowSpacing,
            ),
            child: keyRow(rowIndex, row),
          );
        }).toList(),
      ),
    );
  }

  Widget keyRow(int rowIndex, List<VirtualKey> list) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: list.indexed.map((e) {
          final columnIndex = e.$1;
          final itemWidth =
              (widget.width - widget.columnSpacing * (list.length - 1)) /
                  list.length;

          return KeyWidget(
            keyboardInputController: widget.keyboardInputController,
            keyData: e.$2,
            rippleCallbacks: RippleCallbacks(
              onTapDown: (_) => widget.keyboardInputController.onKeyPress(e.$2),
              onDragEnd: (_) => widget.keyboardInputController.onKeyPress(e.$2),
            ),
            width: itemWidth,
            height: double.maxFinite,
            margin: EdgeInsets.only(
              left: columnIndex == 0 ? 0 : widget.columnSpacing,
            ),
            textStyle: e.$2.textStyle,
            child: e.$2.child,
          );
        }).toList(),
      );

  int findLongestRowIndex(List<List<VirtualKey>> keyLayout) {
    int maxIndex = 0;
    int maxLength = 0;

    for (int i = 0; i < keyLayout.length; i++) {
      if (keyLayout[i].length > maxLength) {
        maxLength = keyLayout[i].length;
        maxIndex = i;
      }
    }

    return maxIndex;
  }

  double calItemHeight(double areaHeight, double rowSpacing, int rowLength) {
    double itemHeight = (areaHeight - rowSpacing * (rowLength - 1)) / rowLength;
    final checkSum = itemHeight * rowLength + rowSpacing * (rowLength - 1);
    if (areaHeight - checkSum < 0) {
      itemHeight = areaHeight / rowLength;
    }
    return itemHeight;
  }
}
