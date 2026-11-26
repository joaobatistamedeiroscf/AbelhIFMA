import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Tons semânticos reutilizados por chips, banners, cards e indicadores.
///
/// Os "Estados operacionais" do Design System: verde (ativa/normal),
/// amarelo (atenção/pendente), vermelho (problema/urgente) e cinza (inativo).
enum TomVisual {
  amarelo(AppColors.amareloClaro, AppColors.dourado),
  verde(AppColors.verdeClaro, AppColors.verde),
  vermelho(AppColors.erroClaro, AppColors.erro),
  cinza(AppColors.cinzaClaro, AppColors.inativo),
  escuro(AppColors.carvao, AppColors.amarelo);

  const TomVisual(this.fundo, this.destaque);

  /// Cor de fundo suave.
  final Color fundo;

  /// Cor de ícones, pontos e textos sobre [fundo].
  final Color destaque;

  /// Cor de texto principal sobre [fundo].
  Color get texto => this == TomVisual.escuro ? AppColors.branco : AppColors.carvao;
}
