/*
 * Copyright (c) 2024. AQoong(cooldnjsdn@gmail.com) All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:flutter_soft_keyboard/src/key/key_type.dart';
import 'package:flutter_soft_keyboard/src/key/key_widget.dart';
import 'package:flutter_soft_keyboard/src/key/virtual_key.dart';
import 'package:flutter_soft_keyboard/src/keyboard_input_controller.dart';
import 'package:ripple_container/widget/container_decoration.dart';
import 'package:ripple_container/widget/ripple_callbacks.dart';


class SoftKeyboardWidget extends StatefulWidget {
  /// This widget operates only within the size defined by [width] and [height].
  /// Keys specified in [keyLayout] are positioned within the boundaries of
  /// [width] and [height].
  final double width;
  final double height;

  final KeyboardInputController keyboardInputController;

  /// [keyLayout] is a crucial variable for implementing the key arrangement.
  /// When provided as a 2D array, keys in each array are aligned and displayed
  /// accordingly.
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

  /// Default decoration applied to every key that does not define its own
  /// [VirtualKey.decoration]. Lets you avoid repeating the same decoration on
  /// each key.
  final ContainerDecoration? defaultKeyDecoration;

  /// Default text style applied to every key that does not define its own
  /// [VirtualKey.textStyle]. A per-key [VirtualKey.textStyle] takes precedence.
  final TextStyle? defaultKeyTextStyle;

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
    this.defaultKeyDecoration,
    this.defaultKeyTextStyle,
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
      widget.height,
      widget.rowSpacing,
      widget.keyLayout.length,
    );

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
        oldWidget.rowSpacing != widget.rowSpacing ||
        oldWidget.keyLayout.length != widget.keyLayout.length) {
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
    // Rebuild when shift / caps-lock state changes so key faces reflect the
    // current case. For keyboards without shift/caps keys the state never
    // changes, so this rebuilds no more often than before.
    return ListenableBuilder(
      listenable: widget.keyboardInputController,
      builder: (context, _) => SizedBox(
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

          // Apply widget-level defaults to any key that did not set its own
          // decoration / text style, so callers don't repeat them per key.
          final key = e.$2.copyWith(
            decoration: e.$2.decoration ?? widget.defaultKeyDecoration,
            textStyle: e.$2.textStyle ?? widget.defaultKeyTextStyle,
          );

          // The face may show an uppercased label while shift / caps-lock is
          // active, but the original key is what drives input so the
          // controller stays the single source of truth for casing.
          final displayKey = _displayKey(key);

          return KeyWidget(
            keyboardInputController: widget.keyboardInputController,
            keyData: displayKey,
            rippleCallbacks: RippleCallbacks(
              onTapDown: (_) => widget.keyboardInputController.onKeyPress(key),
              onDragEnd: (_) => widget.keyboardInputController.onKeyPress(key),
            ),
            width: itemWidth,
            height: double.maxFinite,
            margin: EdgeInsets.only(
              left: columnIndex == 0 ? 0 : widget.columnSpacing,
            ),
            textStyle: displayKey.textStyle,
            child: displayKey.child,
          );
        }).toList(),
      );

  /// Returns the key to render. Character keys with a plain text label are
  /// shown uppercased while shift / caps-lock is active; custom [child] keys
  /// are left untouched.
  VirtualKey _displayKey(VirtualKey key) {
    if (key.type != KeyType.character ||
        key.child != null ||
        (key.label ?? '').isEmpty ||
        !widget.keyboardInputController.isUpperCase) {
      return key;
    }
    return key.copyWith(label: key.label!.toUpperCase());
  }

  double calItemHeight(double areaHeight, double rowSpacing, int rowLength) {
    // Guard against an empty layout to avoid division by zero (Infinity/NaN).
    if (rowLength <= 0) return 0;
    double itemHeight = (areaHeight - rowSpacing * (rowLength - 1)) / rowLength;
    final checkSum = itemHeight * rowLength + rowSpacing * (rowLength - 1);
    if (areaHeight - checkSum < 0) {
      itemHeight = areaHeight / rowLength;
    }
    return itemHeight;
  }
}
