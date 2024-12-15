# FlutterSoftKeyboard

This Flutter package is a virtual keyboard widget that can be implemented using a 2D array.


## How to Use

~~~

class _TestState extends State<Test> {
  final keyboardController = KeyboardInputController();

  /// [
  ///   [VirtualKey(...), VirtualKey(...), ...],
  ///   [VirtualKey(...), VirtualKey(...), ...],
  ///   ...
  /// ]
  final List<List<VirtualKey>> keyLayout;

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
  widget build(BuildContext context) {
    ...
    SoftKeyboardWidget(
          width: 400,
          height: 300,
          columnSpacing: 4,
          rowSpacing: 4,
          keyLayout: keyLayout
          keyboardInputController: keyboardController,
        ),
    ...
  }
}

~~~

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
              VirtualKey(
                  label: '1',
                  decoration: keyDecoration,
                  textStyle: keyTextStyle),
              VirtualKey(
                  label: '2',
                  decoration: keyDecoration,
                  textStyle: keyTextStyle),
              VirtualKey(
                  label: '3',
                  decoration: keyDecoration,
                  textStyle: keyTextStyle),
              VirtualKey(
                  decoration: keyDecoration,
                  textStyle: keyTextStyle,
                  type: KeyType.backspace,
                  icon: Icon(Icons.abc))
            ],
            [
              VirtualKey(
                  label: '1',
                  decoration: keyDecoration,
                  textStyle: keyTextStyle),
              VirtualKey(
                  label: '2',
                  decoration: keyDecoration,
                  textStyle: keyTextStyle),
              VirtualKey(
                  label: '3',
                  decoration: keyDecoration,
                  textStyle: keyTextStyle)
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