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

## 1.2.1
### Changed
- `size_tailored_text` 의존성을 1.1.0으로 상향했습니다.

## 1.3.0
### Added
- 키별 `onPressed` 콜백을 `VirtualKey`에 추가했습니다. 키가 눌리면 전역 리스너와
  별개로, 입력이 반영된 뒤 호출됩니다.
- `SoftKeyboardWidget`에 `defaultKeyDecoration` / `defaultKeyTextStyle`를 추가했습니다.
  모든 키에 공통 적용되며, 개별 `VirtualKey`가 값을 지정하면 그 값이 우선합니다.
  이제 키마다 decoration/textStyle을 반복하지 않아도 됩니다.
- 특수키를 간결하게 만드는 팩토리 생성자를 추가했습니다:
  `VirtualKey.char`, `VirtualKey.backspace`, `VirtualKey.space`,
  `VirtualKey.enter`, `VirtualKey.clear`.
- `KeyType`에 `shift`, `capsLock`을 추가했습니다. `shift`는 다음 문자 하나에만
  적용되는 일회성 토글, `capsLock`은 다시 누를 때까지 유지되는 토글입니다.
  `VirtualKey.shift()` / `VirtualKey.capsLock()` 팩토리 생성자와,
  `KeyboardInputController`의 상태 게터(`isShiftEnabled`, `isCapsLockEnabled`,
  `isUpperCase`)를 함께 제공합니다. Shift/CapsLock 상태에 따라 키 라벨과 입력
  문자가 대문자로 자동 변환됩니다.
- `VirtualKey.copyWith`를 추가했습니다.

### Fixed
- `setKeyListener`를 여러 번 호출하면 이전 리스너가 제거되지 않고 계속 누적되던 문제를 수정했습니다.
  이제 새 리스너를 등록하기 전에 기존 리스너를 해제합니다.
- Backspace가 UTF-16 코드 유닛 1개만 제거해 이모지·결합 문자가 깨지던 문제를 수정했습니다.
  이제 사용자가 인지하는 문자(grapheme cluster) 단위로 제거합니다.
- `keyLayout`가 비어 있을 때 키 높이 계산에서 0으로 나눠 레이아웃이 깨지던 문제를 방지하는 가드를 추가했습니다.

### Removed
- 사용되지 않던 `findLongestRowIndex` 메서드를 제거했습니다.

기존 `VirtualKey(...)` 2D 배열 방식과 100% 호환됩니다.
