import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_radius.dart';
import 'app_text_styles.dart';

abstract final class AppTheme {
  static ThemeData light = ThemeData(
    useMaterial3: true,

    // Cores
    scaffoldBackgroundColor: AppColors.fundo,

    colorScheme: const ColorScheme.light(
      primary: AppColors.verde,
      secondary: AppColors.amarelo,
      error: AppColors.erro,
      surface: AppColors.branco,
      onPrimary: AppColors.branco,
      onSecondary: AppColors.carvao,
      onSurface: AppColors.carvao,
    ),

    // Tipografia
    fontFamily: 'Inter',

    textTheme: const TextTheme(
      titleLarge: AppTextStyles.title,
      titleMedium: AppTextStyles.subtitle,
      bodyLarge: AppTextStyles.body,
      bodyMedium: AppTextStyles.bodyMedium,
      bodySmall: AppTextStyles.caption,
    ),

    // AppBar
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.fundo,
      foregroundColor: AppColors.carvao,
      elevation: 0,
      centerTitle: false,
    ),

    // Campos de texto
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.branco,

      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
      ),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(AppRadius.button),
        ),
        borderSide: const BorderSide(
          color: Color(0xFFD0D5DD),
        ),
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(AppRadius.button),
        ),
        borderSide: const BorderSide(
          color: Color(0xFFD0D5DD),
        ),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(AppRadius.button),
        ),
        borderSide: BorderSide(
          color: AppColors.verde,
          width: 2,
        ),
      ),

      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(AppRadius.button),
        ),
        borderSide: BorderSide(
          color: AppColors.erro,
        ),
      ),
    ),

    // Botões elevados
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.amarelo,
        foregroundColor: AppColors.carvao,

        minimumSize: const Size(
          double.infinity,
          44,
        ),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            AppRadius.button,
          ),
        ),

        textStyle: AppTextStyles.bodyMedium,
      ),
    ),

    // Botões de texto
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.verde,
        textStyle: AppTextStyles.bodyMedium,
      ),
    ),
  );
}