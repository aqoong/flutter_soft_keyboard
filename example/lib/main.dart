import 'package:flutter/material.dart';
import 'package:flutter_soft_keyboard/key/key_type.dart';
import 'package:flutter_soft_keyboard/key/virtual_key.dart';
import 'package:flutter_soft_keyboard/keyboard_input_controller.dart';
import 'package:flutter_soft_keyboard/soft_keyboard_widget.dart';
import 'package:ripple_container/widget/container_decoration.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final keyboardController = KeyboardInputController();

  final ContainerDecoration keyDecoration = ContainerDecoration(
    borderRadius: BorderRadius.circular(20),
    backgroundColor: Colors.amber,
  );

  final TextStyle keyTextStyle = const TextStyle(
    fontSize: 50,
    color: Colors.white,
  );

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SoftKeyboardWidget(
          width: 400,
          height: 300,
          columnSpacing: 4,
          rowSpacing: 4,
          keyLayout: [
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
          ],
          keyboardInputController: keyboardController,
        ),
      ),
    );
  }
}
