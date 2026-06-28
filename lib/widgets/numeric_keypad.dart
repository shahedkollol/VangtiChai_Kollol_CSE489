import 'package:flutter/material.dart';
import '../utils/app_sizes.dart';

/// Custom numeric keypad built entirely from scratch using Flutter layouts.
///
/// Portrait layout (3 columns):
///   1  2  3
///   4  5  6
///   7  8  9
///   0    CLEAR
///
/// Landscape layout (4 columns):
///   1  2  3  4
///   5  6  7  8
///   9  0    CLEAR
///
/// "CLEAR" always has flex: 2 so it spans two column widths.
class NumericKeypad extends StatelessWidget {
  final ValueChanged<String> onDigitPressed;
  final VoidCallback onClearPressed;
  final bool isLandscape;

  const NumericKeypad({
    super.key,
    required this.onDigitPressed,
    required this.onClearPressed,
    this.isLandscape = false,
  });

  // ── Layout definitions ────────────────────────────────────────

  static const _portraitRows = [
    ['1', '2', '3'],
    ['4', '5', '6'],
    ['7', '8', '9'],
    ['0', 'CLEAR'], // 0=flex1, CLEAR=flex2 → same total as 3 columns above
  ];

  static const _landscapeRows = [
    ['1', '2', '3', '4'],
    ['5', '6', '7', '8'],
    ['9', '0', 'CLEAR'], // 9=flex1, 0=flex1, CLEAR=flex2 → 4 columns total
  ];

  // ── Build ─────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final rows = isLandscape ? _landscapeRows : _portraitRows;

    // Each row gets equal vertical space via Expanded.
    return Column(
      children: rows
          .map((row) => Expanded(child: _buildRow(context, row)))
          .toList(),
    );
  }

  Widget _buildRow(BuildContext context, List<String> labels) {
    final spacing = AppSizes.buttonSpacing(context);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: spacing / 2),
      child: Row(
        children: labels.map((label) {
          return Expanded(
            // CLEAR takes twice the width of a digit button
            flex: label == 'CLEAR' ? 2 : 1,
            child: _buildButton(context, label),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildButton(BuildContext context, String label) {
    final isClear = label == 'CLEAR';
    final spacing = AppSizes.buttonSpacing(context);
    final fontSize = AppSizes.buttonFontSize(context);
    final radius = AppSizes.buttonRadius(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: spacing / 2),
      child: SizedBox.expand(
        child: OutlinedButton(
          onPressed: isClear ? onClearPressed : () => onDigitPressed(label),
          style: OutlinedButton.styleFrom(
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius),
            ),
          ),
          child: Text(
            label,
            style: TextStyle(fontSize: fontSize),
          ),
        ),
      ),
    );
  }
}
