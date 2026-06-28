import 'package:flutter/material.dart';
import '../utils/change_calculator.dart';
import '../utils/app_sizes.dart';

/// Shows how many of each Taka note is needed.
///
/// [twoColumn] = false → portrait (single column, 8 rows)
/// [twoColumn] = true  → landscape (two columns, 4 rows each)
class ChangeTable extends StatelessWidget {
  final Map<int, int> change;
  final bool twoColumn;

  const ChangeTable({
    super.key,
    required this.change,
    this.twoColumn = false,
  });

  @override
  Widget build(BuildContext context) {
    final denoms = ChangeCalculator.denominations;
    final fontSize = AppSizes.labelFontSize(context);
    final padding = AppSizes.cardPadding(context);

    if (twoColumn) {
      // Landscape: split 8 denominations into two equal columns
      // Left  → 500, 100, 50, 20
      // Right → 10, 5, 2, 1
      final half = denoms.length ~/ 2;
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: _buildColumn(denoms.sublist(0, half), fontSize, padding),
          ),
          Expanded(
            child: _buildColumn(denoms.sublist(half), fontSize, padding),
          ),
        ],
      );
    }

    // Portrait: single column
    return _buildColumn(denoms, fontSize, padding);
  }

  Widget _buildColumn(
    List<int> denoms,
    double fontSize,
    double padding,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: denoms.map((denom) {
        return Padding(
          padding: EdgeInsets.symmetric(
            vertical: padding / 2,
            horizontal: padding,
          ),
          child: Text(
            '$denom: ${change[denom] ?? 0}',
            style: TextStyle(fontSize: fontSize),
          ),
        );
      }).toList(),
    );
  }
}
