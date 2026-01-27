import 'package:flutter/material.dart';

extension ColorExtensions on Color {
  Color color1000() {
    final hslColor = HSLColor.fromColor(this);
    return hslColor.withLightness(0.15).toColor();
  }

  Color color900() {
    final hslColor = HSLColor.fromColor(this);
    return hslColor.withLightness(0.20).toColor();
  }

  Color color800() {
    final hslColor = HSLColor.fromColor(this);
    return hslColor.withLightness(0.30).toColor();
  }

  Color color700() {
    final hslColor = HSLColor.fromColor(this);
    return hslColor.withLightness(0.36).toColor();
  }

  Color color600() {
    final hslColor = HSLColor.fromColor(this);
    return hslColor.withLightness(0.45).toColor();
  }

  Color color500() {
    final hslColor = HSLColor.fromColor(this);
    return hslColor.withLightness(0.58).toColor();
  }

  Color color400() {
    final hslColor = HSLColor.fromColor(this);
    return hslColor.withLightness(0.68).toColor();
  }

  Color color300() {
    final hslColor = HSLColor.fromColor(this);
    return hslColor.withLightness(0.78).toColor();
  }

  Color color200() {
    final hslColor = HSLColor.fromColor(this);
    return hslColor.withLightness(0.88).toColor();
  }

  Color color100() {
    final hslColor = HSLColor.fromColor(this);
    return hslColor.withLightness(0.95).toColor();
  }

  Color lightAlpha100() {
    return withValues(alpha: 0.04);
  }

  Color lightAlpha200() {
    return withValues(alpha: 0.08);
  }

  Color lightAlpha300() {
    return withValues(alpha: 0.16);
  }

  Color lightAlpha400() {
    return withValues(alpha: 0.24);
  }

  Color lightAlpha500() {
    return withValues(alpha: 0.32);
  }

  Color lightAlpha600() {
    return withValues(alpha: 0.40);
  }

  Color darkAlpha100() {
    return withValues(
        alpha: 0.04); //TODO Validar com Designer pq está sendo usado outra cor
  }

  Color darkAlpha200() {
    return withValues(alpha: 0.04);
  }

  Color darkAlpha300() {
    return withValues(alpha: 0.08);
  }

  Color darkAlpha400() {
    return withValues(alpha: 0.12);
  }

  Color darkAlpha500() {
    return withValues(alpha: 0.14);
  }

  Color darkAlpha600() {
    return withValues(alpha: 0.20);
  }

  Color alpha100() {
    return withValues(
        alpha: 0.05); //TODO Validar com Designer pq está sendo usado outra cor
  }

  Color alpha200() {
    return withValues(alpha: 0.10);
  }

  Color alpha300() {
    return withValues(alpha: 0.20);
  }

  Color alpha400() {
    return withValues(alpha: 0.40);
  }

  Color alpha500() {
    return withValues(alpha: 0.70);
  }

  Color alpha600() {
    return withValues(alpha: 0.80);
  }

  Color alpha700() {
    return withValues(alpha: 0.85);
  }

  Color alpha800() {
    return withValues(alpha: 0.90);
  }

  Color alpha900() {
    return withValues(alpha: 0.95);
  }
}