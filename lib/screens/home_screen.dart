import 'package:flutter/material.dart';

import '../utils/change_calculator.dart';
import '../utils/app_sizes.dart';
import '../widgets/amount_display.dart';
import '../widgets/change_table.dart';
import '../widgets/numeric_keypad.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /// The currently entered digit string, e.g. "234".
  /// Flutter State is NOT destroyed on orientation change,
  /// so this field is automatically preserved — no extra code needed.
  String _amount = '';

  // ── Input handlers ────────────────────────────────────────────

  void _onDigit(String digit) {
    setState(() {
      if (_amount.isEmpty && digit == '0') return; // block leading zero
      if (_amount.length >= 9) return;             // cap at 9 digits
      _amount += digit;
    });
  }

  void _onClear() => setState(() => _amount = '');

  // ── Derived values ────────────────────────────────────────────

  int get _amountValue => _amount.isEmpty ? 0 : int.parse(_amount);
  Map<int, int> get _change => ChangeCalculator.calculate(_amountValue);

  // ── Build ─────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('VangtiChai'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: OrientationBuilder(
        builder: (ctx, orientation) => orientation == Orientation.portrait
            ? _buildPortrait(ctx)
            : _buildLandscape(ctx),
      ),
    );
  }

  // ── Portrait layout ───────────────────────────────────────────
  //
  //  ┌──────────────────────────────┐
  //  │        Taka: 688             │  ← AmountDisplay
  //  ├─────────────┬────────────────┤
  //  │  500: 1     │  1  │  2  │ 3 │
  //  │  100: 1     │  4  │  5  │ 6 │
  //  │   50: 1     │  7  │  8  │ 9 │
  //  │   20: 1     │  0  │  CLEAR  │
  //  │   10: 1     │                │
  //  │    5: 1     │                │
  //  │    2: 1     │                │
  //  │    1: 1     │                │
  //  └─────────────┴────────────────┘

  Widget _buildPortrait(BuildContext context) {
    return Column(
      children: [
        AmountDisplay(amount: _amount),
        const Divider(height: 1, thickness: 1),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Left: change breakdown ──
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(AppSizes.cardPadding(context)),
                  child: ChangeTable(change: _change),
                ),
              ),
              const VerticalDivider(width: 1, thickness: 1),
              // ── Right: keypad ──
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(AppSizes.buttonSpacing(context)),
                  child: NumericKeypad(
                    onDigitPressed: _onDigit,
                    onClearPressed: _onClear,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ── Landscape layout ──────────────────────────────────────────
  //
  //  ┌──────────────────────────────────────────────┐
  //  │                 Taka: 6880                   │
  //  ├───────────────────────┬──────────────────────┤
  //  │  500: 13  │  10: 1   │  1 │ 2 │ 3 │ 4       │
  //  │  100:  3  │   5: 0   │  5 │ 6 │ 7 │ 8       │
  //  │   50:  1  │   2: 0   │  9 │ 0 │   CLEAR     │
  //  │   20:  1  │   1: 0   │                       │
  //  └───────────────────────┴──────────────────────┘

  Widget _buildLandscape(BuildContext context) {
    return Column(
      children: [
        AmountDisplay(amount: _amount),
        const Divider(height: 1, thickness: 1),
        Expanded(
          child: Row(
            children: [
              // ── Left: 2-column change breakdown ──
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(AppSizes.cardPadding(context)),
                  child: ChangeTable(change: _change, twoColumn: true),
                ),
              ),
              const VerticalDivider(width: 1, thickness: 1),
              // ── Right: 4-column keypad ──
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(AppSizes.buttonSpacing(context)),
                  child: NumericKeypad(
                    onDigitPressed: _onDigit,
                    onClearPressed: _onClear,
                    isLandscape: true,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
