/*
 * Copyright (c) 2024. AQoong(cooldnjsdn@gmail.com) All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:flutter_soft_keyboard/src/key/key_type.dart';
import 'package:ripple_container/widget/container_decoration.dart';

class VirtualKey {
  /// [label]
  /// Text displayed on the key (Required when KeyType is character).
  final String? label;

  /// [type] is Key's type , Enum KeyType
  final KeyType type;

  ///[icon]
  ///Icon widget to be displayed on the key instead of text or
  ///alongside the text.
  final Icon? icon;
  final Alignment iconAlignment;

  ///[decoration] is Key decoration
  ///This uses the ContainerDecoration type from the ripple_container package.
  final ContainerDecoration? decoration;

  /// [textStyle] key text style
  final TextStyle? textStyle;

  /// If [child] is not null, it is expressed ignoring settings except for
  /// [type] and [decoration].
  final Widget? child;

  /// [onPressed] is called whenever this specific key is pressed.
  ///
  /// It runs in addition to the global listener registered through
  /// [KeyboardInputController.setKeyListener], and fires after the key's
  /// [type] has been applied to the entered text. The pressed key itself is
  /// passed as the argument for convenience.
  final void Function(VirtualKey key)? onPressed;

  VirtualKey({
    this.label,
    this.type = KeyType.character,
    this.icon,
    this.iconAlignment = Alignment.topCenter,
    this.decoration,
    this.textStyle,
    this.child,
    this.onPressed,
  }) : assert(
          (child == null ? (type != KeyType.character || label != null) : true),
          'Character keys must have a label',
        );

  /// A character key that inputs [label] into the text buffer.
  factory VirtualKey.char(
    String label, {
    Icon? icon,
    Alignment iconAlignment = Alignment.topCenter,
    ContainerDecoration? decoration,
    TextStyle? textStyle,
    Widget? child,
    void Function(VirtualKey key)? onPressed,
  }) =>
      VirtualKey(
        label: label,
        icon: icon,
        iconAlignment: iconAlignment,
        decoration: decoration,
        textStyle: textStyle,
        child: child,
        onPressed: onPressed,
      );

  /// A backspace key that deletes the last entered character.
  factory VirtualKey.backspace({
    String? label,
    Icon? icon,
    Alignment iconAlignment = Alignment.center,
    ContainerDecoration? decoration,
    TextStyle? textStyle,
    Widget? child,
    void Function(VirtualKey key)? onPressed,
  }) =>
      VirtualKey(
        label: label,
        type: KeyType.backspace,
        icon: icon,
        iconAlignment: iconAlignment,
        decoration: decoration,
        textStyle: textStyle,
        child: child,
        onPressed: onPressed,
      );

  /// A space key that inputs a single space character.
  factory VirtualKey.space({
    String? label,
    Icon? icon,
    Alignment iconAlignment = Alignment.center,
    ContainerDecoration? decoration,
    TextStyle? textStyle,
    Widget? child,
    void Function(VirtualKey key)? onPressed,
  }) =>
      VirtualKey(
        label: label,
        type: KeyType.space,
        icon: icon,
        iconAlignment: iconAlignment,
        decoration: decoration,
        textStyle: textStyle,
        child: child,
        onPressed: onPressed,
      );

  /// An enter key that inputs a newline character.
  factory VirtualKey.enter({
    String? label,
    Icon? icon,
    Alignment iconAlignment = Alignment.center,
    ContainerDecoration? decoration,
    TextStyle? textStyle,
    Widget? child,
    void Function(VirtualKey key)? onPressed,
  }) =>
      VirtualKey(
        label: label,
        type: KeyType.enter,
        icon: icon,
        iconAlignment: iconAlignment,
        decoration: decoration,
        textStyle: textStyle,
        child: child,
        onPressed: onPressed,
      );

  /// A clear key that empties the whole text buffer.
  factory VirtualKey.clear({
    String? label,
    Icon? icon,
    Alignment iconAlignment = Alignment.center,
    ContainerDecoration? decoration,
    TextStyle? textStyle,
    Widget? child,
    void Function(VirtualKey key)? onPressed,
  }) =>
      VirtualKey(
        label: label,
        type: KeyType.clear,
        icon: icon,
        iconAlignment: iconAlignment,
        decoration: decoration,
        textStyle: textStyle,
        child: child,
        onPressed: onPressed,
      );

  /// A shift key. Applies uppercase to the next single character, then reverts.
  factory VirtualKey.shift({
    String? label,
    Icon? icon,
    Alignment iconAlignment = Alignment.center,
    ContainerDecoration? decoration,
    TextStyle? textStyle,
    Widget? child,
    void Function(VirtualKey key)? onPressed,
  }) =>
      VirtualKey(
        label: label,
        type: KeyType.shift,
        icon: icon,
        iconAlignment: iconAlignment,
        decoration: decoration,
        textStyle: textStyle,
        child: child,
        onPressed: onPressed,
      );

  /// A caps-lock key. Toggles persistent uppercase until pressed again.
  factory VirtualKey.capsLock({
    String? label,
    Icon? icon,
    Alignment iconAlignment = Alignment.center,
    ContainerDecoration? decoration,
    TextStyle? textStyle,
    Widget? child,
    void Function(VirtualKey key)? onPressed,
  }) =>
      VirtualKey(
        label: label,
        type: KeyType.capsLock,
        icon: icon,
        iconAlignment: iconAlignment,
        decoration: decoration,
        textStyle: textStyle,
        child: child,
        onPressed: onPressed,
      );

  /// Returns a copy of this [VirtualKey] with the given fields replaced.
  ///
  /// Fields left `null` keep their current value. To intentionally clear an
  /// optional field, build a new [VirtualKey] instead.
  VirtualKey copyWith({
    String? label,
    KeyType? type,
    Icon? icon,
    Alignment? iconAlignment,
    ContainerDecoration? decoration,
    TextStyle? textStyle,
    Widget? child,
    void Function(VirtualKey key)? onPressed,
  }) {
    return VirtualKey(
      label: label ?? this.label,
      type: type ?? this.type,
      icon: icon ?? this.icon,
      iconAlignment: iconAlignment ?? this.iconAlignment,
      decoration: decoration ?? this.decoration,
      textStyle: textStyle ?? this.textStyle,
      child: child ?? this.child,
      onPressed: onPressed ?? this.onPressed,
    );
  }
}
