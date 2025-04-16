import 'package:flutter/material.dart';
import 'package:flutter_soft_keyboard/soft_keyboard.dart';

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
      print('last key type : ${lastKey?.type}');
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
        child: Container(
          color: Colors.deepPurple,
          child: SoftKeyboardWidget(
            width: 400,
            height: 300,
            // columnSpacing: 0,
            // rowSpacing: 0,
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
                    icon: const Icon(Icons.abc))
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
              [
                VirtualKey(
                  decoration: keyDecoration,
                  child: Container(
                    width: double.maxFinite,
                    height: double.maxFinite,
                    color: Colors.blue,
                    child: const Text('Custom Widget'),
                  ),
                )
              ],
            ],
            keyboardInputController: keyboardController,
          ),
        ),
      ),
    );
  }
}
