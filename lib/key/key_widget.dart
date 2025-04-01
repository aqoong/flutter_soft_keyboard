/*
 * Copyright (c) 2024. AQoong(cooldnjsdn@gmail.com) All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:ripple_container/ripple_container.dart';
import 'package:size_tailored_text/size_tailored_text.dart';
import 'package:flutter_soft_keyboard/keyboard_input_controller.dart';

import 'package:flutter_soft_keyboard/key/virtual_key.dart';

class KeyWidget extends StatelessWidget {
  final KeyboardInputController keyboardInputController;

  final VirtualKey keyData;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final VoidCallback? onDragEnd;

  final double width;
  final double height;
  final double rowSpacing;
  final double columnSpacing;
  final TextStyle? textStyle;

  final Widget? child;

  const KeyWidget({
    required this.keyboardInputController,
    required this.width,
    required this.height,
    required this.keyData,
    this.onTap,
    this.onLongPress,
    this.onDragEnd,
    this.rowSpacing = 0,
    this.columnSpacing = 0,
    this.textStyle,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: rowSpacing / 2,
        vertical: columnSpacing / 2,
      ),
      child: RippleContainer(
        width: width,
        height: height,
        decoration: keyData.decoration,
        onTap: onTap,
        onLongPress: onLongPress,
        onDragEnd: onDragEnd,
        child: LayoutBuilder(
          builder: (context, constraints) => containerChild(child),
        ),
      ),
    );
  }

  Widget containerChild(Widget? child) {
    if (child != null) {
      return child;
    } else {
      return Stack(
        alignment: Alignment.center,
        children: [
          if ((keyData.label ?? '').isNotEmpty)
            SizeTailoredTextWidget(
              keyData.label!,
              width: width,
              height: height,
              style: textStyle,
            ),
          if (keyData.icon != null)
            Align(
              alignment: keyData.iconAlignment,
              child: keyData.icon,
            ),
        ],
      );
    }
  }
}
