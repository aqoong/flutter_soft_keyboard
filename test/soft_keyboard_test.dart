import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_soft_keyboard/flutter_soft_keyboard.dart';

void main() {
  group('KeyboardInputController', () {
    test('appends character labels to text', () {
      final controller = KeyboardInputController();
      controller.onKeyPress(VirtualKey(label: 'a'));
      controller.onKeyPress(VirtualKey(label: 'b'));
      expect(controller.text, 'ab');
      controller.dispose();
    });

    test('backspace removes a whole grapheme cluster (emoji safe)', () {
      final controller = KeyboardInputController();
      controller.onKeyPress(VirtualKey(label: '👍'));
      expect(controller.text, '👍');

      controller.onKeyPress(VirtualKey(type: KeyType.backspace));
      expect(
        controller.text,
        isEmpty,
        reason: 'emoji surrogate pair should be removed as a single unit',
      );
      controller.dispose();
    });

    test('space, enter and clear behave correctly', () {
      final controller = KeyboardInputController();
      controller.onKeyPress(VirtualKey(label: 'a'));
      controller.onKeyPress(VirtualKey(type: KeyType.space));
      controller.onKeyPress(VirtualKey(label: 'b'));
      controller.onKeyPress(VirtualKey(type: KeyType.enter));
      expect(controller.text, 'a b\n');

      controller.onKeyPress(VirtualKey(type: KeyType.clear));
      expect(controller.text, isEmpty);
      controller.dispose();
    });

    test('setKeyListener does not accumulate listeners when called repeatedly',
        () {
      final controller = KeyboardInputController();
      var calls = 0;
      controller.setKeyListener((_, __) => calls++);
      controller.setKeyListener((_, __) => calls++);

      controller.onKeyPress(VirtualKey(label: 'a'));
      expect(calls, 1, reason: 'only the latest listener should fire once');
      controller.dispose();
    });
  });

  group('shift / capsLock', () {
    test('shift uppercases only the next single character', () {
      final controller = KeyboardInputController();
      controller.onKeyPress(VirtualKey.shift());
      expect(controller.isShiftEnabled, isTrue);
      expect(controller.isUpperCase, isTrue);

      controller.onKeyPress(VirtualKey.char('a'));
      expect(controller.text, 'A');
      expect(
        controller.isShiftEnabled,
        isFalse,
        reason: 'shift should be consumed after one character',
      );

      controller.onKeyPress(VirtualKey.char('b'));
      expect(controller.text, 'Ab');
      controller.dispose();
    });

    test('capsLock persists until pressed again', () {
      final controller = KeyboardInputController();
      controller.onKeyPress(VirtualKey.capsLock());
      expect(controller.isCapsLockEnabled, isTrue);

      controller.onKeyPress(VirtualKey.char('a'));
      controller.onKeyPress(VirtualKey.char('b'));
      expect(controller.text, 'AB');

      controller.onKeyPress(VirtualKey.capsLock());
      controller.onKeyPress(VirtualKey.char('c'));
      expect(controller.text, 'ABc');
      controller.dispose();
    });

    test('shift inverts capsLock (both on => lowercase)', () {
      final controller = KeyboardInputController();
      controller.onKeyPress(VirtualKey.capsLock());
      controller.onKeyPress(VirtualKey.shift());
      expect(controller.isUpperCase, isFalse);

      controller.onKeyPress(VirtualKey.char('a'));
      expect(controller.text, 'a');
      controller.dispose();
    });
  });

  group('VirtualKey per-key onPressed', () {
    test('fires after the key effect is applied', () {
      final controller = KeyboardInputController();
      String? seen;
      final key = VirtualKey.char(
        'a',
        onPressed: (_) => seen = controller.text,
      );
      controller.onKeyPress(key);
      expect(seen, 'a', reason: 'callback should observe up-to-date text');
      controller.dispose();
    });
  });

  group('VirtualKey factory constructors', () {
    test('assign the expected key types', () {
      expect(VirtualKey.char('a').type, KeyType.character);
      expect(VirtualKey.backspace().type, KeyType.backspace);
      expect(VirtualKey.space().type, KeyType.space);
      expect(VirtualKey.enter().type, KeyType.enter);
      expect(VirtualKey.clear().type, KeyType.clear);
      expect(VirtualKey.shift().type, KeyType.shift);
      expect(VirtualKey.capsLock().type, KeyType.capsLock);
    });
  });

  group('VirtualKey.copyWith', () {
    test('overrides only the provided fields', () {
      final base = VirtualKey(label: 'a');
      final copy = base.copyWith(label: 'b');
      expect(copy.label, 'b');
      expect(copy.type, KeyType.character);
    });

    test('keeps original values when no override is given', () {
      final base = VirtualKey(
        label: 'x',
        textStyle: const TextStyle(fontSize: 12),
      );
      final copy = base.copyWith();
      expect(copy.label, 'x');
      expect(copy.textStyle?.fontSize, 12);
    });
  });
}
