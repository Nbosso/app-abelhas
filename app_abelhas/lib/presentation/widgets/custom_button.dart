import 'package:app_abelhas/core/extensions/color_extension.dart';
import 'package:app_abelhas/core/theme/app_spacing.dart';
import 'package:app_abelhas/core/theme/app_style.dart';
import 'package:app_abelhas/core/theme/app_text_style.dart';
import 'package:app_abelhas/core/theme/font/app_font_weight.dart';
import 'package:flutter/material.dart';

enum CustomButtonType {
  primary,
  secondary,
  disabled,
  outline,
}

class CustomButtonWidget extends StatelessWidget {
  const CustomButtonWidget({
    super.key,
    required this.type,
    required this.label,
    required this.onPressed,
    this.isLarge = true,
    this.isLoading = false,
    this.isBold = false,
    this.isInfinityWidth = true,
    this.icon,
  });
  final CustomButtonType type;
  final String label;
  final Function() onPressed;
  final bool isLarge;
  final bool isLoading;
  final Widget? icon;
  final bool isInfinityWidth;
  final bool isBold;

  ButtonStyle _getStyleByType(BuildContext context, AppStyle appStyle) {
    final ButtonStyle? buttonStyle =
        Theme.of(context).elevatedButtonTheme.style;

    switch (type) {
      case CustomButtonType.primary:
        return ElevatedButton.styleFrom(
          backgroundColor: appStyle.primaryColor,
          foregroundColor: Colors.white,
        );
      case CustomButtonType.secondary:
        return ElevatedButton.styleFrom(
          backgroundColor: appStyle.neutralAlphaColor.alpha100(),
          foregroundColor: appStyle.neutralColor.color1000(),
          side: BorderSide(color: appStyle.neutralColor.color200()),
        );
      case CustomButtonType.disabled:
        return ElevatedButton.styleFrom(
          backgroundColor:
              buttonStyle?.backgroundColor?.resolve({WidgetState.disabled}),
          foregroundColor:
              buttonStyle?.foregroundColor?.resolve({WidgetState.disabled}),
        );
      case CustomButtonType.outline:
        return ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: appStyle.neutralColor.color1000(),
          textStyle:
              AppTextStyle.bodyMediumStrong(appStyle.neutralColor.color1000()),
          side: BorderSide(color: appStyle.primaryColor),
        );
    }
  }

  Function()? _getOnPressedByType() {
    if (isLoading) {
      return () {};
    }
    switch (type) {
      case CustomButtonType.primary:
      case CustomButtonType.secondary:
      case CustomButtonType.outline:
        return onPressed;
      case CustomButtonType.disabled:
        return null;
    }
  }

  Widget _getLoadingByType(AppStyle appStyle) {
    return CircularProgressIndicator(
      strokeWidth: 2,
      backgroundColor: appStyle.backgroundColor,
      valueColor:
          AlwaysStoppedAnimation<Color>(appStyle.primaryColor.color700()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appStyle = Theme.of(context).extension<AppStyle>()!;
    final textStyle = Theme.of(context).textTheme;
    final largeHeight = 48.0;
    final smallHeight = 40.0;
    final buttonStyle = _getStyleByType(context, appStyle);
    return SizedBox(
      key: UniqueKey(),
      width: isInfinityWidth ? double.maxFinite : null,
      height: isLarge ? largeHeight : smallHeight,
      child: ElevatedButton(
          style: buttonStyle,
          onPressed: _getOnPressedByType(),
          child: Visibility(
            visible: !isLoading,
            replacement: SizedBox(
                height: isLarge ? largeHeight * 0.625 : smallHeight * 0.625,
                width: isLarge ? largeHeight * 0.625 : smallHeight * 0.625,
                child: _getLoadingByType(appStyle)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Visibility(
                  visible: icon != null,
                  child: Padding(
                    padding: const EdgeInsets.only(right: AppSpacing.p4),
                    child: icon,
                  ),
                ),
                Text(
                  label,
                  style: textStyle.bodyMedium?.copyWith(
                    fontWeight:
                        isBold ? AppFontWeight.bold : AppFontWeight.regular,
                    color: buttonStyle.foregroundColor?.resolve({}),
                  ),
                  textHeightBehavior: const TextHeightBehavior(
                    applyHeightToFirstAscent: false,
                    applyHeightToLastDescent: false,
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
