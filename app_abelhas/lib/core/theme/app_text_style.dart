import 'package:app_abelhas/core/theme/font/app_font_size.dart';
import 'package:app_abelhas/core/theme/font/app_font_weight.dart';
import 'package:app_abelhas/core/theme/font/app_letter_spacing.dart';
import 'package:app_abelhas/core/theme/font/app_line_height.dart';
import 'package:flutter/material.dart';

class AppTextStyle {
  static TextStyle displayLarge(Color color) => TextStyle(
        fontSize: AppFontSize.fontSize1300,
        fontWeight: AppFontWeight.black,
        letterSpacing: AppLetterSpacing.letterSpacing300,
        height: AppLineHeight.lineHeight100,
        color: color,
      );

  static TextStyle displayMedium(Color color) => TextStyle(
        fontSize: AppFontSize.fontSize1200,
        fontWeight: AppFontWeight.bold,
        letterSpacing: AppLetterSpacing.letterSpacing300,
        height: AppLineHeight.lineHeight100,
        color: color,
      );

  static TextStyle displaySmall(Color color) => TextStyle(
        fontSize: AppFontSize.fontSize900,
        fontWeight: AppFontWeight.black,
        letterSpacing: AppLetterSpacing.letterSpacing300,
        height: AppLineHeight.lineHeight100,
        color: color,
      );

  static TextStyle headlineLarge(Color color) => TextStyle(
        fontSize: AppFontSize.fontSize800,
        fontWeight: AppFontWeight.regular,
        letterSpacing: AppLetterSpacing.letterSpacing200,
        height: AppLineHeight.lineHeight100,
        color: color,
      );

  static TextStyle headlineMedium(Color color) => TextStyle(
        fontSize: AppFontSize.fontSize700,
        fontWeight: AppFontWeight.regular,
        letterSpacing: AppLetterSpacing.letterSpacing200,
        height: AppLineHeight.lineHeight100,
        color: color,
      );

  static TextStyle headlineSmall(Color color) => TextStyle(
        fontSize: AppFontSize.fontSize600,
        fontWeight: AppFontWeight.regular,
        letterSpacing: AppLetterSpacing.letterSpacing200,
        height: AppLineHeight.lineHeight100,
        color: color,
      );

  static TextStyle titleLarge(Color color) => TextStyle(
        fontSize: AppFontSize.fontSize500,
        fontWeight: AppFontWeight.medium,
        letterSpacing: AppLetterSpacing.letterSpacing200,
        height: AppLineHeight.lineHeight200,
        color: color,
      );

  static TextStyle titleMedium(Color color) => TextStyle(
        fontSize: AppFontSize.fontSize400,
        fontWeight: AppFontWeight.semiBold,
        letterSpacing: AppLetterSpacing.letterSpacing200,
        height: AppLineHeight.lineHeight300,
        color: color,
      );

  static TextStyle titleSmall(Color color) => TextStyle(
        fontSize: AppFontSize.fontSize300,
        fontWeight: AppFontWeight.semiBold,
        letterSpacing: AppLetterSpacing.letterSpacing200,
        height: AppLineHeight.lineHeight400,
        color: color,
      );

  static TextStyle labelLargeStrong(Color color) => TextStyle(
        fontSize: AppFontSize.fontSize300,
        fontWeight: AppFontWeight.bold,
        letterSpacing: AppLetterSpacing.letterSpacing300,
        height: AppLineHeight.lineHeight200,
        color: color,
      );

  static TextStyle labelLarge(Color color) => TextStyle(
        fontSize: AppFontSize.fontSize300,
        fontWeight: AppFontWeight.medium,
        letterSpacing: AppLetterSpacing.letterSpacing300,
        height: AppLineHeight.lineHeight200,
        color: color,
      );

  static TextStyle labelMediumStrong(Color color) => TextStyle(
        fontSize: AppFontSize.fontSize200,
        fontWeight: AppFontWeight.bold,
        letterSpacing: AppLetterSpacing.letterSpacing300,
        height: AppLineHeight.lineHeight200,
        color: color,
      );

  static TextStyle labelMedium(Color color) => TextStyle(
        fontSize: AppFontSize.fontSize200,
        fontWeight: AppFontWeight.medium,
        letterSpacing: AppLetterSpacing.letterSpacing300,
        height: AppLineHeight.lineHeight200,
        color: color,
      );

  static TextStyle labelSmall(Color color) => TextStyle(
        fontSize: AppFontSize.fontSize100,
        fontWeight: AppFontWeight.medium,
        letterSpacing: AppLetterSpacing.letterSpacing300,
        height: AppLineHeight.lineHeight200,
        color: color,
      );

  static TextStyle bodyLargeStrong(Color color) => TextStyle(
        fontSize: AppFontSize.fontSize400,
        fontWeight: AppFontWeight.bold,
        letterSpacing: AppLetterSpacing.letterSpacing200,
        height: AppLineHeight.lineHeight300,
        color: color,
      );

  static TextStyle bodyLarge(Color color) => TextStyle(
        fontSize: AppFontSize.fontSize400,
        fontWeight: AppFontWeight.regular,
        letterSpacing: AppLetterSpacing.letterSpacing200,
        height: AppLineHeight.lineHeight300,
        color: color,
      );

  static TextStyle bodyMediumStrong(Color color) => TextStyle(
        fontSize: AppFontSize.fontSize300,
        fontWeight: AppFontWeight.bold,
        letterSpacing: AppLetterSpacing.letterSpacing200,
        height: AppLineHeight.lineHeight400,
        color: color,
      );

  static TextStyle bodyMedium(Color color) => TextStyle(
        fontSize: AppFontSize.fontSize300,
        fontWeight: AppFontWeight.regular,
        letterSpacing: AppLetterSpacing.letterSpacing200,
        height: AppLineHeight.lineHeight400,
        color: color,
      );

  static TextStyle bodySmallStrong(Color color) => TextStyle(
        fontSize: AppFontSize.fontSize200,
        fontWeight: AppFontWeight.bold,
        letterSpacing: AppLetterSpacing.letterSpacing300,
        height: AppLineHeight.lineHeight500,
        color: color,
      );

  static TextStyle bodySmall(Color color) => TextStyle(
        fontSize: AppFontSize.fontSize200,
        fontWeight: AppFontWeight.regular,
        letterSpacing: AppLetterSpacing.letterSpacing300,
        height: AppLineHeight.lineHeight500,
        color: color,
      );
}
