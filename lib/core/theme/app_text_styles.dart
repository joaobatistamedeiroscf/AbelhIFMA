import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Tipografia Inter definida no Design System.
abstract final class AppTextStyles {
  /// Saudações e títulos de destaque ("Olá, João!").
  static const display = TextStyle(
    fontFamily: 'Inter',
    fontSize: 26,
    fontWeight: FontWeight.w700,
    height: 1.2,
    color: AppColors.carvao,
  );

  static const title = TextStyle(
    fontFamily: 'Inter',
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColors.carvao,
  );

  /// Valores numéricos dos cards de estatística.
  static const statValue = TextStyle(
    fontFamily: 'Inter',
    fontSize: 22,
    fontWeight: FontWeight.w700,
    height: 1.2,
    color: AppColors.carvao,
  );

  static const subtitle = TextStyle(
    fontFamily: 'Inter',
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.carvao,
  );

  /// Título de cards e itens de lista.
  static const cardTitle = TextStyle(
    fontFamily: 'Inter',
    fontSize: 15,
    fontWeight: FontWeight.w700,
    height: 1.3,
    color: AppColors.carvao,
  );

  static const body = TextStyle(
    fontFamily: 'Inter',
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.5,
    color: AppColors.carvao,
  );

  static const bodyMedium = TextStyle(
    fontFamily: 'Inter',
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.5,
    color: AppColors.carvao,
  );

  static const caption = TextStyle(
    fontFamily: 'Inter',
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.33,
    color: AppColors.textoSecundario,
  );

  /// Rótulo pequeno dos campos de formulário ("Nome do apiário").
  static const label = TextStyle(
    fontFamily: 'Inter',
    fontSize: 11,
    fontWeight: FontWeight.w500,
    height: 1.2,
    color: AppColors.textoSecundario,
  );
}
