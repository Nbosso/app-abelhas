import 'package:flutter/material.dart';

class AppStyle extends ThemeExtension<AppStyle> {
  AppStyle({
    required this.primaryColor,
    required this.backgroundColor,
    required this.neutralColor,
    required this.neutralAlphaColor,
    required this.successColor,
    required this.errorColor,
    required this.warningColor,
    required this.infoColor,
    required this.defaultBorderColor,
  });
  final Color primaryColor;
  final Color backgroundColor;
  final Color neutralColor;
  final Color neutralAlphaColor;
  final Color successColor;
  final Color errorColor;
  final Color warningColor;
  final Color infoColor;
  final Color defaultBorderColor;

  @override
  ThemeExtension<AppStyle> lerp(
      covariant ThemeExtension<AppStyle>? other, double t) {
    if (other is! AppStyle) {
      return this;
    }
    return AppStyle(
      primaryColor: Color.lerp(primaryColor, other.primaryColor, t)!,
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      neutralColor: Color.lerp(neutralColor, other.neutralColor, t)!,
      neutralAlphaColor:
          Color.lerp(neutralAlphaColor, other.neutralAlphaColor, t)!,
      successColor: Color.lerp(successColor, other.successColor, t)!,
      errorColor: Color.lerp(errorColor, other.errorColor, t)!,
      warningColor: Color.lerp(warningColor, other.warningColor, t)!,
      infoColor: Color.lerp(infoColor, other.infoColor, t)!,
      defaultBorderColor:
          Color.lerp(defaultBorderColor, other.defaultBorderColor, t)!,
    );
  }

  @override
  AppStyle copyWith({
    Color? primaryColor,
    Color? alphaColor,
    Color? backgroundColor,
    Color? neutralColor,
    Color? neutralAlphaColor,
    Color? successColor,
    Color? errorColor,
    Color? warningColor,
    Color? infoColor,
    Color? defaultBorderColor,
  }) {
    return AppStyle(
      primaryColor: primaryColor ?? this.primaryColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      neutralColor: neutralColor ?? this.neutralColor,
      neutralAlphaColor: neutralAlphaColor ?? this.neutralAlphaColor,
      successColor: successColor ?? this.successColor,
      errorColor: errorColor ?? this.errorColor,
      warningColor: warningColor ?? this.warningColor,
      infoColor: infoColor ?? this.infoColor,
      defaultBorderColor: defaultBorderColor ?? this.defaultBorderColor,
    );
  }
}

class AppColorPalette {
  const AppColorPalette({
    required this.color100,
    required this.color200,
    required this.color300,
    required this.color400,
    required this.color500,
    required this.color600,
    required this.color700,
    required this.color800,
    required this.color900,
    required this.color1000,
  });
  final Color color100;
  final Color color200;
  final Color color300;
  final Color color400;
  final Color color500;
  final Color color600;
  final Color color700;
  final Color color800;
  final Color color900;
  final Color color1000;

  // @override
  // List<Object?> get props => [
  //       color100,
  //       color200,
  //       color300,
  //       color400,
  //       color500,
  //       color600,
  //       color700,
  //       color800,
  //       color900,
  //       color1000,
  //     ];
}
