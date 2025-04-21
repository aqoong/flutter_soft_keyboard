## 1.0.0
* Added usage, comments, etc.
* Organized by adding an EventListener to the KeyboardInputController for easier listener management

## 1.1.0
A child variable has been added to VirtualKey for custom key UI.
If child is not null, options other than KeyType and ContainerDecoration will be ignored, and child
will be displayed as the key.
An example can be found in the “Example” project.

## 1.1.1
* Updated the dependency `ripple_container` to the latest version.
* Improved responsiveness by expanding button behavior to work consistently with long presses and
  drags.

## 1.1.2
* Adjusted the margins of the widgets located at the top, bottom, left, and right edges to ensure
  that the SoftKeyboardWidget fully fits within its defined width and height.
* Converted SoftKeyboardWidget to a StatelessWidget to eliminate unnecessary state management.


## 1.1.3
* Fixed a bug where button sizes changed due to spacing-related updates introduced in version 1.1.2.
* Refactored the button rendering logic for improved structure and maintainability.

## 1.1.4
* Changed key alignment to be centered.
* Fixed an issue where columnSpacing was mistakenly applied as rowSpacing.
* Updated layout to rebuild when width, height, or spacing values change.

## 1.1.5
### Changed
- Replaced separate gesture handlers (`onTap`, `onLongPress`, `onDragEnd`) with the new `RippleCallbacks` interface.
- This refactor improves maintainability and provides a unified way to bind all gesture-related callbacks to `RippleContainer`.