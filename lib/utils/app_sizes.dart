import 'package:flutter/material.dart';

/// Flutter equivalent of res/values/sizes.xml.
///
/// All pixel/font/spacing values are centralised here.
/// Widgets never hardcode numeric sizes — they always call AppSizes.
abstract class AppSizes {
  // ── Device detection ──────────────────────────────────────────
  /// Returns true when the device's shortest side is ≥ 600 dp
  /// (matches Android's sw600dp "tablet" resource qualifier).
  static bool isTablet(BuildContext context) =>
      MediaQuery.sizeOf(context).shortestSide >= 600;

  // ── Font sizes ────────────────────────────────────────────────
  /// Font size for the "Taka: X" display at the top.
  static double amountFontSize(BuildContext context) =>
      isTablet(context) ? 30.0 : 22.0;

  /// Font size for rows in the change breakdown table.
  static double labelFontSize(BuildContext context) =>
      isTablet(context) ? 18.0 : 14.0;

  /// Font size for keypad digit/CLEAR button labels.
  static double buttonFontSize(BuildContext context) =>
      isTablet(context) ? 22.0 : 16.0;

  // ── Spacing ───────────────────────────────────────────────────
  /// Padding around the change table and amount display areas.
  static double cardPadding(BuildContext context) =>
      isTablet(context) ? 14.0 : 8.0;

  /// Gap between individual keypad buttons.
  static double buttonSpacing(BuildContext context) =>
      isTablet(context) ? 6.0 : 3.0;

  // ── Misc ──────────────────────────────────────────────────────
  /// Corner radius for keypad buttons.
  static double buttonRadius(BuildContext context) =>
      isTablet(context) ? 10.0 : 6.0;
}
