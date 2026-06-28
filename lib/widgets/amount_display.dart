import 'package:flutter/material.dart';
import '../utils/app_sizes.dart';

/// Displays "Taka: <amount>" centred at the top of the screen.
class AmountDisplay extends StatelessWidget {
  final String amount;

  const AmountDisplay({super.key, required this.amount});

  @override
  Widget build(BuildContext context) {
    final fontSize = AppSizes.amountFontSize(context);
    final padding = AppSizes.cardPadding(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(padding),
      alignment: Alignment.center,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Taka: ',
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            amount.isEmpty ? '0' : amount,
            style: TextStyle(fontSize: fontSize),
          ),
        ],
      ),
    );
  }
}
