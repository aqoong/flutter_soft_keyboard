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

## 1.2.0
### Changed
- didUpdateWidget에서 width/height/간격만 보고 itemHeight를 다시 계산하고 있어, 행 개수(keyLayout.length)만 바뀌는 경우에는 키 높이가 갱신되지 않았습니다.
  → keyLayout.length가 바뀔 때도 itemHeight를 다시 계산하도록 조건을 추가해 수정했습니다.
- 버그 / 동작 이슈
  - setKeyListener를 여러 번 호출하면 리스너가 계속 쌓이는 문제 
  - Backspace 시 substring(0, length-1) 사용으로 인한 이모지/한글 등 유니코드 깨짐 가능성 
  - 예제에서 두 번째 행 라벨이 '1','2','3'으로 중복된 부분 
- 코드 정리 
  - 사용되지 않는 findLongestRowIndex 제거 또는 주석 정리 
  - 주석 처리된 fitToMaxRow 관련 코드·의도 정리 
  - ripple_container re-export 범위/문서 정리
- 기능·API 제안 
  - VirtualKey.copyWith 추가 
  - 키 목록에 Key(ValueKey/ObjectKey) 지정 
  - KeyboardInputController의 dispose 책임 문서화 
  - KeyType 확장(shift, capsLock 등)