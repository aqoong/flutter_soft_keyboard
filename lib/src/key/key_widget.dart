/*
 * Copyright (c) 2024. AQoong(cooldnjsdn@gmail.com) All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:flutter_soft_keyboard/src/key/virtual_key.dart';
import 'package:ripple_container/ripple_container.dart';
import 'package:size_tailored_text/size_tailored_text.dart';
import 'package:flutter_soft_keyboard/src/keyboard_input_controller.dart';


class KeyWidget extends StatelessWidget {
  final KeyboardInputController keyboardInputController;

  final VirtualKey keyData;

  final RippleCallbacks? rippleCallbacks;

  final double width;
  final double height;

  final EdgeInsets? margin;
  final TextStyle? textStyle;

  final Widget? child;

  const KeyWidget({
    required this.keyboardInputController,
    required this.width,
    required this.height,
    required this.keyData,
    this.rippleCallbacks,
    this.margin,
    this.textStyle,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: RippleContainer(
        width: width,
        height: height,
        decoration: keyData.decoration,
        rippleCallbacks: rippleCallbacks,
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
