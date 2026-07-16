/*
 * Copyright (c) 2024. AQoong(cooldnjsdn@gmail.com) All rights reserved.
 */

enum KeyType {
  character,
  backspace,
  enter,
  space,
  clear,

  /// Applies uppercase to the next single character, then automatically
  /// reverts (one-shot toggle).
  shift,

  /// Toggles persistent uppercase until pressed again.
  capsLock,
}
