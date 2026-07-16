# FlutterSoftKeyboard

[![pub package](https://img.shields.io/pub/v/flutter_soft_keyboard.svg)](https://pub.dev/packages/flutter_soft_keyboard)

This Flutter package is a virtual keyboard widget that can be implemented using a 2D array.

## What's New in 1.3.0

**Added**
- **Per-key `onPressed` callback** on `VirtualKey` — fires after the input is applied, alongside the global listener.
- **`KeyType.shift` / `KeyType.capsLock`** — `shift` is a one-shot uppercase toggle, `capsLock` is persistent. Both the entered text and the key faces update automatically. Read the state via `isShiftEnabled` / `isCapsLockEnabled` / `isUpperCase`.
- **`defaultKeyDecoration` / `defaultKeyTextStyle`** on `SoftKeyboardWidget` — shared styles are no longer repeated on every key.
- **Concise key factories** — `VirtualKey.char / backspace / space / enter / clear / shift / capsLock`.
- **`VirtualKey.copyWith`**.

**Fixed**
- `setKeyListener` no longer accumulates listeners when called repeatedly.
- Backspace removes a whole grapheme cluster, so emoji / combined characters are no longer corrupted.
- Guard against division by zero when `keyLayout` is empty.

> Fully backward compatible with the existing `VirtualKey(...)` 2D-array style. See [CHANGELOG.md](CHANGELOG.md) for full history.

## Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  flutter_soft_keyboard: ^1.3.0
```

Then run `flutter pub get`.


## How to Use

~~~dart
class _TestState extends State<Test> {
  final keyboardController = KeyboardInputController();

  @override
  void initState() {
    super.initState();
    keyboardController.setKeyListener((lastKey, enteredText) {
      print(lastKey);
      print(enteredText);
    });
  }

  @override
  void dispose() {
    keyboardController.dispose();
    super.dispose();
  }
  ...

  @override
  Widget build(BuildContext context) {
    ...
    SoftKeyboardWidget(
      width: 400,
      height: 300,
      columnSpacing: 4,
      rowSpacing: 4,
      // Applied to every key; a per-key value overrides it, so you don't
      // repeat decoration/textStyle on each key.
      defaultKeyDecoration: keyDecoration,
      defaultKeyTextStyle: keyTextStyle,
      keyLayout: [
        [
          VirtualKey.char('1'),
          VirtualKey.char('2'),
          VirtualKey.char('3'),
          VirtualKey.backspace(icon: const Icon(Icons.backspace)),
        ],
        [
          VirtualKey.char('a'),
          VirtualKey.char('b'),
          // Per-key callback, in addition to the global key listener.
          VirtualKey.char('c', onPressed: (key) => print(key.label)),
        ],
        [
          VirtualKey.space(label: 'space'),
        ],
      ],
      keyboardInputController: keyboardController,
    ),
    ...
  }
}
~~~

### Key factory constructors

Instead of `VirtualKey(type: KeyType.backspace, ...)`, use the concise factories:

| Factory | Purpose |
| --- | --- |
| `VirtualKey.char('a')` | Inputs the given character |
| `VirtualKey.backspace()` | Deletes the last (grapheme) character |
| `VirtualKey.space()` | Inputs a space |
| `VirtualKey.enter()` | Inputs a newline |
| `VirtualKey.clear()` | Clears the whole text |
| `VirtualKey.shift()` | One-shot uppercase for the next character |
| `VirtualKey.capsLock()` | Persistent uppercase until pressed again |

Every key also accepts an `onPressed` callback that fires (after the input is
applied) in addition to the global listener set via `setKeyListener`.

### Shift / Caps Lock

Adding a `VirtualKey.shift()` or `VirtualKey.capsLock()` key enables uppercase
input. `shift` applies to the next single character and then reverts, while
`capsLock` stays on until pressed again (shift inverts caps lock, like a
physical keyboard). Both the entered text and the key faces update
automatically. You can also read the current state from the controller:

```dart
keyboardController.isShiftEnabled;   // one-shot shift armed?
keyboardController.isCapsLockEnabled; // caps lock on?
keyboardController.isUpperCase;       // next character uppercase?
```

## Example

<table style="border-collapse: collapse;border: 1px solid #dddddd;">
    <tr>
        <td>
            <img alt="" src="https://aqoong.github.io/readme-assets/flutter_soft_keyboard/example_keyboard_img.png" width="350"/>
        </td>
        <td>
            <pre><code>
[
            [
              VirtualKey.char('1'),
              VirtualKey.char('2'),
              VirtualKey.char('3'),
              VirtualKey.backspace(icon: Icon(Icons.backspace)),
            ],
            [
              VirtualKey.char('a'),
              VirtualKey.char('b'),
              VirtualKey.char('c'),
            ],
          ]</code></pre>
        </td>
    </tr>
</table>

## License

MIT License

Copyright (c) 2024 AQoong(cooldnjsdn@gmail.com)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.