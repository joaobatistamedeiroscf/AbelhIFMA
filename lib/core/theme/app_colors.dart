import 'package:flutter/material.dart';

/// Paleta semântica do AbelhIFMA (frame "01 — Design System" no Figma).
abstract final class AppColors {
  // Cores principais
  static const carvao = Color(0xFF11181C);
  static const amarelo = Color(0xFFFFC400);
  static const dourado = Color(0xFFF5A900);
  static const verde = Color(0xFF087F3F);
  static const verdeSecundario = Color(0xFF149447);
  static const branco = Color(0xFFFFFFFF);
  static const fundo = Color(0xFFF5F7F6);
  static const textoSecundario = Color(0xFF667085);
  static const erro = Color(0xFFD92D20);

  // Tons de apoio (fundos de cards, chips e banners)
  static const amareloClaro = Color(0xFFFFF6D6);
  static const verdeClaro = Color(0xFFE8F5EC);
  static const erroClaro = Color(0xFFFDECEA);
  static const cinzaClaro = Color(0xFFE9ECEB);
  static const inativo = Color(0xFF344054);

  // Bordas
  static const borda = Color(0xFFDDE3E0);
  static const bordaInput = Color(0xFFD0D5DD);
}
