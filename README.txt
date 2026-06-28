VangtiChai — CSE 489 Assignment 1
===================================
Course : CSE 489 Mobile Application Development
Framework : Flutter (Dart)
Min API  : 21 (Android 5.0 Lollipop)

Tested Devices / Screen Types
------------------------------
1. Pixel XL     — 411 x 731 dp  — Portrait ✓  Landscape ✓
2. Nexus 10     — 800 x 1280 dp — Portrait ✓  Landscape ✓
3. Pixel 4      — 393 x 851 dp  — Portrait ✓  Landscape ✓
4. Pixel Tablet — 800 x 1280 dp — Portrait ✓  Landscape ✓

Implementation Notes
---------------------
- All size values (fonts, padding, spacing, radii) are centralised in
  lib/utils/app_sizes.dart — the Flutter equivalent of res/values/sizes.xml.
  No numeric values are hardcoded inside widget files.

- Orientation is detected with OrientationBuilder; Flutter's State object
  survives rotation automatically, so _amount is preserved without any
  extra lifecycle code.

- Tablet detection uses MediaQuery.sizeOf(context).shortestSide >= 600 dp,
  mirroring Android's sw600dp resource qualifier.

- Portrait  : ChangeTable (left, 1-column) | NumericKeypad (right, 3-column)
- Landscape : ChangeTable (left, 2-column) | NumericKeypad (right, 4-column)

- CLEAR button is always given flex:2, giving it the width of two digit
  buttons, matching the screenshots from the assignment.

- Leading zeros are blocked; entry is capped at 9 digits.
