import 'package:app_abelhas/core/extensions/color_extension.dart';
import 'package:app_abelhas/core/theme/app_primitive_colors.dart';
import 'package:app_abelhas/core/theme/app_spacing.dart';
import 'package:app_abelhas/core/theme/app_style.dart';
import 'package:app_abelhas/core/theme/app_text_style.dart';
import 'package:app_abelhas/core/theme/font/app_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  static ThemeData buildTheme(
    bool isDarkMode,
  ) {
    final theme = isDarkMode ? _buildDarkTheme() : _buildLightTheme();
    return theme;
  }

  static ThemeData _buildLightTheme() {
    final lightTheme = _buildTheme(
      isDarkMode: false,
      primaryColor: Colors.green.shade600,
      neutralColor: AppPrimitiveColors.lightNeutral,
      neutralAlphaColor: AppPrimitiveColors.neutralAlphaLight,
      backgroundColor: AppPrimitiveColors.white,
      successColor: AppPrimitiveColors.green.color600(),
      errorColor: AppPrimitiveColors.red.color600(),
      warningColor: AppPrimitiveColors.orange.color600(),
      infoColor: AppPrimitiveColors.blue.color600(),
      colorScheme: ColorScheme.light(),
      brightness: Brightness.light,
      defaultBorderColor: AppPrimitiveColors.lightNeutral.color300(),
    );
    return lightTheme;
  }

  static ThemeData _buildDarkTheme() {
    //TODO Decidir com o Designer quais cores serão utilizadas no modo escuro
    final darkTheme = _buildTheme(
      isDarkMode: true,
      primaryColor: Colors.green.shade600,
      neutralColor: AppPrimitiveColors.darkNeutral,
      neutralAlphaColor: AppPrimitiveColors.neutralAlphaDark,
      backgroundColor: AppPrimitiveColors.black,
      successColor: AppPrimitiveColors.green,
      errorColor: AppPrimitiveColors.red,
      warningColor: AppPrimitiveColors.orange,
      infoColor: AppPrimitiveColors.blue,
      colorScheme: ColorScheme.light(
        surface: AppPrimitiveColors.black,
      ),
      brightness: Brightness.dark,
      defaultBorderColor: AppPrimitiveColors.darkNeutral.color400(),
    );
    return darkTheme;
  }

  static ThemeData _buildTheme({
    required bool isDarkMode,
    required Color primaryColor,
    required Color neutralColor,
    required Color neutralAlphaColor,
    required Color backgroundColor,
    required Color successColor,
    required Color errorColor,
    required Color warningColor,
    required Color infoColor,
    required Color defaultBorderColor,
    required ColorScheme colorScheme,
    required Brightness brightness,
  }) {
    final ThemeData baseTheme = ThemeData(
      fontFamily: AppFont.lato,
      brightness: brightness,
    );
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: backgroundColor,
      statusBarColor: AppPrimitiveColors.transparent,
      systemNavigationBarDividerColor: AppPrimitiveColors.transparent,
      systemStatusBarContrastEnforced: true,
      systemNavigationBarIconBrightness:
          isDarkMode ? Brightness.light : Brightness.dark,
    ));
    return baseTheme.copyWith(
      cardColor: AppPrimitiveColors.white,
      splashColor: AppPrimitiveColors.transparent,
      scaffoldBackgroundColor: backgroundColor,
      primaryColor: primaryColor,
      timePickerTheme: TimePickerThemeData(
        backgroundColor: backgroundColor,
        dialHandColor: primaryColor,
        dialBackgroundColor: primaryColor.color100(),
        hourMinuteTextColor: neutralColor,
        hourMinuteColor: primaryColor.color100(),
      ),
      shadowColor: neutralColor.color700(),
      appBarTheme: baseTheme.appBarTheme.copyWith(
        elevation: 0.2,
        shadowColor: neutralColor.color700().withAlpha(120),
        centerTitle: true,
        backgroundColor: backgroundColor,
        foregroundColor: neutralColor,
        // actionsPadding: EdgeInsets.only(right: SeventhAppSpacing.p8),
        titleTextStyle: AppTextStyle.titleMedium(neutralColor),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      radioTheme: baseTheme.radioTheme.copyWith(
        fillColor: WidgetStateProperty.all(primaryColor),
      ),
      dividerTheme: DividerThemeData(color: defaultBorderColor),
      textTheme: baseTheme.textTheme.copyWith(
        displayLarge: AppTextStyle.displayLarge(neutralColor),
        displayMedium: AppTextStyle.displayMedium(neutralColor),
        displaySmall: AppTextStyle.displaySmall(neutralColor),
        headlineLarge: AppTextStyle.headlineLarge(neutralColor),
        headlineMedium: AppTextStyle.headlineMedium(neutralColor),
        headlineSmall: AppTextStyle.headlineSmall(neutralColor),
        titleLarge: AppTextStyle.titleLarge(neutralColor),
        titleMedium: AppTextStyle.titleMedium(neutralColor),
        titleSmall: AppTextStyle.titleSmall(neutralColor),
        bodyLarge: AppTextStyle.bodyLarge(neutralColor),
        bodyMedium: AppTextStyle.bodyMedium(neutralColor),
        bodySmall: AppTextStyle.bodySmall(neutralColor),
        labelLarge: AppTextStyle.labelLarge(neutralColor),
        labelMedium: AppTextStyle.labelMedium(neutralColor),
        labelSmall: AppTextStyle.labelSmall(neutralColor),
      ),
      checkboxTheme: CheckboxThemeData(
          checkColor: WidgetStateProperty.all(backgroundColor),
          side: BorderSide(color: neutralColor.color600(), width: 2)),
      dialogTheme: baseTheme.dialogTheme.copyWith(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        titleTextStyle: AppTextStyle.titleMedium(
          neutralColor,
        ),
      ),
      textSelectionTheme: baseTheme.textSelectionTheme.copyWith(
        cursorColor: neutralColor,
      ),
      inputDecorationTheme: baseTheme.inputDecorationTheme.copyWith(
        labelStyle: AppTextStyle.bodySmall(
          neutralColor,
        ),
        hintStyle: AppTextStyle.bodyMedium(
          neutralColor.color700(),
        ),
        errorStyle: AppTextStyle.bodyMedium(
          errorColor,
        ),
        filled: true,
        fillColor: backgroundColor,
        floatingLabelStyle: AppTextStyle.bodySmall(
          neutralColor,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.p8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: defaultBorderColor,
          ),
        ),
        suffixIconColor: neutralColor,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: defaultBorderColor,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: errorColor,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: defaultBorderColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: defaultBorderColor,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: errorColor,
          ),
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: backgroundColor,
      ),
      bottomNavigationBarTheme: baseTheme.bottomNavigationBarTheme.copyWith(
        backgroundColor: backgroundColor,
        selectedItemColor: primaryColor,
        unselectedItemColor: neutralColor,
        unselectedLabelStyle: AppTextStyle.labelSmall(
          neutralColor,
        ),
        selectedLabelStyle: AppTextStyle.labelSmall(
          primaryColor,
        ),
        elevation: 0,
      ),
      dropdownMenuTheme: DropdownMenuThemeData(
        inputDecorationTheme: InputDecorationTheme(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          floatingLabelAlignment: FloatingLabelAlignment.center,
          labelStyle: AppTextStyle.bodySmall(
            neutralColor,
          ),
          hintStyle: AppTextStyle.bodyMedium(
            neutralColor.color700(),
          ),
          errorStyle: AppTextStyle.bodyMedium(
            errorColor,
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          textStyle: AppTextStyle.bodyMedium(neutralColor),
          foregroundColor: AppPrimitiveColors.white,
          backgroundColor: primaryColor,
          disabledBackgroundColor: neutralAlphaColor.lightAlpha100(),
          disabledForegroundColor: neutralAlphaColor.lightAlpha300(),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          backgroundColor: primaryColor,
        ),
      ),
      listTileTheme: baseTheme.listTileTheme.copyWith(
        textColor: neutralColor,
      ),
      colorScheme: baseTheme.colorScheme.copyWith(
        primary: neutralColor,
      ),
      scrollbarTheme: baseTheme.scrollbarTheme.copyWith(
          thumbColor: WidgetStateProperty.all(primaryColor),
          thickness: WidgetStateProperty.all(4)),
      dividerColor: defaultBorderColor,
      canvasColor: backgroundColor,
      expansionTileTheme: ExpansionTileThemeData(
          backgroundColor: backgroundColor,
          collapsedBackgroundColor: backgroundColor,
          iconColor: neutralColor,
          collapsedIconColor: neutralColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          collapsedShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textColor: neutralColor,
          collapsedTextColor: neutralColor),
      extensions: <ThemeExtension<dynamic>>[
        AppStyle(
          primaryColor: primaryColor,
          backgroundColor: backgroundColor,
          neutralColor: neutralColor,
          neutralAlphaColor: neutralAlphaColor,
          successColor: successColor,
          errorColor: errorColor,
          warningColor: warningColor,
          infoColor: infoColor,
          defaultBorderColor: defaultBorderColor,
        )
      ],
    );
  }
}
