import 'package:flutter/material.dart';
import 'package:flutter_soft_keyboard/flutter_soft_keyboard.dart';

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
  String text = '';

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
      debugPrint('last key type : ${lastKey?.type}');
      debugPrint(enteredText);
      setState(() {
        text = enteredText;
      });
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text),
            LayoutBuilder(
              builder: (context, constraints) => SoftKeyboardWidget(
                width: constraints.maxWidth,
                height: 300,
                columnSpacing: 6,
                rowSpacing: 6,
                // Applied to every key that doesn't override them, so you no
                // longer repeat decoration/textStyle on each key.
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
                    // Per-key onPressed callback example.
                    VirtualKey.char('c', onPressed: (key) {
                      debugPrint('pressed: ${key.label}');
                    }),
                  ],
                  [
                    // shift: one-shot uppercase / capsLock: persistent uppercase.
                    VirtualKey.shift(icon: const Icon(Icons.arrow_upward)),
                    VirtualKey.capsLock(icon: const Icon(Icons.keyboard_capslock)),
                  ],
                  [
                    VirtualKey.space(label: 'White Space'),
                  ],
                ],
                keyboardInputController: keyboardController,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
